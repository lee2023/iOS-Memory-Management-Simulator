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
    let memory = globalPhysicalMemTable
    
    //IBOutlets for process data labels
    @IBOutlet weak var pidLabel: UILabel!
    @IBOutlet weak var virtualAddressLabel: UILabel!
    @IBOutlet weak var numberOfPagesLabel: UILabel!
    @IBOutlet weak var numberOfPagesInMemLabel: UILabel!
    @IBOutlet weak var numberOfPageFaultsLabel: UILabel!
    @IBOutlet weak var pageTabelTextView: UITextView!
    @IBOutlet weak var physicalMemoryTableTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let processPid = process!.getPid()
        pidLabel.text = String(processPid)
        
        let virtualAddressSpace = process!.getVirtualAddressSpaceSize()
        virtualAddressLabel!.text = String(virtualAddressSpace)
        
        let numOfPages = process!.numberOfProcessPages
        numberOfPagesLabel.text = String(numOfPages)
        
        let numOfPagesInMem = process!.getPagesAccessed()
        numberOfPagesInMemLabel.text = "[ \(String(numOfPagesInMem)) ]"
        
        let pageTable = process!.pageTable
        for (key, value) in pageTable! {
            //only print out the non-empty entries of the page table
            if (key != -1 && value.getMappedPageFrameNumber() != -1){
                pageTabelTextView.insertText("[ Page Number: \(key) | Frame Number: \(value.getMappedPageFrameNumber()) ]\n")
            }
        }
        
        //this is correctly storing the memory table but the data is not see in the text view
        let memoryTable = globalPhysicalMemTable
        for (key, value) in memoryTable {
            //only print out the entries in the memory table
            physicalMemoryTableTextView.insertText("[ Frame Number: \(key) | Page Number: \(value) ]\n")
        }
        
    }
}
