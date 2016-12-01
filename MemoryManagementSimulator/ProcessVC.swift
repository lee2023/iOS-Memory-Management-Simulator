//
//  ProcessVC.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/29/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import UIKit

class ProcessVC: UIViewController, UITableViewDelegate, UISplitViewControllerDelegate {

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
        self.splitViewController?.preferredDisplayMode = .allVisible
        self.splitViewController?.delegate = self
    }
    
    //Will show table view by default on any device that is not an iPad
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
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
