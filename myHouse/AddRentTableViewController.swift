//
//  AddRentTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 01.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class AddRentTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailArenda: UILabel!
    @IBOutlet weak var detailNumberLabel: UILabel!
    @IBOutlet weak var detailFloorLabel: UILabel!
    @IBOutlet weak var detailFloorsHome: UILabel!
    @IBOutlet weak var detailTypeHouseLabel: UILabel!
    @IBOutlet weak var detailPlanLabel: UILabel!
    @IBOutlet weak var detailBathroomLabel: UILabel!
    @IBOutlet weak var detailRemont: UILabel!
    @IBOutlet weak var detailTypeDom: UILabel!
    @IBOutlet weak var detailMatDom: UILabel!
    @IBOutlet weak var detailCom: UILabel!
    @IBOutlet weak var detailuserTypeLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    
    @IBOutlet weak var wifi: UILabel!
    @IBOutlet weak var wifiCntrl: UISwitch!
    @IBOutlet weak var meb: UILabel!
    @IBOutlet weak var mebCntrl: UISwitch!
    @IBOutlet weak var hol: UILabel!
    @IBOutlet weak var holCntrl: UISwitch!
    @IBOutlet weak var tg: UILabel!
    @IBOutlet weak var tgCntrl: UISwitch!
    
    @IBOutlet weak var fullArea: UITextField!
    @IBOutlet weak var livingArea: UITextField!
    @IBOutlet weak var kitchenArea: UITextField!
    @IBOutlet weak var years: UITextField!
    
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
        property.inputAccessoryView = toolBar
        price.inputAccessoryView = toolBar
        nameUser.inputAccessoryView = toolBar
        phone.inputAccessoryView = toolBar
        email.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    
    //Срок аренды
    var time:String = "Выбрать" {
        didSet {
            detailArenda.text? = time
        }
    }
    
    //Кол-во комнат
    var number:String = "Выбрать" {
        didSet {
            detailNumberLabel.text? = number
        }
    }
    
    //Этаж
    var floor:String = "Выбрать" {
        didSet {
            detailFloorLabel.text? = floor
        }
    }
    //Этажей в доме
    var floorsHome:String = "Выбрать" {
        didSet {
            detailFloorsHome.text? = floorsHome
        }
    }
    
    //Тип квартиры
    var typeHouse:String = "Выбрать" {
        didSet {
            detailTypeHouseLabel.text? = typeHouse
        }
    }
    
    //Планировка
    var plan:String = "Выбрать" {
        didSet {
            detailPlanLabel.text? = plan
        }
    }
    
    //Санузел
    var bathroom:String = "Выбрать" {
        didSet {
            detailBathroomLabel.text? = bathroom
        }
    }
    
    //Ремонт
    var rem:String = "Выбрать" {
        didSet {
            detailRemont.text? = rem
        }
    }
    
    //Тип дома
    var typeDom:String = "Выбрать" {
        didSet {
            detailTypeDom.text? = typeDom
        }
    }
    
    //Материал дома
    var mat:String = "Выбрать" {
        didSet {
            detailMatDom.text? = mat
        }
    }
    
    //Коммунальные платежи
    var com:String = "Выбрать" {
        didSet {
            detailCom.text? = com
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
        
        if segue.identifier == "SArPick" {
            if let timePickerViewController = segue.destination as? TimeTableViewController {
                timePickerViewController.selectedtime = time
            }
        }
        if segue.identifier == "SNumberPick" {
            if let numberPickerViewController = segue.destination as? RentNumRoomsTableViewController {
                numberPickerViewController.selectedNumber = number
            }
        }
        if segue.identifier == "SFloorPick" {
            if let floorPickerViewController = segue.destination as? RentFloorTableViewController {
                floorPickerViewController.selectedFloor = floor
            }
        }
        if segue.identifier == "SFloorsHomePick" {
            if let floorsHomePickerViewController = segue.destination as? RentFloorsHomeTableViewController {
                floorsHomePickerViewController.selectedFloorsHome = floorsHome
            }
        }
        if segue.identifier == "STypeHousePick" {
            if let typeHousePickerViewController = segue.destination as? RentTypeHouseTableViewController {
                typeHousePickerViewController.selectedtypeHouse = typeHouse
            }
        }
        if segue.identifier == "SPlanPick" {
            if let planPickerViewController = segue.destination as? RentPlanTableViewController {
                planPickerViewController.selectedplan = plan
            }
        }
        if segue.identifier == "SBathroomPick" {
            if let bathroomPickerViewController = segue.destination as? RentBathroomTableViewController {
                bathroomPickerViewController.selectedbathroom = bathroom
            }
        }
        if segue.identifier == "SRemPick" {
            if let remPickerViewController = segue.destination as? RentRemTableViewController {
                remPickerViewController.selectedrem = rem
            }
        }
        if segue.identifier == "STypeDomPick" {
            if let typeDomPickerViewController = segue.destination as? RentTypeDomTableViewController {
                typeDomPickerViewController.selectedtypeDom = typeDom
            }
        }
        if segue.identifier == "SMatPick" {
            if let matPickerViewController = segue.destination as? RentMatTableViewController {
                matPickerViewController.selectedmat = mat
            }
        }
        if segue.identifier == "SComPick" {
            if let comPickerViewController = segue.destination as? RentComTableViewController {
                comPickerViewController.selectedcom = com
            }
        }
        if segue.identifier == "SUserTypePick" {
            if let userTypePickerViewController = segue.destination as? UserTypeTableViewController {
                userTypePickerViewController.selecteduserType = userType
            }
        }
        
    }
    
    
    
    //Unwind arenda segue
    @IBAction func unwindWithSelectedRentTime(_ segue:UIStoryboardSegue) {
        if let timePickerViewController = segue.source as? TimeTableViewController,
            let selectedtime = timePickerViewController.selectedtime {
            time = selectedtime
        }
    }
    
    //Unwind numrooms segue
    @IBAction func unwindWithSelectedRentNumber(_ segue:UIStoryboardSegue) {
        if let numberPickerViewController = segue.source as? RentNumRoomsTableViewController,
            let selectedNumber = numberPickerViewController.selectedNumber {
            number = selectedNumber
        }
    }
    
    //Unwind floor segue
    @IBAction func unwindWithSelectedRentFloor(_ segue:UIStoryboardSegue) {
        if let floorPickerViewController = segue.source as? RentFloorTableViewController,
            let selectedFloor = floorPickerViewController.selectedFloor {
            floor = selectedFloor
        }
    }
    
    //Unwind floorsHome segue
    @IBAction func unwindWithSelectedRentFloorsHome(_ segue:UIStoryboardSegue) {
        if let floorsHomePickerViewController = segue.source as? RentFloorsHomeTableViewController,
            let selectedFloorsHome = floorsHomePickerViewController.selectedFloorsHome {
            floorsHome = selectedFloorsHome
        }
    }
    
    //Unwind typeHouse segue
    @IBAction func unwindWithSelectedRentTypeHouse(_ segue:UIStoryboardSegue) {
        if let typeHousePickerViewController = segue.source as? RentTypeHouseTableViewController,
            let selectedtypeHouse = typeHousePickerViewController.selectedtypeHouse {
            typeHouse = selectedtypeHouse
        }
    }
    
    //Unwind plan segue
    @IBAction func unwindWithSelectedRentPlan(_ segue:UIStoryboardSegue) {
        if let planPickerViewController = segue.source as? RentPlanTableViewController,
            let selectedplan = planPickerViewController.selectedplan {
            plan = selectedplan
        }
    }
    
    //Unwind bathroom segue
    @IBAction func unwindWithSelectedRentBathroom(_ segue:UIStoryboardSegue) {
        if let bathroomPickerViewController = segue.source as? RentBathroomTableViewController,
            let selectedbathroom = bathroomPickerViewController.selectedbathroom {
            bathroom = selectedbathroom
        }
    }
    
    //Unwind remont segue
    @IBAction func unwindWithSelectedRentRem(_ segue:UIStoryboardSegue) {
        if let remPickerViewController = segue.source as? RentRemTableViewController,
            let selectedrem = remPickerViewController.selectedrem {
            rem = selectedrem
        }
    }
    
    //Unwind type doma segue
    @IBAction func unwindWithSelectedRentTypeDom(_ segue:UIStoryboardSegue) {
        if let typeDomPickerViewController = segue.source as? RentTypeDomTableViewController,
            let selectedtypeDom = typeDomPickerViewController.selectedtypeDom {
            typeDom = selectedtypeDom
        }
    }
    
    //Unwind material doma segue
    @IBAction func unwindWithSelectedRentMat(_ segue:UIStoryboardSegue) {
        if let matPickerViewController = segue.source as? RentMatTableViewController,
            let selectedmat = matPickerViewController.selectedmat {
            mat = selectedmat
        }
    }
    
    //Unwind com platezhi segue
    @IBAction func unwindWithSelectedRentCom(_ segue:UIStoryboardSegue) {
        if let comPickerViewController = segue.source as? RentComTableViewController,
            let selectedcom = comPickerViewController.selectedcom {
            com = selectedcom
        }
    }
    
    //Unwind userType segue
    @IBAction func unwindWithSelectedRentUserType(_ segue:UIStoryboardSegue) {
        if let userTypePickerViewController = segue.source as? RentUserTypeTableViewController,
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
    
    @IBAction func mebel(_ sender: Any) {
        
        if mebCntrl.isOn == true
        {
            meb.text = "Есть"
        }else {
            meb.text = "Отсутствует"
        }
        
    }
    
    @IBAction func holodilnik(_ sender: Any) {
        
        if holCntrl.isOn == true
        {
            hol.text = "Есть"
        }else {
            hol.text = "Отсутствует"
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
            kitchenArea.text != "", years.text != "", property.text != "", price.text != "", nameUser.text != "",
            phone.text != "", email.text != ""
            else {
                self.noCameraErrorAlert(title: "Ошибка!", message: "Введите все данные о квартире")
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
                self.noCameraErrorAlert(title: "Ошибка!", message: "Email должны совпадать")
                //послезагрузки изображения индикатор исчезнет
                AppDelegate.instance().dismissActivityIndicators()
                return
            }
            
            
            //создаём уникальный ключ к посту в базу даныых
            let key = ref.child("Аренда").child("Квартиры").childByAutoId().key
            
            //сохраняем фото в Storage от конкретного пользователя с уникальным ключем поста
            let imageRef = storage.child("Аренда").child("Квартиры").child(uid!).child("\(key).jpg")
            
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
                                    "Тип недвижимости": "Квартира",
                                    "Заголовок объявления": self.nameTextField.text!,
                                    "Срок аренды": self.time,
                                    "Кол-во комнат": self.number,
                                    "Этаж": self.floor,
                                    "Этажей в доме": self.floorsHome,
                                    "Тип квартиры": self.typeHouse,
                                    "Планировка": self.plan,
                                    "Санузел": self.bathroom,
                                    "Ремонт": self.rem,
                                    "Тип дома": self.typeDom,
                                    "Год постройки": self.years.text!,
                                    "Материал дома": self.mat,
                                    "Коммунальные платежи": self.com,
                                    "Интернет": self.wifi.text!,
                                    "Мебель": self.meb.text!,
                                    "Холодильник": self.hol.text!,
                                    "Общая площадь": self.fullArea.text!,
                                    "Жилая площадь": self.livingArea.text!,
                                    "Кухня": self.kitchenArea.text!,
                                    "Контактное лицо": self.nameUser.text!,
                                    "email": self.email.text!,
                                    "Телефон": self.phone.text!,
                                    "Описание": self.property.text!,
                                    "Цена": self.price.text!,
                                    "Торг": self.tg.text!,
                                    "Тип пользователя": self.userType] as [String: Any]
                        
                        let postFeed = ["\(key)": feed]
                        
                        ref.child("Аренда").child("Квартиры").updateChildValues(postFeed)
                        
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
