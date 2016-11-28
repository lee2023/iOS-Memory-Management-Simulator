//
//  MMU.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/20/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class MMU {
    let memory = PhysicalMemory()
    let offset = 1
    
    func mapVirtualAddrToPhysicalAddr(process: Process, pageTable: HashedPageTable) {
        //check to see that the frame was found for the process
        let pageTableCheck = isFrameInPageTable(process: process, pageTable: pageTable)
        if (pageTableCheck.0) {
            //add the frame number and offset together
            let physicalAddress = pageTableCheck.1 + offset
            let virtualAddress = pageTableCheck.2
            memory.insertPageIntoMemTable(frameNumber: physicalAddress, pageNumber: virtualAddress)
        }
    }
    
    func splitVirtualAddress(process: Process) -> Int {
        let processVirtualAddress = process.getVirtualAddressWithOffset()
        let processVirtualAddressNoOffset = processVirtualAddress - offset
        return processVirtualAddressNoOffset
    }
    
    //If the frame is found, return true, physical address, and split virtual address
    func isFrameInPageTable(process: Process, pageTable: HashedPageTable) -> (Bool, Int, Int) {
        let virtualAddress = splitVirtualAddress(process: process)
        let frameNumber = pageTable.search(pageNumber: virtualAddress).getMappedPageFrameNumber()
        if (frameNumber != -1) {
            return (true, frameNumber, virtualAddress)
        }
        
        //generate a page fault
        generatePageFault(process: process, processPageTable: pageTable, memory: self.memory)
        return (false, -1, -1)
    }
    
    func generatePageFault(process: Process, processPageTable: HashedPageTable, memory: PhysicalMemory) {
        let cpu = CPU()
        cpu.handlePageFault(process: process, processPageTable: processPageTable, memory: memory)
    }
    
    func fifoPageReplacementAlgorithm() {
        //insert the code to do FIFO page replacement
    }
}
