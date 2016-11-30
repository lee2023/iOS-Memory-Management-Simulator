//
//  ProcessVC.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/29/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import UIKit

class ProcessVC: UIViewController, UITableViewDelegate {

    @IBOutlet var processTableView: UITableView!
    var dataSource: MainVC?
    var processCellSelected: Int!
    var processToSend: Process!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Transferred the data source from the MainVC
        dataSource = MainVC()
        self.processTableView.dataSource = dataSource
        self.processTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do a segue to DetailVC
        processCellSelected = indexPath.row
        processToSend = globalProcessQueue[processCellSelected]
        self.performSegue(withIdentifier: "moveToDetailSegue", sender: processToSend)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailVC
        detailVC.process = processToSend
    }
    
}
