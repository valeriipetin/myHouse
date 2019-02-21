//
//  TypeTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 06.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class TypeTableViewController: UITableViewController {

    var types:[String] = [
        "Вторичка",
        "Новостройка"]
    
    var selectedType:String? {
        didSet {
            if let type = selectedType {
                selectedTypeIndex = types.index(of: type)
            }
        }
    }
    var selectedTypeIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    //Хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        cell.textLabel?.text = types[indexPath.row]
        
        //Выбор элемента (галочка)
        if indexPath.row == selectedTypeIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //Выбор строки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Если выбрана другая строчка - нужно отменить выбор
        if let index = selectedTypeIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedType = types[indexPath.row]
        
        //Обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedType" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedType = types[index]
                }
            }
        }
    }

}
