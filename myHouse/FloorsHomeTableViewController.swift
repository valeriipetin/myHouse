//
//  FloorTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 12.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class FloorsHomeTableViewController: UITableViewController {
    
    var floorsHomes:[String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24",
        "25"]
    
    var selectedFloorsHome:String? {
        didSet {
            if let floorsHome = selectedFloorsHome {
                selectedFloorsHomeIndex = floorsHomes.index(of: floorsHome)
            }
        }
    }
    var selectedFloorsHomeIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return floorsHomes.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FloorsHomeCell", for: indexPath)
        cell.textLabel?.text = floorsHomes[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedFloorsHomeIndex {
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
        if let index = selectedFloorsHomeIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedFloorsHome = floorsHomes[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedFloorsHome" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedFloorsHome = floorsHomes[index]
                }
            }
        }
    }
    
}
