//
//  ProfileViewController.swift
//  myHouse
//
//  Created by Valera Petin on 13.02.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FBSDKCoreKit


class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var databaseRef: FIRDatabaseReference!
    
    var posts = [Post]()
    var following = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Прозрачный  Navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //слайд-меню
        menuButton.target = revealViewController()
        menuButton.action = Selector(("revealToggle:"))
        
        //свайп слева на право
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
        //Кнопка назад без названия
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        
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
    

        //Загружаем данные пользователя
        if let userID = FIRAuth.auth()?.currentUser?.uid{
            
            databaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
                
                let users = snapshot.value as! [String: Any]
                
                let username = users["username"] as? String
                let email = users["email"] as? String
                
                if let profileImageURL = users["photo"] as? String {
                    
                    let url = URL(string: profileImageURL)
                    
                    let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            print(error!)
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.profileImageView.image = UIImage(data: data!)
                        }
                    })
                    task.resume()
                }
                self.usernameText.text = username
                self.emailText.text = email
            })  { (error) in
                print(error.localizedDescription)
            }
        }
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
    
    @IBAction func unwindToProfile(storyboard:UIStoryboardSegue){
    }

}
