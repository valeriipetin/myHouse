//
//  LoginViewController.swift
//  myHouse
//
//  Created by Valera Petin on 25.01.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class LoginViewController: UIViewController, UITextFieldDelegate /*FBSDKLoginButtonDelegate*/ {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    
   // var loginButton: FBSDKLoginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Username.delegate = self
        self.Password.delegate = self
        
        createToolbar()
        
    /*
        loginButton.isHidden = true
        
        _ = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if user != nil {
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let homeViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "Add")
                
                self.present(homeViewController, animated: true, completion: nil)
                
            } else {
                
            
            self.view.addSubview(self.loginButton)
            self.loginButton.center = self.view.center
            self.loginButton.delegate = self
            self.loginButton.readPermissions = ["email", "public_profile"]
            self.loginButton.isHidden = false
        }
    }*/
}
    
    /*
    func loginButtonDidLogOut (_ loginButton: FBSDKLoginButton!) {
        
        print("Выйти с учётной записи Facebook?")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("Успешно")
        
        self.loginButton.isHidden = true
        
        if error != nil {
            
           self.loginButton.isHidden = false
            
        }else if(result.isCancelled) {
            
            self.loginButton.isHidden = false
            
        }else{
            
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) {(user, error) in
        print("Успешно залогинился")
            }
        }
    }
   */
    
    @IBAction func Login(_ sender: Any) {
        
        
        //Проверка на правильность введённых данных
        guard Username.text != "", Password.text != ""
            else {
                self.loginErrorAlert(title: "Ошибка!", message: "Проверьте введённые вами данные и попробуйте ещё раз.")
                self.Password.text = ""
                return
        }
        
        
        //1 ----- Вход в приложение.
        
        FIRAuth.auth()?.signIn(withEmail: Username.text!, password: Password.text!, completion: {
            
            (user, error) in
            
            if error != nil {
                
                self.loginErrorAlert(title: "Ошибка!", message: "Неверно введены данные для входа.")
                self.Password.text = ""
                
            } else {
                
                let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDel.logUser()
        
            }})
    }
    
    // Ошибка при логине
    func loginErrorAlert(title: String, message: String) {
        
        // Всплывающее окно ошибки
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Попробовать ещё раз", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
        
        Username.inputAccessoryView = toolBar
        Password.inputAccessoryView = toolBar
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func unwindToLogin(storyboard:UIStoryboardSegue){
    }
}
