//
//  PageTable.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/21/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class PageTable {
    //Page table (Hash Table) [ page# : frame# ]
    var pageTable = [Int: Int]()

    private func hashFunction(pageNumber: Int) -> Int {
        //var frameNumber: Int
        var frameNumber = 0
        for (key) in pageTable {
            if key.key == pageNumber {
                frameNumber = key.value
                print("Frame number for page number: \(pageNumber) is \(frameNumber)")
                break
            }
        }
        return frameNumber
    }
    
    func printPageTable() {
        if pageTable.isEmpty {
            print("The page table is empty! No process address spaces have been added!")
        }
        
        for (key, value) in pageTable {
            print("[\(key) : \(value)]")
        }
    }
    
    func addProcessAddressToTable(processVirtualAddress: Int) {
        
    }
}
