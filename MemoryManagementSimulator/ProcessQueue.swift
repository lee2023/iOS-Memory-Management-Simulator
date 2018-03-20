//
//  ProcessQueue.swift
//  MemoryManagementSimulator
//
//  Created by Leo Espinal on 11/21/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import Foundation

class ProcessQueue {
    var queue = [Process]() //empty queue

    
    //Method to add to queue
    func addToQueue (newProcess: Process) {
        if (isEmpty()) {
            queue.insert(newProcess, at: 0)
        } else {
            //Insert the new process at the end of the queue
            let lastIndex = size()
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
    
    //Return the process queue object to caller
    func getProcessQueue() -> [Process] {
        return queue
    }
    
    //Method to check if queue is empty
    func isEmpty() -> Bool {
        if (queue.count == 0) {
            return true
        }
        return false
    }
}
