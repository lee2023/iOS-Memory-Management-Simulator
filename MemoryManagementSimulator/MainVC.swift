//
//  ViewController.swift
//  MemoryManagementSimulator
//
//  Created by Rosemary Espinal on 11/20/16.
//  Copyright © 2016 Espinal Designs, LLC. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //Static arrays for UIPickerViews
    let sysArchs = ["32", "64"]
    let pageSizes = ["512", "1024", "2048", "4096", "8192"]
    let pageReplacementAlgorithms = ["FIFO"]
    
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
        //Code to run the actual simulation
        
        var checkTextFields = areTextFieldsEmpty()
        if (!checkTextFields) {
            //check for valid mem size entered and create number of processes, enter them in process queue
            
            let memSizeValid = checkIfMemSizeValid()
            
        }
        
        

        
        //Choose a process from the process queue
        
        //Access random pages from that processes VA space
        
        //Swap process with next process in FIFO queue and repeat above until queue is empty
        
        //perform a segue into the next VC which will show completed simulation
        
        //Completed simulation VC will show processes that ran in the queue, Hash Page Table, Physical memory
    }
    
    
    
    //Utility functions
    func checkIfMemSizeValid() -> Bool {
        //check to see that the physical mem size is divisible by page size
        let physicalMemSize = Int(memSizeTextField.text!)
        if (physicalMemSize! % 1024 == 0) {
            print("The physical memory size entered is valid.")
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

