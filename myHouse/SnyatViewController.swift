//
//  SnyatViewController.swift
//  myHouse
//
//  Created by Valera Petin on 21.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class SnyatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Кнопка назад без названия
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}
