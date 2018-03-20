//
//  HashTableNode.swift
//  MemoryManagementSimulator
//
//  Created by Leo Espinal on 11/24/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class HashTableNode {
    var virtualPageNumber: Int
    var mappedPageFrameNumber: Int
    //weak var nextNode: HashTableNode? //Create a pointer to a HashTableNode
    var nextNode: HashTableNode? //Create a pointer to a HashTableNode
    
    init() {
        virtualPageNumber = 0
        mappedPageFrameNumber = 0
    }
    
    func getVirtualPageNumber() -> Int {
        return self.virtualPageNumber
    }
    
    func setVirtualPageNumber(_virtualPageNumber: Int) {
        self.virtualPageNumber = _virtualPageNumber
    }
    
    func getMappedPageFrameNumber() -> Int {
        return self.mappedPageFrameNumber
    }
    
    func setMappedPageFrameNumber(_mappedPageFrameNumber: Int) {
        self.mappedPageFrameNumber = _mappedPageFrameNumber
    }
    
    func getNext() -> HashTableNode {
        return self.nextNode!
    }
    
    func setNext(nextNode: HashTableNode) {
        self.nextNode = nextNode
    }
}
