//
//  RentTypeDomTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 01.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class RentTypeDomTableViewController: UITableViewController {

    var typeDoms:[String] = [
        "Брежневка",
        "Другой",
        "Малоэтажка",
        "Общежитие",
        "Секционного типа",
        "Спецпроект",
        "Сталинка",
        "Хрущевка"]
    
    var selectedtypeDom:String? {
        didSet {
            if let typeDom = selectedtypeDom {
                selectedtypeDomIndex = typeDoms.index(of: typeDom)
            }
        }
    }
    var selectedtypeDomIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeDoms.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "STypeDomCell", for: indexPath)
        cell.textLabel?.text = typeDoms[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedtypeDomIndex {
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
        if let index = selectedtypeDomIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedtypeDom = typeDoms[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SSaveSelectedTypeDom" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedtypeDom = typeDoms[index]
                }
            }
        }
    }
    
}
