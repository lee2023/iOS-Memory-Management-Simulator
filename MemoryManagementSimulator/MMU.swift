//
//  MMU.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/20/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class MMU {
    
    let offset = 1
    
//    func addProcessToTable(_newProcess: Process) {
//        let table = PageTable()
//        _newProcess.createVirtualAddress(pageNumber: 2)
//        table.addProcessAddressToTable(processVirtualAddress: 2)
//    }
    
    func createProcessPageTable(newProcess: Process) -> PageTable {
        //Create a page table for a process passed into this func
        let table = PageTable()
        return table
    }
    
    //Insert code to do the memory virtual address mapping to physical address
    func mapVirtualAddrToPhysicalAddr(virtualAddress: Int) -> Int {
        //hash the virtual address's physical address frame number
        let frameNumber = 0
        return frameNumber
    }
    
    func findProcessVirtualAddress() {
        
    }
    
    func findProcessPhysicalAddress() {
        
    }
    
    func fifoPageReplacementAlgorithm() {
        //insert the code to have 
    }
}
