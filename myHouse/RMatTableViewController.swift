//
//  RMatTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 02.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class RMatTableViewController: UITableViewController {

    var mats:[String] = [
        "Бетонные блоки",
        "Дерево",
        "Другое",
        "Кирпич",
        "Кирпич-монолит",
        "Монолит",
        "Панель",
        "Шлакоблоки"]
    
    var selectedmat:String? {
        didSet {
            if let mat = selectedmat {
                selectedmatIndex = mats.index(of: mat)
            }
        }
    }
    var selectedmatIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mats.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RMatCell", for: indexPath)
        cell.textLabel?.text = mats[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedmatIndex {
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
        if let index = selectedmatIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedmat = mats[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RSaveSelectedMat" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedmat = mats[index]
                }
            }
        }
    }
}
