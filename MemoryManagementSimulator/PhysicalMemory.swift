//
//  PhysicalMemory.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/27/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation
import Darwin

class PhysicalMemory {
    var numberOfMemoryFrames: Int = 0
    var frameSize: Int = 0
    var physicalMemoryTable = [Int: Int]()
    var freeFrameList = [Int]()
    let defaultInitPageValue = -1
    var numberOfEntries: Int = 0
    
    func setFrameSize(frameSize: Int) -> Int {
        self.frameSize = frameSize
        return self.frameSize
    }
    
//    func createPhysicalMemory(memSizeEntered: Int) -> Int {
//        let power = 2.0
//        self.sizeOfMemory = Int(pow(power, Double(memSizeEntered)))
//        return self.sizeOfMemory
//    }
    
    func divideMemIntoFrames(physicalMemSize: Int) -> Int {
        if (self.frameSize == 0) {
            print("The frame size has not been set!")
        }
        numberOfMemoryFrames = physicalMemSize/frameSize
        if (numberOfMemoryFrames % 512 == 0) {
            print("Memory has been successfully divided into frames of size: \(self.frameSize)")
        }
        return numberOfMemoryFrames
    }
    
    //Fix this method. The number of frames is wrong.
    func createPhysicalMemoryTable(numberOfFrames: Int) -> Dictionary<Int, Int> {
        for i in 0...numberOfFrames - 1 {
            physicalMemoryTable.updateValue(self.defaultInitPageValue, forKey: i)
        }
        numberOfEntries = physicalMemoryTable.count
        print("The number of entries in the table are: \(numberOfEntries)")
        return physicalMemoryTable
    }
    
    //Loads pages into memory
    func insertPageIntoMemTable(frameNumber: Int, pageNumber: Int) {
        physicalMemoryTable.updateValue(pageNumber, forKey: frameNumber)
    }
    
    func getFreeFrameList() -> [Int] {
        for (key, value) in physicalMemoryTable {
            //only add keys for frames that are available
            if (value == self.defaultInitPageValue){
                freeFrameList.append(key)
            }
        }
        return freeFrameList
    }
    
    //changing return from [Int: Int] to Dictionary<Int, Int>
    func printPhysicalMemoryTable() -> Dictionary<Int, Int> {
        if (physicalMemoryTable.isEmpty) {
            print("The physical memory table is empty.")
        }
        
        for (key, value) in physicalMemoryTable {
            print("[ Frame Number: \(key) , Page Number: \(value) ]")
        }
        return physicalMemoryTable
    }
}
