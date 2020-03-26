//
//  ManufacturerTableViewController.swift
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class ManufacturersTableViewController: UITableViewController {

    var manufacturers: [CTTManufacturer] = [] {
        didSet
        {
            self.updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CTTManufacturerController.fetchManufacturers { (manufacturers) in
            self.manufacturers = manufacturers
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mfrCell", for: indexPath)
        let manufacturer = manufacturers[indexPath.row]

        cell.textLabel?.text = manufacturer.name
        cell.detailTextLabel?.text = manufacturer.country
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMake" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? MakesTableViewController else { return }
            let manufacturer = manufacturers[indexPath.row]
            destinationVC.manufacturer = manufacturer
        }
    }

    //MARK: - Methods
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
