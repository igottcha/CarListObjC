//
//  MakesTableViewController.swift
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class MakesTableViewController: UITableViewController {

    //MARK: - Properties
    
    var manufacturer: CTTManufacturer?
    var makes: [CTTMake] = [] {
        didSet
        {
            self.updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let manufacturer = manufacturer else { return }
        CTTMakeController.fetchMakes(manufacturer.mfrID) { (makes) in
            self.makes = makes
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return makes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "makeCell", for: indexPath)
        let make = makes[indexPath.row]
        cell.textLabel?.text = make.name

        return cell
    }
  
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toModel" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? ModelsTableViewController else { return }
            let make = makes[indexPath.row]
            destinationVC.make = make
        }
    }
    
    //MARK: - Models
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

}
