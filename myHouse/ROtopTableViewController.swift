//
//  ROtopTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 02.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class ROtopTableViewController: UITableViewController {

    var otops:[String] = [
        "Автономное",
        "Газовое",
        "Нет",
        "Печное",
        "Центральное",
        "Электрическое"]
    
    var selectedotop:String? {
        didSet {
            if let otop = selectedotop {
                selectedotopIndex = otops.index(of: otop)
            }
        }
    }
    var selectedotopIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otops.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ROtopCell", for: indexPath)
        cell.textLabel?.text = otops[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedotopIndex {
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
        if let index = selectedotopIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedotop = otops[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RSaveSelectedOtop" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedotop = otops[index]
                }
            }
        }
    }
}
