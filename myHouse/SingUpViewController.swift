//
//  SingUpViewController.swift
//  myHouse
//
//  Created by Valera Petin on 25.01.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase

class SingUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var comfirmPw: UITextField!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Name.delegate = self
        self.Username.delegate = self
        self.Password.delegate = self
        self.comfirmPw.delegate = self
        
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
        
        Username.inputAccessoryView = toolBar
        Name.inputAccessoryView = toolBar
        Password.inputAccessoryView = toolBar
        comfirmPw.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    //Создание аккаунта
    @IBAction func CreateAccount(_ sender: Any) {
        
        //Проверка на правильность введённых данных
        guard Name.text != "", Username.text != "", Password.text != ""
            else {
                self.signupErrorAlert(title: "Ошибка!", message: "Проверьте введённые вами данные и попробуйте ещё раз")
                self.Password.text = ""
                self.comfirmPw.text = ""
                return
        }
        
        //Проверка на валидность email
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if  Username.text != "" {
            if emailTest.evaluate(with: Username.text!) == false {
                self.signupErrorAlert(title: "Ошибка!", message: "Введен неправильный Email.")
            }
        }
        
        
        //Проверка на совпадение паролей
        if Password.text == comfirmPw.text {
        
        //1 ----- Создание аккаунта в Authentication
        
        FIRAuth.auth()?.createUser(withEmail: Username.text!, password: Password.text!, completion: { (user, error) in
            
            if error != nil {
                
                self.signupErrorAlert(title: "Ошибка!", message: "Пользователь с таким email уже существует")
                self.Password.text = ""
                self.comfirmPw.text = ""
                
            }
                guard let uid = user?.uid
                    
            else { return }
            
            //Запись поля Имя в displayName
            let changeRequest = FIRAuth.auth()!.currentUser!.profileChangeRequest()
            changeRequest.displayName = self.Name.text!
            changeRequest.commitChanges(completion: nil)
            
        //2 ----- Сохранение аккаунта в Database
            
                let ref = FIRDatabase.database().reference(fromURL: "https://myhouse-85275.firebaseio.com/")
            
                let usersReference = ref.child("users").child(uid)
            
                let values = ["email": self.Username.text!, "username": self.Name.text!, "uid": user?.uid, "photo": "https://firebasestorage.googleapis.com/v0/b/myhouse-85275.appspot.com/o/user_placeholder.png?alt=media&token=9d46699c-bee2-455f-85cf-4cdc76f6271b", "phone": ""]
            
                usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if err != nil {
        
                self.signupErrorAlert(title: "Ошибка!", message: "Проблемы с соединением Интернет")
                self.Password.text = ""
                self.comfirmPw.text = ""
                        
                    return
                        
                    }else {
                        
        //3 ----- Если пользователь был успешно зарегистрирован, происходит автоматический вход.
                        
            FIRAuth.auth()?.signIn(withEmail: self.Username.text!, password: self.Password.text!, completion: { (user, error) in
                            
                if error != nil {
                self.signupErrorAlert(title: "Ошибка!", message: "Неверно введены данные для входа")
                    self.Password.text = ""
                    self.comfirmPw.text = ""
                 
                }else {
                    
        //4 ----- Переход к приложению
                    
                let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDel.logUser()
                                
                }})
            }})
        })
            
            } else {
            self.signupErrorAlert(title: "Ошибка!", message: "Пароли не совпадают")
            self.Password.text = ""
            self.comfirmPw.text = ""
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
    
    // Всплывающее окно ошибки
    func signupErrorAlert(title: String, message: String) {
                
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
