//
//  ProcessQueue.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/21/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class ProcessQueue {
    var queue = [Process]() //empty queue
    var head: Process?
    var tail: Process?
    
    //Method to add to queue
    func addToQueue (newProcess: Process) {
        if (isEmpty()) {
            queue.append(newProcess)
            head = queue.first
            tail = queue.last
        } else {
            //Insert the new process at the end of the queue
            let lastIndex = size() - 1
            queue.insert(newProcess, at: lastIndex)
        }
    }
    
    //Method to remove from queue
    func removeFromQueue () {
        if (isEmpty()) {
            return
        }
        queue.removeFirst()
    }
    
    //Method to get size of queue
    func size() -> Int {
        return queue.count
    }
    
    //Method to see first element in queue
    func peek() -> Process {
        if (isEmpty()) {
            return queue[-1]
        }
        return queue.first!
    }
    
    //Print the entire queue
    func printQueue() {
        if (size() == 0) {
            return
        }
        for process in queue {
            print("[ \(process.name) ]")
        }
    }
    
    //Method to check if queue is empty
    func isEmpty() -> Bool {
        if (queue.count == 0) {
            return true
        }
        return false
    }
}
