//
//  AboutViewController.swift
//  myHouse
//
//  Created by Valera Petin on 03.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
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
    }

    

}
