//
//  DetailVC.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/28/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var process: Process?
    
    //IBOutlets for process data labels
    @IBOutlet weak var pidLabel: UILabel!
    @IBOutlet weak var virtualAddressLabel: UILabel!
    @IBOutlet weak var numberOfPagesLabel: UILabel!
    @IBOutlet weak var numberOfPagesInMemLabel: UILabel!
    @IBOutlet weak var numberOfPageFaultsLabel: UILabel!
    @IBOutlet weak var pageTabelTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let processPid = process!.getPid()
        pidLabel.text = String(processPid)
        
        let virtualAddressSpace = process!.getVirtualAddressSpaceSize()
        virtualAddressLabel!.text = String(virtualAddressSpace)
        
        let numOfPages = process!.numberOfProcessPages
        numberOfPagesLabel.text = String(numOfPages)
        
        let numOfPagesInMem = process!.getNumberOfPagesAccessed()
        numberOfPagesInMemLabel.text = "[ \(String(numOfPagesInMem)) ]"
        
        let pageTable = process!.pageTable
        for (key, value) in pageTable! {
            //only print out the non-empty entries of the page table
            if (key != -1 && value.getMappedPageFrameNumber() != -1){
                pageTabelTextView.insertText("[ Page Number: \(key) | Frame Number: \(value.getMappedPageFrameNumber()) ]\n")
            }
        }
    }
}
