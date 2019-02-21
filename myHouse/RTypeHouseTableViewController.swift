//
//  RTypeHouseTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 02.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class RTypeHouseTableViewController: UITableViewController {

    var types:[String] = [
        "Дом",
        "Коттедж",
        "Таунхаус",
        "Часть дома",
        "Часть коттеджа"]
    
    var selectedtype:String? {
        didSet {
            if let type = selectedtype {
                selectedtypeIndex = types.index(of: type)
            }
        }
    }
    var selectedtypeIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RTypeCell", for: indexPath)
        cell.textLabel?.text = types[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedtypeIndex {
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
        if let index = selectedtypeIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedtype = types[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RSaveSelectedType" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedtype = types[index]
                }
            }
        }
    }
    
}
