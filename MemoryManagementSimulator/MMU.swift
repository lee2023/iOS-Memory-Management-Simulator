//
//  MMU.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/20/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation
import Darwin

class MMU {
    let memory = PhysicalMemory()
    let offset = 1
    var processVirtualAddressNoOffset: Int = 0
    
    func mapVirtualAddrToPhysicalAddr(process: Process, pageTable: HashedPageTable, memory: PhysicalMemory) {
        //check to see that the frame was found for the process
        let pageTableCheck = isFrameInPageTable(process: process, pageTable: pageTable)
        if (pageTableCheck.0) {
            //add the frame number and offset together
            let physicalAddress = pageTableCheck.1 + offset
            let virtualAddress = pageTableCheck.2
            memory.insertPageIntoMemTable(frameNumber: physicalAddress, pageNumber: virtualAddress)
            
            //Add accessed page to fifo queue
            //process.populatefifoQueue(process: process)
        }
    }
    
    func splitVirtualAddress(process: Process) -> Int {
        let processVirtualAddress = process.getVirtualAddressWithOffset()
        processVirtualAddressNoOffset = processVirtualAddress - offset
        return processVirtualAddressNoOffset
    }
    
    //If the frame is found, return true (page table hit), physical address, and split virtual address
    func isFrameInPageTable(process: Process, pageTable: HashedPageTable) -> (Bool, Int, Int) {
        let virtualAddress = splitVirtualAddress(process: process)
        let frameNumber = pageTable.search(pageNumber: virtualAddress).getMappedPageFrameNumber()
        if (frameNumber != -1) {
            return (true, frameNumber, virtualAddress)
        } else {
            //generate a page fault
            process.numberOfPageFaults += 1
            generatePageFault(process: process, processPageTable: pageTable, memory: memory)
        }
        return (false, -1, -1)
    }
    
    func mapFrameToProcessPage(process: Process, memory: PhysicalMemory, pageTable: HashedPageTable) {
        let freeFrames = memory.getFreeFrameList()
        let frameSelectedToMap = arc4random_uniform(UInt32(freeFrames.count))
        //let processPageVirtualAddress = splitVirtualAddress(process: process)
        //pageTable.updatePageTable(processVirtualPageNumber: processVirtualAddressNoOffset, processMappedFrame: Int(frameSelectedToMap)) //this is a bug, there is a bug in hash table search function
        pageTable.addToTable(processVirtualPageNumber: processVirtualAddressNoOffset, processMappedFrameNumber: Int(frameSelectedToMap))
    }
    
    func generatePageFault(process: Process, processPageTable: HashedPageTable, memory: PhysicalMemory) {
        let cpu = CPU()
        cpu.handlePageFault(process: process, processPageTable: processPageTable, memory: memory)
    }
    
}












