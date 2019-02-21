//
//  DomNumRoomsTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 30.03.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class DomNumRoomsTableViewController: UITableViewController {

    var numRooms:[String] = [
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
        "15+"]
    
    var selectednumRoom:String? {
        didSet {
            if let numRoom = selectednumRoom {
                selectednumRoomIndex = numRooms.index(of: numRoom)
            }
        }
    }
    var selectednumRoomIndex:Int?
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowsInSectiontion: Int) -> Int {
        return numRooms.count
    }
    
    //хранение имени и индекса выбраной ячейки
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DomNumRoomsCell", for: indexPath)
        cell.textLabel?.text = numRooms[indexPath.row]
        
        //выбор элемента (галочка)
        if indexPath.row == selectednumRoomIndex {
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
        if let index = selectednumRoomIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectednumRoom = numRooms[indexPath.row]
        
        //обновить выбор для нужной строки
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DomSaveSelectedNumRooms" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: cell)
                if let index = indexPath?.row {
                    selectednumRoom = numRooms[index]
                }
            }
        }
    }
    
}
