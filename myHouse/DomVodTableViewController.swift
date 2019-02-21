//
//  DomVodTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 30.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class DomVodTableViewController: UITableViewController {

    var vods:[String] = [
        "Автономное",
        "Нет",
        "Центральное"]
    
    var selectedvod:String? {
        didSet {
            if let vod = selectedvod {
                selectedvodIndex = vods.index(of: vod)
            }
        }
    }
    var selectedvodIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vods.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DomVodCell", for: indexPath)
        cell.textLabel?.text = vods[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedvodIndex {
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
        if let index = selectedvodIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedvod = vods[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DomSaveSelectedVod" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedvod = vods[index]
                }
            }
        }
    }
    
}
