//
//  DachAvtTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 31.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class DachAvtTableViewController: UITableViewController {

    var avts:[String] = [
        "10 минут пешком",
        "20 минут пешком",
        "Нет рядом"]
    
    var selectedavt:String? {
        didSet {
            if let avt = selectedavt {
                selectedavtIndex = avts.index(of: avt)
            }
        }
    }
    var selectedavtIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avts.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DachAvtCell", for: indexPath)
        cell.textLabel?.text = avts[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedavtIndex {
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
        if let index = selectedavtIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedavt = avts[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DachSaveSelectedAvt" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedavt = avts[index]
                }
            }
        }
    }
    
}

