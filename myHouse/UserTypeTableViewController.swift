//
//  UserTypeTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 12.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class UserTypeTableViewController: UITableViewController {
        
        var userTypes:[String] = [
            "Риелтор",
            "Собственник",
            "Застройщик",
            "Подрядчик и прочее"]
        
        var selecteduserType:String? {
            didSet {
                if let userType = selecteduserType {
                    selecteduserTypeIndex = userTypes.index(of: userType)
                }
            }
        }
        var selecteduserTypeIndex:Int?
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return userTypes.count
        }
        
        //хранение имени и индекса выбраной ячейки
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userTypeCell", for: indexPath)
            cell.textLabel?.text = userTypes[indexPath.row]
            
            //выбор элемента (галочка)
            if indexPath.row == selecteduserTypeIndex {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
        
        //выбор строки
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            //Если выбрана другая строчка - нужно отменить выбор
            if let index = selecteduserTypeIndex {
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                cell?.accessoryType = .none
            }
            
            selecteduserType = userTypes[indexPath.row]
            
            //обновить выбор для нужной строки
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
        }
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "SaveSelecteduserType" {
                if let cell = sender as? UITableViewCell {
                    let indexPath = tableView.indexPath(for: cell)
                    if let index = indexPath?.row {
                        selecteduserType = userTypes[index]
                    }
                }
            }
        }
        
}
