//
//  PageTable.swift
//  MemoryManagementSimulator
//
//  Created by Leo Espinal on 11/21/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class HashedPageTable {
    //Page table (Hash Table) [ page# : Node(page#, frame#, pointer next node) ]
    var pageTable = [Int: HashTableNode]()
    var head = HashTableNode()
    
    private func hashFunction(pageNumber: Int) -> Int {
        let pageHashValue = pageNumber.hashValue
        return pageHashValue
    }
    
    func searchToAdd(pageNumber: Int) -> Int {
        return hashFunction(pageNumber: pageNumber)
    }
    
    func addToTable(processVirtualPageNumber: Int, processMappedFrameNumber: Int) {
        //find bucket to insert new node at
        let bucket = searchToAdd(pageNumber: processVirtualPageNumber)
        
        //create the new node
        let node = HashTableNode()
        node.setVirtualPageNumber(_virtualPageNumber: processVirtualPageNumber)
        node.setMappedPageFrameNumber(_mappedPageFrameNumber: processMappedFrameNumber)
        //set the pointer for the next node
        node.setNext(nextNode: head)
        //node.nextNode = pageTable.index(forKey: bucket)
        pageTable.updateValue(node, forKey: bucket)
    }
    
    func search(pageNumber: Int) -> HashTableNode {
        let bucket = hashFunction(pageNumber: pageNumber)
        var nodePointer = pageTable[bucket]
        
        while (nodePointer?.nextNode != nil) {
            if(nodePointer?.getVirtualPageNumber() == pageNumber) {
                return nodePointer!
            }
            nodePointer = nodePointer?.nextNode
        }
        return nodePointer!
    }
    
    //Used to handle updating page table in the case of a page fault
    func updatePageTable(processVirtualPageNumber: Int, processMappedFrame: Int) {
        let nodeToFind = search(pageNumber: processVirtualPageNumber)
        pageTable.updateValue(nodeToFind, forKey: processVirtualPageNumber)
    }
    
    func printPageTable() -> [Int: HashTableNode] {
        if pageTable.isEmpty {
            print("The page table is empty! No process address spaces page have been added!")
        }
        
        for (key, value) in pageTable {
            print("[ Page Number: \(key) : Frame Number: \(value.getMappedPageFrameNumber()) ]")
        }
        var storedTable = pageTable
        return storedTable
    }

}
