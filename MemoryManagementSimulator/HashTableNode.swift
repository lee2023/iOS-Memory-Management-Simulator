//
//  HashTableNode.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/24/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class HashTableNode {
    var virtualPageNumber: Int
    var mappedPageFrameNumber: Int
    //Create a pointer to a HashTableNode
    weak var nextNode: HashTableNode?
    
    init(_virtualPageNumber: Int, _mappedPageFrameNumber: Int) {
        self.virtualPageNumber = _virtualPageNumber
        self.mappedPageFrameNumber = _mappedPageFrameNumber
    }
}

//var newNode = HashTableNode(_virtualPageNumber: 10, _mappedPageFrameNumber: 5)
//var head: HashTableNode?
//if(head?.nextNode == nil){
//    head = newNode
//}





