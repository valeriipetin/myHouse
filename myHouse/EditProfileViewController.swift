//
//  EditProfileViewController.swift
//  myHouse
//
//  Created by Valera Petin on 14.02.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var databaseRef: FIRDatabaseReference!
    var userStorage: FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //слайд-меню
        menuButton.target = revealViewController()
        menuButton.action = Selector(("revealToggle:"))
        
        //свайп слева на право
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        //Прозрачный  Navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        
        //Кнопка выхода
        //create a new button
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "logOut.png"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(ProfileViewController.logOutButtonPressed), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        
        databaseRef = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "gs://myhouse-85275.appspot.com/")
        
        userStorage = storage.child("users")
        
        //Загрузка данных профиля пользователя
        loadProfileData()
        
        self.username.delegate = self
        self.phone.delegate = self
        
        createToolbar()
    }

    //Кнопка Готово, которая прячет клавиатуру
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        toolBar.tintColor = .black
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain , target: self, action: #selector(SingUpViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        username.inputAccessoryView = toolBar
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    
    //Загружаем фото
    @IBAction func getPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        //Изображение будет доступно для редактирования(масштабирование)
        picker.allowsEditing = true
        
        let alertController = UIAlertController(title: "Сменить фото профиля", message: "Выберите", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Сфотографировать", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
                picker.modalPresentationStyle = .fullScreen
                self.present(picker, animated: true, completion: nil)
            }else {
             self.noCameraErrorAlert(title: "Ошибка!", message: "Камера не найдена.")
            }
            
        }
        
        let photoLiraryAction = UIAlertAction(title: "Выбрать из Фотопленки", style: .default) { (action) in
            
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLiraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)

}
    
    //Ошибка, если нет камеры
    func noCameraErrorAlert(title: String, message: String) {
        
        // Всплывающее окно ошибки
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    
    //Что происходит, когда пользователь выбирает фотографию?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //сохраняем редактированное изображение в переменную UIImage
        if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage {
        
        //обновляем изображение
        profileImageView.image = chosenImage
            
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //Что происходит, когда пользователь нажимает "отмена"?
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

    @IBAction func saveProfileData(_ sender: Any) {
        
        //Обновляем профиль
        updateUsersProfile()
    }
    
    
    //Редактируем профиль
    func updateUsersProfile() {
        
        //показать индикатор загрузки
        AppDelegate.instance().showActivityIndicator()
        
        //если пользователь вошел в систему
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
        //создаем хранилище в FirebaseStorage
            let storageItem = self.userStorage.child("\(userID).jpg")
            
        //получить изображение из библиотеки фотографий
            guard let image = profileImageView.image else {return}
            
            if let newImage = UIImageJPEGRepresentation(image, 0.6){
                
        //загрузить в FirebaseStorage
                storageItem.put(newImage, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    storageItem.downloadURL(completion: {(url, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
            
                        //Запись поля Имя в photoURL
                        let changeRequest = FIRAuth.auth()!.currentUser!.profileChangeRequest()
                        changeRequest.photoURL = url
                        changeRequest.commitChanges(completion: nil)
        
                        if let profilePhotoURL = url?.absoluteString{
                            guard let newUserName = self.username.text else {return}
                            guard let newPhone = self.phone.text else {return}
                            
                            
                            let newValuesForProfile =
                            ["photo": profilePhotoURL, "username": newUserName, "phone": newPhone]
                            
                            //обновить базу данных для пользователя
                            self.databaseRef.child("users").child(userID).updateChildValues(newValuesForProfile, withCompletionBlock: {(error, ref) in
                                
                                //послезагрузки изображения индикатор исчезнет
                                AppDelegate.instance().dismissActivityIndicators()
                                
                                if error != nil{
                                    print(error!)
                                    return
                                }
                            })
                        }
                    })
                })
        }
    }
}
    
    
    
    //Загружаем данные с базы данных
    func loadProfileData() {
        
        //если пользователь вошел в систему
        if let userID = FIRAuth.auth()?.currentUser?.uid{
            
            databaseRef.child("users").child(userID).observe(.value, with: {(snapshot) in
                
                //создать словарь данных профиля пользователя
                let values = snapshot.value as? [String: Any]
                
                
                let email = values?["email"] as? String
                
                //если есть ссылка на изображение, то оно хранится в photo
                if let profileImageURL = values?["photo"] as? String {
                    
                    
                    //используя sd_setImage фото загружается
                    self.profileImageView.sd_setImage(with: URL(string: profileImageURL), placeholderImage: UIImage(named: "user_placeholder.png"))
                }
                
                self.username.text = values?["username"] as? String
                self.phone.text = values?["phone"] as? String
                self.email.text = email
            })
        }
    }


    //Скрывать клавиатуру, когда пользователь коснется выше неё
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
    }

    //Скрывать клавиатуру, когда пользователь коснется return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return(true)
    }
    
    //Выход из учётной записи
    func logOutButtonPressed() {
        loginErrorAlert()
    }
    
    //Всплывающее окно о выходе
    func loginErrorAlert() {
        
        //Создаём всплывающее окно
        //Заголовок
        let alert = UIAlertController(title: "", message: "Вы уверены, что хотите выйти?", preferredStyle: UIAlertControllerStyle.alert)
        
        //Кнопка ДА с действием
        let actionYes = UIAlertAction(title: "Да", style: .default, handler: { action in
            
            if FIRAuth.auth()?.currentUser != nil {
                
                do {
                    
                    try FIRAuth.auth()?.signOut()
                    
                    // FBSDKAccessToken.setCurrent(nil)
                    
                    let LoginViewController = self.storyboard!.instantiateViewController(withIdentifier: "Login")
                    UIApplication.shared.keyWindow?.rootViewController = LoginViewController
                    
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        
        //Кнопка нет
        let actionNo = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        
        //Добовляем кнопки
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        
        //Показать всплывающее окно
        present(alert, animated: true, completion: nil)
    }
    
}
