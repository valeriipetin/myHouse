//
//  RentComTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 01.04.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class RentComTableViewController: UITableViewController {

    var coms:[String] = [
        "Включены в стоимость",
        "Оплачиваются дополнительно"]
    
    var selectedcom:String? {
        didSet {
            if let com = selectedcom {
                selectedcomIndex = coms.index(of: com)
            }
        }
    }
    var selectedcomIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coms.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SComCell", for: indexPath)
        cell.textLabel?.text = coms[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectedcomIndex {
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
        if let index = selectedcomIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedcom = coms[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SSaveSelectedCom" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectedcom = coms[index]
                }
            }
        }
    }
    
}
