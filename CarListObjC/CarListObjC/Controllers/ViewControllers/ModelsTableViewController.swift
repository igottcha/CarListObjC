//
//  ModelsTableViewController.swift
//  CarListObjC
//
//  Created by Chris Gottfredson on 3/26/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class ModelsTableViewController: UITableViewController {

    //MARK: - Properties
    
    var make: CTTMake?
    var models: [CTTModel] = [] {
        didSet
        {
            self.updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let make = make else { return }
        CTTModelController.fetchModels(make.makeID) { (models) in
            self.models = models
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modelCell", for: indexPath)
        let model = models[indexPath.row]
        
        cell.textLabel?.text = model.name

        return cell
    }
    
    //MARK: - Methods
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
