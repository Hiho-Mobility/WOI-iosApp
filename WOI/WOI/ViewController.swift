//
//  ViewController.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-01.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomepageController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var borderBox: UIView!
    
    @IBOutlet var workOrderNumber: UITextField!
    

    @IBOutlet var evaluatedTechnician: UITextField!
    
    @IBOutlet var managerNameDropdown: UITextField!
    
    @IBOutlet var whenDropdown: UITextField!
    
    var ref: DatabaseReference?


    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    
    var techList = ["Hussein N", "Kunjan B", "Rumi K", "Jasmine S", "Amy V", "Alan K"]
    var managerList = ["Tim L",  "Jay S", "Bob Smith", "John Guy", "Navendra Mahatra Shivani Panday"]
    var statusList = ["During job", "Completed Job"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        navigationItem.title = "Work Order Inspections"
        

        borderBox.layer.borderWidth = 1
        borderBox.layer.borderColor = UIColor.gray.cgColor
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTextField == managerNameDropdown{
            return managerList.count
        }else if currentTextField == evaluatedTechnician {
            return techList.count
        }else if currentTextField == whenDropdown{
            return statusList.count
        }else{
            return 0
        }
      
    }
   
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if currentTextField == managerNameDropdown{
            return managerList[row]
        }else if currentTextField == evaluatedTechnician{
            return techList[row]
        }else if currentTextField == whenDropdown{
            return statusList[row]
        }else {
            return ""
        }
        
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if currentTextField == evaluatedTechnician{
             self.evaluatedTechnician.text = self.techList[row]
            self.view.endEditing(true)
            // self.evaluatedTechDropdown.isHidden = true
            
        }
        else if currentTextField == managerNameDropdown {
            self.managerNameDropdown.text = self.managerList[row]
             self.view.endEditing(true)
         //   self.evaluatedTechDropdown.isHidden = true
        }else if currentTextField == whenDropdown{
            self.whenDropdown.text = self.statusList[row]
             self.view.endEditing(true)
           // self.evaluatedTechDropdown.isHidden = true
        }
       
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        currentTextField = textField
        
        if currentTextField == self.evaluatedTechnician {
            currentTextField.inputView  = pickerView
        }else if currentTextField == self.managerNameDropdown{
            currentTextField.inputView  = pickerView
        }else if currentTextField == self.whenDropdown{
            currentTextField.inputView  = pickerView
        }
        
    }
    
    @IBAction func addCaseInfo(_ sender: Any) {
        
        guard let name = workOrderNumber.text else { return }
        print(name)
        
        ref?.child("Work Order: \(name)")
        
        print(workOrderNumber.text!)
        ref?.child("Work Order: \(workOrderNumber.text)").setValue(["Manager Name": managerNameDropdown.text, "Technician Name": evaluatedTechnician.text, "When": whenDropdown.text])
        
        presentingViewController?.dismiss(animated: true)
        
    }
    
    

    

}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
