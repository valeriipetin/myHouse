//
//  AddRentDomTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 02.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddRentDomTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailDomType: UILabel!
    @IBOutlet weak var detailTime: UILabel!
    @IBOutlet weak var detailNumRooms: UILabel!
    @IBOutlet weak var detailFloorsHome: UILabel!
    @IBOutlet weak var detailPlan: UILabel!
    @IBOutlet weak var detailBathroom: UILabel!
    @IBOutlet weak var detailVod: UILabel!
    @IBOutlet weak var detailGas: UILabel!
    @IBOutlet weak var detailOtop: UILabel!
    @IBOutlet weak var detailTypeOtop: UILabel!
    @IBOutlet weak var detailCan: UILabel!
    @IBOutlet weak var detailMat: UILabel!
    @IBOutlet weak var detailuserTypeLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var wifiCntrl: UISwitch!
    @IBOutlet weak var el: UILabel!
    @IBOutlet weak var elCntrl: UISwitch!
    @IBOutlet weak var tg: UILabel!
    @IBOutlet weak var tgCntrl: UISwitch!
    
    @IBOutlet weak var years: UITextField!
    @IBOutlet weak var fullArea: UITextField!
    @IBOutlet weak var livingArea: UITextField!
    @IBOutlet weak var kitchenArea: UITextField!
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
        self.livingArea.delegate = self
        self.kitchenArea.delegate = self
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
        livingArea.inputAccessoryView = toolBar
        kitchenArea.inputAccessoryView = toolBar
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
            detailDomType.text? = type
        }
    }
    
    //Срок аренды
    var time:String = "Выбрать" {
        didSet {
            detailTime.text? = time
        }
    }
    
    //Комнат
    var number:String = "Выбрать" {
        didSet {
            detailNumRooms.text? = number
        }
    }
    
    //Этажей в доме
    var floorsHome:String = "Выбрать" {
        didSet {
            detailFloorsHome.text? = floorsHome
        }
    }
    
    //Планировка
    var plan:String = "Выбрать" {
        didSet {
            detailPlan.text? = plan
        }
    }
    
    //Санузел
    var bathroom:String = "Выбрать" {
        didSet {
            detailBathroom.text? = bathroom
        }
    }
    
    //Водоснабжение
    var vod:String = "Выбрать" {
        didSet {
            detailVod.text? = vod
        }
    }
    
    //Газоснабжение
    var gas:String = "Выбрать" {
        didSet {
            detailGas.text? = gas
        }
    }
    
    //Отопление
    var otop:String = "Выбрать" {
        didSet {
            detailOtop.text? = otop
        }
    }
    
    //Тип отопления
    var otopType:String = "Выбрать" {
        didSet {
            detailTypeOtop.text? = otopType
        }
    }
    
    //Канализация
    var can:String = "Выбрать" {
        didSet {
            detailCan.text? = can
        }
    }
    
    //Материал дома
    var mat:String = "Выбрать" {
        didSet {
            detailMat.text? = mat
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
        
        if segue.identifier == "RTypePick" {
            if let typePickerViewController = segue.destination as? RTypeHouseTableViewController {
                typePickerViewController.selectedtype = type
            }
        }
        if segue.identifier == "RTimePick" {
            if let timePickerViewController = segue.destination as? RTimeTableViewController {
                timePickerViewController.selectedtime = time
            }
        }
        if segue.identifier == "RNumberPick" {
            if let numberPickerViewController = segue.destination as? RNumRoomsTableViewController {
                numberPickerViewController.selectedNumber = number
            }
        }
        if segue.identifier == "RFloorsHomePick" {
            if let floorsHomePickerViewController = segue.destination as? RFloorsHomeTableViewController {
                floorsHomePickerViewController.selectedFloorsHome = floorsHome
            }
        }
        if segue.identifier == "RPlanPick" {
            if let planPickerViewController = segue.destination as? RPlanTableViewController {
                planPickerViewController.selectedplan = plan
            }
        }
        if segue.identifier == "RBathroomPick" {
            if let bathroomPickerViewController = segue.destination as? RBathroomTableViewController {
                bathroomPickerViewController.selectedbathroom = bathroom
            }
        }
        if segue.identifier == "RVodPick" {
            if let vodPickerViewController = segue.destination as? RVodTableViewController {
                vodPickerViewController.selectedvod = vod
            }
        }
        if segue.identifier == "RGasPick" {
            if let gasPickerViewController = segue.destination as? RGasTableViewController {
                gasPickerViewController.selectedgas = gas
            }
        }

        if segue.identifier == "ROtopPick" {
            if let otopPickerViewController = segue.destination as? ROtopTableViewController {
                otopPickerViewController.selectedotop = otop
            }
        }
        if segue.identifier == "ROtopTypePick" {
            if let otopTypePickerViewController = segue.destination as? ROtopTypeTableViewController {
                otopTypePickerViewController.selectedotopType = otopType
            }
        }
        if segue.identifier == "RCanPick" {
            if let canPickerViewController = segue.destination as? RCanTableViewController {
                canPickerViewController.selectedcan = can
            }
        }
        if segue.identifier == "RMatPick" {
            if let matPickerViewController = segue.destination as? RMatTableViewController {
                matPickerViewController.selectedmat = mat
            }
        }
        if segue.identifier == "RUserTypePick" {
            if let userTypePickerViewController = segue.destination as? RUserTypeTableViewController {
                userTypePickerViewController.selecteduserType = userType
            }
        }
        
    }
    
    
    
    //Unwind type segue
    @IBAction func unwindWithSelectedRType(_ segue:UIStoryboardSegue) {
        if let typePickerViewController = segue.source as? RTypeHouseTableViewController,
            let selectedtype = typePickerViewController.selectedtype {
            type = selectedtype
        }
    }
    
    //Unwind arenda segue
    @IBAction func unwindWithSelectedRTime(_ segue:UIStoryboardSegue) {
        if let timePickerViewController = segue.source as? RTimeTableViewController,
            let selectedtime = timePickerViewController.selectedtime {
            time = selectedtime
        }
    }

    //Unwind number segue
    @IBAction func unwindWithSelectedRNumRooms(_ segue:UIStoryboardSegue) {
        if let numberPickerViewController = segue.source as? RNumRoomsTableViewController,
            let selectedNumber = numberPickerViewController.selectedNumber {
            number = selectedNumber
        }
    }
    
    //Unwind floorsHome segue
    @IBAction func unwindWithSelectedRFloorsHome(_ segue:UIStoryboardSegue) {
        if let floorsHomePickerViewController = segue.source as? RFloorsHomeTableViewController,
            let selectedfloorsHome = floorsHomePickerViewController.selectedFloorsHome {
            floorsHome = selectedfloorsHome
        }
    }
    
    //Unwind plan segue
    @IBAction func unwindWithSelectedRPlan(_ segue:UIStoryboardSegue) {
        if let planPickerViewController = segue.source as? RPlanTableViewController,
            let selectedplan = planPickerViewController.selectedplan {
            plan = selectedplan
        }
    }
    
    //Unwind bathroom segue
    @IBAction func unwindWithSelectedRBathroom(_ segue:UIStoryboardSegue) {
        if let bathroomPickerViewController = segue.source as? RBathroomTableViewController,
            let selectedbathroom = bathroomPickerViewController.selectedbathroom {
            bathroom = selectedbathroom
        }
    }
    
    //Unwind vod segue
    @IBAction func unwindWithSelectedRVod(_ segue:UIStoryboardSegue) {
        if let vodHousePickerViewController = segue.source as? RVodTableViewController,
            let selectedvod = vodHousePickerViewController.selectedvod {
            vod = selectedvod
        }
    }
    
    //Unwind gas segue
    @IBAction func unwindWithSelectedRGas(_ segue:UIStoryboardSegue) {
        if let gasHousePickerViewController = segue.source as? RGasTableViewController,
            let selectedgas = gasHousePickerViewController.selectedgas {
            gas = selectedgas
        }
    }
    
    //Unwind otop segue
    @IBAction func unwindWithSelectedROtop(_ segue:UIStoryboardSegue) {
        if let otopPickerViewController = segue.source as? ROtopTableViewController,
            let selectedotop = otopPickerViewController.selectedotop {
            otop = selectedotop
        }
    }
    
    //Unwind typeOtop segue
    @IBAction func unwindWithSelectedROtopType(_ segue:UIStoryboardSegue) {
        if let otopTypePickerViewController = segue.source as? ROtopTypeTableViewController,
            let selectedotopType = otopTypePickerViewController.selectedotopType {
            otopType = selectedotopType
        }
    }
    
    //Unwind can segue
    @IBAction func unwindWithSelectedRCan(_ segue:UIStoryboardSegue) {
        if let canPickerViewController = segue.source as? RCanTableViewController,
            let selectedcan = canPickerViewController.selectedcan {
            can = selectedcan
        }
    }
    
    //Unwind materials segue
    @IBAction func unwindWithSelectedRMat(_ segue:UIStoryboardSegue) {
        if let matPickerViewController = segue.source as? RMatTableViewController,
            let selectedmat = matPickerViewController.selectedmat {
            mat = selectedmat
        }
    }
    
    //Unwind userType segue
    @IBAction func unwindWithSelectedRUserType(_ segue:UIStoryboardSegue) {
        if let userTypePickerViewController = segue.source as? RUserTypeTableViewController,
            let selecteduserType = userTypePickerViewController.selecteduserType {
            userType = selecteduserType
        }
    }
    
    
    //Switch controllers
    @IBAction func wifi(_ sender: Any) {
        
        if wifiCntrl.isOn
        {
            wifi.text = "Есть"
        } else {
            wifi.text = "Отсутствует"
        }
        
    }
    
    @IBAction func electric(_ sender: Any) {
        
        if elCntrl.isOn == true
        {
            el.text = "Есть"
        }else {
            el.text = "Отсутствует"
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
        guard nameTextField.text != "", fullArea.text != "", livingArea.text != "",
            kitchenArea.text != "", gaArea.text != "", years.text != "", property.text != "", price.text != "", nameUser.text != "",
            phone.text != "", email.text != ""
            else {
                self.noCameraErrorAlert(title: "Ошибка!", message: "Введите все данные о доме")
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
            let key = ref.child("Аренда").child("Дома").childByAutoId().key
            
            //сохраняем фото в Storage от конкретного пользователя с уникальным ключем поста
            let imageRef = storage.child("Аренда").child("Дома").child(uid!).child("\(key).jpg")
            
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
                                    "Операция": "Аренда",
                                    "Тип недвижимости": "Дом",
                                    "Заголовок объявления": self.nameTextField.text!,
                                    "Срок аренды": self.time,
                                    "Тип объекта": self.type,
                                    "Этажей в доме": self.floorsHome,
                                    "Водоснабжение": self.vod,
                                    "Газоснабжение": self.gas,
                                    "Планировка": self.plan,
                                    "Санузел": self.bathroom,
                                    "Отопление": self.otop,
                                    "Тип отопления": self.otopType,
                                    "Канализация": self.can,
                                    "Комнат": self.number,
                                    "Материал дома": self.mat,
                                    "Интернет": self.wifi.text!,
                                    "Электричество": self.el.text!,
                                    "Торг": self.tg.text!,
                                    "Год постройки": self.years.text!,
                                    "Участок": self.gaArea.text!,
                                    "Общая площадь": self.fullArea.text!,
                                    "Жилая площадь": self.livingArea.text!,
                                    "Кухня": self.kitchenArea.text!,
                                    "Контактное лицо": self.nameUser.text!,
                                    "email": self.email.text!,
                                    "Телефон": self.phone.text!,
                                    "Описание": self.property.text!,
                                    "Цена": self.price.text!,
                                    "Тип пользователя": self.userType] as [String: Any]
                        
                        let postFeed = ["\(key)": feed]
                        
                        ref.child("Аренда").child("Дома").updateChildValues(postFeed)
                        
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

