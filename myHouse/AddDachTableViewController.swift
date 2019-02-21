//
//  AddDachTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 31.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddDachTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var el: UILabel!
    @IBOutlet weak var elCntrl: UISwitch!
    @IBOutlet weak var vod: UILabel!
    @IBOutlet weak var vodCntrl: UISwitch!
    @IBOutlet weak var gas: UILabel!
    @IBOutlet weak var gasCntrl: UISwitch!
    @IBOutlet weak var posadki: UILabel!
    @IBOutlet weak var posadkiCntrl: UISwitch!
    @IBOutlet weak var ban: UILabel!
    @IBOutlet weak var banCntrl: UISwitch!
    @IBOutlet weak var can: UILabel!
    @IBOutlet weak var canCntrl: UISwitch!
    @IBOutlet weak var garage: UILabel!
    @IBOutlet weak var garageCntrl: UISwitch!
    @IBOutlet weak var tepl: UILabel!
    @IBOutlet weak var teplCntrl: UISwitch!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var detailDachType: UILabel!
    @IBOutlet weak var detailAvt: UILabel!
    @IBOutlet weak var detailuserTypeLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    
    @IBOutlet weak var tg: UILabel!
    @IBOutlet weak var tgCntrl: UISwitch!
    
    @IBOutlet weak var years: UITextField!
    @IBOutlet weak var fullArea: UITextField!
    @IBOutlet weak var gaArea: UITextField!
    
    @IBOutlet weak var property: UITextField!
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var profileImage: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Кнопка назад без названия
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.nameTextField.delegate = self
        self.years.delegate = self
        self.fullArea.delegate = self
        self.gaArea.delegate = self
        self.property.delegate = self
        self.price.delegate = self
        self.nameUser.delegate = self
        self.phone.delegate = self
        self.email.delegate = self
        
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
        
        nameTextField.inputAccessoryView = toolBar
        years.inputAccessoryView = toolBar
        fullArea.inputAccessoryView = toolBar
        gaArea.inputAccessoryView = toolBar
        property.inputAccessoryView = toolBar
        price.inputAccessoryView = toolBar
        nameUser.inputAccessoryView = toolBar
        phone.inputAccessoryView = toolBar
        email.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    //Тип объекта
    var type:String = "Выбрать" {
        didSet {
            detailDachType.text? = type
        }
    }
    
    //Автобусная остановка
    var avt:String = "Выбрать" {
        didSet {
            detailAvt.text? = avt
        }
    }
    
    //Тип пользователя
    var userType:String = "Выбрать" {
        didSet {
            detailuserTypeLabel.text? = userType
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit PlayerDetailsViewController")
    }
    
    //для того чтобы выходила виртуальная клавиатура
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DachPickType" {
            if let typePickerViewController = segue.destination as? DachTypeTableViewController {
                typePickerViewController.selectedType = type
            }
        }
        if segue.identifier == "DachPickAvt" {
            if let avtPickerViewController = segue.destination as? DachAvtTableViewController {
                avtPickerViewController.selectedavt = avt
            }
        }
        if segue.identifier == "DachPickUserType" {
            if let userTypePickerViewController = segue.destination as? DachUserTypeTableViewController {
                userTypePickerViewController.selecteduserType = userType
            }
        }
        
    }
    
    
    
    //Unwind type segue
    @IBAction func unwindWithSelectedDachType(_ segue:UIStoryboardSegue) {
        if let typePickerViewController = segue.source as? DachTypeTableViewController,
            let selectedType = typePickerViewController.selectedType {
            type = selectedType
        }
    }
    
    //Unwind avt segue
    @IBAction func unwindWithSelectedDachAvt(_ segue:UIStoryboardSegue) {
        if let avtPickerViewController = segue.source as? DachAvtTableViewController,
            let selectedavt = avtPickerViewController.selectedavt {
            avt = selectedavt
        }
    }
    
    //Unwind userType segue
    @IBAction func unwindWithSelectedDachUserType(_ segue:UIStoryboardSegue) {
        if let userTypePickerViewController = segue.source as? DachUserTypeTableViewController,
            let selecteduserType = userTypePickerViewController.selecteduserType {
            userType = selecteduserType
        }
    }
    
    
    
    //Switch controllers
    @IBAction func electric(_ sender: Any) {
        
        if elCntrl.isOn
        {
            el.text = "Есть"
        } else {
            el.text = "Отсутствует"
        }

    }

    @IBAction func voda(_ sender: Any) {
        
        if vodCntrl.isOn == true
        {
            vod.text = "Есть"
        }else {
            vod.text = "Отсутствует"
        }

    }
 
    @IBAction func gas(_ sender: Any) {
        
        if gasCntrl.isOn == true
        {
            gas.text = "Есть"
        }else {
            gas.text = "Отсутствует"
        }

    }
    
    @IBAction func posadki(_ sender: Any) {
        
        if posadkiCntrl.isOn == true
        {
            posadki.text = "Есть"
        }else {
            posadki.text = "Отсутствует"
        }

    }
    
    @IBAction func ban(_ sender: Any) {
        
        if banCntrl.isOn == true
        {
            ban.text = "Есть"
        }else {
            ban.text = "Отсутствует"
        }

    }
    
    @IBAction func can(_ sender: Any) {
        
        if canCntrl.isOn == true
        {
            can.text = "Есть"
        }else {
            can.text = "Отсутствует"
        }

    }
    
    @IBAction func garage(_ sender: Any) {
        
        if garageCntrl.isOn == true
        {
            garage.text = "Есть"
        }else {
            garage.text = "Отсутствует"
        }

    }
    
    @IBAction func teplitsa(_ sender: Any) {
        
        if teplCntrl.isOn == true
        {
            tepl.text = "Есть"
        }else {
            tepl.text = "Отсутствует"
        }

    }
    
    @IBAction func torg(_ sender: Any) {
        
        if tgCntrl.isOn == true
        {
            tg.text = "Возможен"
        }else {
            tg.text = "Отсутствует"
        }
        
    }

    
    
    @IBAction func selectPressed(_ sender: Any) {
        
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        
        //изображение будет доступно для редактирования(масштабирование)
        picker.allowsEditing = true
        
        let alertController = UIAlertController(title: "Добавить фото", message: "Выберите", preferredStyle: .actionSheet)
        
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
    
    
    //ошибка, если нет камеры
    func noCameraErrorAlert(title: String, message: String) {
        
        // Всплывающее окно ошибки
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            previewImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
        
        //Появление кнопок
        selectBtn.isHidden = true
        postBtn.isHidden = false
        
    }
    
    
    //что происходит, когда пользователь нажимает "отмена"?
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func postBtn(_ sender: Any) {
        
        
        //показать индикатор загрузки
        AppDelegate.instance().showActivityIndicator()
        
        let uid = FIRAuth.auth()?.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "gs://myhouse-85275.appspot.com/")
        
        //Проверка на правильность введённых данных
        guard nameTextField.text != "", fullArea.text != "", years.text != "",
            gaArea.text != "", property.text != "", price.text != "", nameUser.text != "", phone.text != "", email.text != ""
            else {
                self.noCameraErrorAlert(title: "Ошибка!", message: "Введите все данные о дачном участке")
                //послезагрузки изображения индикатор исчезнет
                AppDelegate.instance().dismissActivityIndicators()
                return
        }
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            let users = snapshot.value as! [String: Any]
            
            let imail = users["email"] as? String
            
            let userImage = users["photo"] as? String
            
            self.profileImage = userImage
            
            if self.email.text != imail {
                self.noCameraErrorAlert(title: "Ошибка!", message: "Email должен совпадать с email в Вашем профиле")
                //послезагрузки изображения индикатор исчезнет
                AppDelegate.instance().dismissActivityIndicators()
                return
            }
            
            
            
            //создаём уникальный ключ к посту в базу даныых
            let key = ref.child("Продажа").child("Дачный участок").childByAutoId().key
            
            //сохраняем фото в Storage от конкретного пользователя с уникальным ключем поста
            let imageRef = storage.child("Продажа").child("Дачный участок").child(uid!).child("\(key).jpg")
            
            //Сжимаем фотографию для быстрой загрузки
            let data = UIImageJPEGRepresentation(self.previewImage.image!, 0.6)
            
            
            let uploadTask = imageRef.put(data!, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                    //послезагрузки изображения индикатор исчезнет
                    AppDelegate.instance().dismissActivityIndicators()
                    return
                }
                
                
                imageRef.downloadURL(completion: {(url, error) in
                    
                    if let url = url {
                        
                        let feed = ["userID": uid!,
                                    "pathToImage": url.absoluteString,
                                    "likes": 0,
                                    "author": FIRAuth.auth()!.currentUser!.displayName!,
                                    "photoUser": self.profileImage!,
                                    "postID" : key,
                                    "Операция": "Продажа",
                                    "Тип недвижимости": "Дачный участок",
                                    "Заголовок объявления": self.nameTextField.text!,
                                    "Тип": self.type,
                                    "Электричество": self.el.text!,
                                    "Вода": self.vod.text!,
                                    "Газ": self.gas.text!,
                                    "Посадки": self.posadki.text!,
                                    "Баня": self.ban.text!,
                                    "Туалет": self.can.text!,
                                    "Гараж": self.garage.text!,
                                    "Теплица": self.tepl.text!,
                                    "Автобусная остановка": self.avt,
                                    "Год постройки": self.years.text!,
                                    "Участок": self.gaArea.text!,
                                    "Площадь дома": self.fullArea.text!,
                                    "Контактное лицо": self.nameUser.text!,
                                    "email": self.email.text!,
                                    "Телефон": self.phone.text!,
                                    "Описание": self.property.text!,
                                    "Цена": self.price.text!,
                                    "Торг": self.tg.text!,
                                    "Тип пользователя": self.userType] as [String: Any]
                        
                        let postFeed = ["\(key)": feed]
                        
                        ref.child("Продажа").child("Дачный участок").updateChildValues(postFeed)
                        
                        //послезагрузки изображения индикатор исчезнет
                        AppDelegate.instance().dismissActivityIndicators()
                        
                        //Создаём всплывающее окно
                        //Заголовок
                        let alert = UIAlertController(title: "", message: "Объявление создано", preferredStyle: UIAlertControllerStyle.alert)
                        
                        //Кнопка ДА с действием
                        let actionYes = UIAlertAction(title: "Ок", style: .default, handler: { action in
                            
                            self.dismiss(animated: true, completion: nil)
                            
                        })
                        
                        //Добовляем кнопки
                        alert.addAction(actionYes)
                        
                        //Показать всплывающее окно
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                })
            }
            uploadTask.resume()
        })
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

}
