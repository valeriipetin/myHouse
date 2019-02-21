//
//  ResetPasswordViewController.swift
//  myHouse
//
//  Created by Valera Petin on 04.02.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.email.delegate = self
        
        createToolbar()
    }
    
    //Сброс пароля
    @IBAction func resetPasswordButton(_ sender: Any) {
        
        if self.email.text == ""
        {
         self.emailErrorAlert(title: "Ошибка!", message: "Проверьте правильность email адреса.")
        }
        else
        {
            FIRAuth.auth()?.sendPasswordReset(withEmail: email.text!, completion: { (error) in
            
                var tittle = ""
                var messsage = ""
                
                if error != nil
                {
                    tittle = "Ошибка!"
                    messsage = (error?.localizedDescription)!
                }
                else
                {
                    tittle = "Успешно!"
                    messsage = "Пароль сброшен. Перейдите на свой email адрес для подтверждения сброса пароля."
                    
                    self.email.text = ""
                    
                    let LoginViewController = self.storyboard!.instantiateViewController(withIdentifier: "Login")
                    UIApplication.shared.keyWindow?.rootViewController = LoginViewController
                }
                
                self.emailErrorAlert(title: tittle, message: messsage)
                
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

    //Кнопка Готово, которая прячет клавиатуру
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        toolBar.tintColor = .black
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain , target: self, action: #selector(SingUpViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        email.inputAccessoryView = toolBar

    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    // Всплывающее окно ошибки
    func emailErrorAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
