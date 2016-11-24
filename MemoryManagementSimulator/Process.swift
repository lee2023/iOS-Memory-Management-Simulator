//
//  Process.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/21/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation
import Darwin //allows me to use random number generator function

class Process {
    var name: String = ""
    var pid = Int(arc4random_uniform(100) + 1)
    var numberOfPages = Int(arc4random_uniform(10) + 1)
    var virtualAddress: Int?
    var virtualAddressSpaceSize: Int?
    //randomly chosen offset value
    let virtualAddressOffset = 1
   
    
    //Process init function
    init(_name: String) {
        self.name = _name
    }
    
    //Returns the pid of the process
    func getPid () -> Int {
        print("Process \(name) has pid \(pid)")
        return self.pid
    }
    
    //Check to see if randomly generated number of pages is 0
    func isNumberOfPagesforProcessZero() -> Bool {
        if (self.numberOfPages == 0) {
            //each process must have at least 1 page
            return true
        }
        return false
    }
    
    //Number of pages in virtual address space = virtualAddressSpace/pageSize
    func numberOfProcessPages(pageSize: Int) -> Int {
        if (isNumberOfPagesforProcessZero()) {
            print("Failed to determine the number of pages. Generated pages for the process was \(self.numberOfPages).")
            return self.numberOfPages
        }
        
        let numberOfProcessPages: Int?
        //check to see if the virtualAddressSpaceSize variable value has been set
        if (virtualAddressSpaceSize != nil) {
            numberOfProcessPages = Int(virtualAddressSpaceSize!)/pageSize
            print("Process virtual address space size is: \(virtualAddressSpaceSize) and number of pages is: \(numberOfProcessPages)")
            return numberOfProcessPages!
        }
        return 0
    }
    
    //Create the virtual address space
    func createVirtualAddressSpace() -> Int {
        let power = 2.0
        let addressSpace = Int(arc4random_uniform(25) + 1)
        let addressSpaceSize = pow(power, Double(addressSpace))
        self.virtualAddressSpaceSize = Int(addressSpaceSize)
        print("My address space is: \(addressSpace) and my address space size is: \(self.virtualAddressSpaceSize)")
        return self.virtualAddressSpaceSize!
    }
    
    
    //Process virtual address: VA = page# + offset
    func createVirtualAddress(pageNumber: Int) -> Int {
        self.virtualAddress = pageNumber + virtualAddressOffset
        print("Process page number is \(pageNumber) and the offset is \(virtualAddressOffset)")
        return self.virtualAddress!
    }
}

