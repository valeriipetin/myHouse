//
//  DomGasTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 30.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class DomGasTableViewController: UITableViewController {

    var gass:[String] = [
        "Газопровод",
        "Автономное",
        "Нет",
        "Центральное"]
    
    var selectedgas:String? {
        didSet {
            if let gas = selectedgas {
                selectedgasIndex = gass.index(of: gas)
            }
        }
    }
    var selectedgasIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gass.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DomGasCell", for: indexPath)
        cell.textLabel?.text = gass[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedgasIndex {
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
        if let index = selectedgasIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedgas = gass[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DomSaveSelectedGas" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedgas = gass[index]
                }
            }
        }
    }
    
}
