//
//  RecordViewController.swift
//  myHouse
//
//  Created by Valera Petin on 01.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase

class RecordViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var dataText: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    let ref = FIRDatabase.database().reference()
    
    //вызов UIDatePicker
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Прозрачный  Navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //слайд-меню
        menu.target = revealViewController()
        menu.action = Selector(("revealToggle:"))
        
        //свайп слева на право
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        //отображение по нажатию
        createDatePicker()
        createTimePicker()
        //createToolbar()
        
        self.phone.delegate = self
    }
    

    //создаём DataPicker
    func createDatePicker() {
        
        //формат pickera
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //color toolbar
        toolbar.tintColor = .black
        
        //bar button item
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain , target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dataText.inputAccessoryView = toolbar
        
        //присваеваем date picker полю text field
        dataText.inputView = datePicker
        
    }
    
    //что будет, по нажатию Done
    func donePressed() {
        
        //формат даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        dataText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    //создаём TimePicker
    func createTimePicker() {
        
        //формат pickera
        timePicker.datePickerMode = .time
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //color toolbar
        toolbar.tintColor = .black
        
        //bar button item
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain , target: self, action: #selector(doneTimePressed))
        toolbar.setItems([doneButton], animated: false)
        
        timeText.inputAccessoryView = toolbar
        
        //присваеваем date picker полю text field
        timeText.inputView = timePicker
        
    }
    
    //что будет, по нажатию Done
    func doneTimePressed() {
        
        //формат даты
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        timeText.text = timeFormatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }

    //Функция на создание заявки на консультацию
    @IBAction func pressedBtn(_ sender: Any) {
        
        //Проверка на правильность введённых данных
        guard dataText.text != "", phone.text != "", timeText.text != ""
            else {
                self.Alert(title: "Ошибка!", message: "Проверьте введённые вами данные и попробуйте ещё раз.")
                return
        }

        let uid = FIRAuth.auth()!.currentUser!.uid
        
        let record = ref.child("Консультации").child(uid)
        
        let values = ["Дата": self.dataText.text!,
                      "Телефон": self.phone.text!,
                      "Время": self.timeText.text!]
        
        record.updateChildValues(values, withCompletionBlock: {(err, ref) in
            
            if err != nil {
                self.Alert(title: "Ошибка!", message: "Проверьте введённые вами данные и попробуйте ещё раз.")
                return
            } else {
                
                self.Alert(title: "", message: "Заявка отправлена. Мы позвоним Вам в указаное Вами время.")
                self.dataText.text = ""
                self.phone.text = ""
                self.timeText.text = ""
            }
        
        
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

    //Кнопка Готово, которая прячет клавиатуру
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        toolBar.tintColor = .black
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain , target: self, action: #selector(RecordViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        phone.inputAccessoryView = toolBar
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    // Всплывающее окно ошибки
    func Alert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
