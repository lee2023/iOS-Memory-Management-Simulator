//
//  ViewController.swift
//  MemoryManagementSimulator
//
//  Created by Leo Espinal on 11/20/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import UIKit

var globalProcessQueue = [Process]()
var globalPhysicalMemTable: [Int:Int] = [:]

class MainVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource {

    //Static arrays for UIPickerViews
    let sysArchs = ["64"]
    let pageSizes = ["512", "1024", "2048", "4096", "8192"]
    let pageReplacementAlgorithms = ["FIFO", "LRU", "NRU"]
    
    //IBOutlets for labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sysArchLabel: UILabel!
    @IBOutlet weak var memSizeLabel: UILabel!
    @IBOutlet weak var pageSizeLabel: UILabel!
    @IBOutlet weak var numOfProcessesLabel: UILabel!
    @IBOutlet weak var pageAlgorithmLabel: UILabel!
    
    //IBOutlets for buttons
    @IBOutlet weak var sysArchButton: UIButton!
    @IBOutlet weak var pageSizeButton: UIButton!
    @IBOutlet weak var pageAlgorithmButton: UIButton!
    @IBOutlet weak var simluateButton: UIButton!
    
    
    //IBOutlets for text fields
    @IBOutlet weak var memSizeTextField: UITextField!
    @IBOutlet weak var numOfProcessesTextField: UITextField!
    
    //IBOutlets for UIPickerViews
    @IBOutlet weak var sysArchPicker: UIPickerView!
    @IBOutlet weak var pageSizePicker: UIPickerView!
    @IBOutlet weak var algorithmPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        sysArchPicker.dataSource = self
        sysArchPicker.delegate = self
        pageSizePicker.dataSource = self
        pageSizePicker.delegate = self
        algorithmPicker.dataSource = self
        algorithmPicker.delegate = self
        
    }

    //IBActions for buttons
    @IBAction func sysArchButtonPressed(_ sender: Any) {
        memSizeLabel.isHidden = true
        memSizeTextField.isHidden = true
        pageSizeLabel.isHidden = true
        pageSizeButton.isHidden = true
        numOfProcessesLabel.isHidden = true
        numOfProcessesTextField.isHidden = true
        pageAlgorithmLabel.isHidden = true
        pageAlgorithmButton.isHidden = true
        sysArchPicker.isHidden = false
    }
    
    @IBAction func pageSizeButtonPressed(_ sender: Any) {
        numOfProcessesLabel.isHidden = true
        numOfProcessesTextField.isHidden = true
        pageAlgorithmLabel.isHidden = true
        pageAlgorithmButton.isHidden = true
        pageSizePicker.isHidden = false
    }
    
    @IBAction func pageAlgorithmButtonPressed(_ sender: Any) {
        algorithmPicker.isHidden = false
    }
    
    
    //UIPicker protocol functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1) {
            return sysArchs.count
        } else if(pickerView.tag == 2) {
            return pageSizes.count
        } else if(pickerView.tag == 3) {
            return pageReplacementAlgorithms.count
        }
        //Some error occurred
        print("An error occurred while getting number of rows for a picker view!")
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1) {
            return sysArchs[row]
        } else if(pickerView.tag == 2) {
            return pageSizes[row]
        } else if(pickerView.tag == 3) {
            return pageReplacementAlgorithms[row]
        }
        //Some error occurred
        print("An error occurred while getting row titles for a picker view!")
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1) {
            sysArchButton.setTitle(sysArchs[row], for: UIControlState.normal)
            sysArchPicker.isHidden = true
            memSizeLabel.isHidden = false
            memSizeTextField.isHidden = false
            pageSizeLabel.isHidden = false
            pageSizeButton.isHidden = false
            numOfProcessesLabel.isHidden = false
            numOfProcessesTextField.isHidden = false
            pageAlgorithmLabel.isHidden = false
            pageAlgorithmButton.isHidden = false
        }
        
        else if(pickerView.tag == 2) {
            pageSizeButton.setTitle(pageSizes[row], for: UIControlState.normal)
            pageSizePicker.isHidden = true
            numOfProcessesLabel.isHidden = false
            numOfProcessesTextField.isHidden = false
            pageAlgorithmLabel.isHidden = false
            pageAlgorithmButton.isHidden = false
        }
        
        else if(pickerView.tag == 3) {
            pageAlgorithmButton.setTitle(pageReplacementAlgorithms[row], for: UIControlState.normal)
            algorithmPicker.isHidden = true
        }

    }
    
    
    @IBAction func simulateButtonPressed(_ sender: Any) {
        
        var numberOfProcesses: Int? = 0
        var physicalMemSize: Int? = 0
        
        let checkTextFields = areTextFieldsEmpty()
        if (!checkTextFields) {
            //check for valid mem size entered and create number of processes, enter them in process queue
            
            //Get number of processes from text field
            numberOfProcesses = Int(numOfProcessesTextField.text!)!
            
            //Get the physical memory size from memSize text field
            physicalMemSize = Int(memSizeTextField.text!)!
        }
        
        
        //Create process objects and add them to the process queue
        let processQueue = ProcessQueue()
        if (numberOfProcesses! != 0) {
            for count in 0...numberOfProcesses!-1 {
                let newProcess = Process(_name: "P\(count)")
                processQueue.addToQueue(newProcess: newProcess)
            }
            processQueue.printQueue()
        }

        //Get the page size from the pageSizeButton
        let pageSize: Int = Int(pageSizeButton.title(for: UIControlState.normal)!)!
        print("The selected page size is: \(pageSize)")
        

        if (checkIfMemSizeValid(memSize: physicalMemSize!)) {
            print("Physical memory size entered is: \(physicalMemSize!)")
        } else {
            //Insert popup message to user letting them know they need to re-enter
            print("The should be a UI popup notification!")
        }
        
        //Create physical memory address space and table
        let memory = PhysicalMemory()
        let frameSize = memory.setFrameSize(frameSize: pageSize)
        let numberOfFrames = memory.divideMemIntoFrames(physicalMemSize: physicalMemSize!)
        
        //Store newly created physical memory table
        let physicalMemoryTable = memory.createPhysicalMemoryTable(numberOfFrames: numberOfFrames)
        //memory.printPhysicalMemoryTable()
        print("Number of frames in the physical memory table are: \(numberOfFrames)")
        
        //Create CPU and MMU objects, and get the process queue array
        let cpu = CPU()
        let mmu = MMU()
        let queue = processQueue.getProcessQueue()
        
        for processObject in queue {
            
            //Have the CPU generate the virtual address space, page table
            let processPageVirtualAddressAndPageTable = cpu.generateVirtualAddress(process: processObject, pageSize: pageSize)
            let processVirtualAddress = processPageVirtualAddressAndPageTable.0
            let processPageTable = processPageVirtualAddressAndPageTable.1
            //processPageTable.printPageTable()
            
            //Have the MMU split the page virtual address
            let pageAddressNoOffset = mmu.splitVirtualAddress(process: processObject)
            
            //Have MMU map an avaiblble memory frame to process page, then map virtual address to physical address
            mmu.mapFrameToProcessPage(process: processObject, memory: memory, pageTable: processPageTable)
            mmu.mapVirtualAddrToPhysicalAddr(process: processObject, pageTable: processPageTable, memory: memory)
            
            print("Process page table after MMU mapping:")
            print(" ")
            let storedProcessPageTable = processPageTable.printPageTable()
            
            //store the populated page table for the process
            processObject.pageTable = storedProcessPageTable
            
            print(" ")
            print("Physical memory table after MMU mapping:")
            memory.printPhysicalMemoryTable()
            
        }
        
        //sets global process queue variable to the populated process queue
        globalProcessQueue.append(contentsOf: queue)
        
        //sets global physical memory table with populated table
        let memTable = memory.printPhysicalMemoryTable()
        for (key , value) in memTable {
            globalPhysicalMemTable.updateValue(value, forKey: key)
        }
    
        
        //Choose a process from the process queue
        
        //Access random pages from that processes VA space
        
        //Swap process with next process in FIFO queue and repeat above until queue is empty
        
        //perform a segue into the next VC which will show completed simulation
        
        //Completed simulation VC will show processes that ran in the queue, Hash Page Table, Physical memory
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalProcessQueue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell() //create a new cell
        var count = 0
        for process in globalProcessQueue {
            if (count == indexPath.row) {
                tableCell.textLabel!.text = process.name
                break
            }
            count += 1
        }
        
        return tableCell
    }

    
    //Utility functions
    func checkIfMemSizeValid(memSize: Int) -> Bool {
        //check to see that the physical mem size is divisible by page size
        if (memSize % 512 == 0) {
            return true
        }
        return false
    }
    
    func areTextFieldsEmpty() -> Bool {
        if (memSizeTextField.text == "") || (numOfProcessesTextField.text == "") {
            print("One of the two required text fields are empty!")
            return true
        }
        return false
    }

}

