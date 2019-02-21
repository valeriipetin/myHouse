//
//  DomTypeOtopTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 30.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class DomTypeOtopTableViewController: UITableViewController {

    var otopTypes:[String] = [
        "Водяное",
        "Воздушное",
        "Газовое",
        "Паровое",
        "Печное",
        "Печное-водяное",
        "Электрическое"]
    
    var selectedotopType:String? {
        didSet {
            if let otopType = selectedotopType {
                selectedotopTypeIndex = otopTypes.index(of: otopType)
            }
        }
    }
    var selectedotopTypeIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otopTypes.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DomOtopTypeCell", for: indexPath)
        cell.textLabel?.text = otopTypes[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedotopTypeIndex {
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
        if let index = selectedotopTypeIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedotopType = otopTypes[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DomSaveSelectedOtopType" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedotopType = otopTypes[index]
                }
            }
        }
    }
}

