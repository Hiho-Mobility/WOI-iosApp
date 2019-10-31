//
//  ViewController.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-01.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import FirebaseDatabase


public var futureReference : String?
public var alternatePage : Bool = false

class homePageController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate, UIPickerViewDataSource {
    
    //declare outlets
    @IBOutlet var borderBox: UIView!
    @IBOutlet var workOrderNumber: UITextField!
    @IBOutlet var evaluatedTechnician: UITextField!
    @IBOutlet var managerNameDropdown: UITextField!
    @IBOutlet var whenDropdown: UITextField!
    
    //declare variables
    var inputVals = [String: Any]()
    var ref: DatabaseReference?
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    
    var techList = ["Hussein N", "Kunjan B", "Rumi K", "Jasmine S", "Amy V", "Alan K"]
    var managerList = ["Tim L",  "Jay S", "Bob Smith", "John Guy", "Navendra Mahatra Shivani Panday"]
    var statusList = ["During job", "Completed Job"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //database reference initiated
        ref = Database.database().reference()
        
        
        //setup nav bar and box ui
        navigationItem.title = "Work Order Inspections"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        

        borderBox.layer.borderWidth = 1
        borderBox.layer.borderColor = UIColor.gray.cgColor
        borderBox.layer.cornerRadius = 5
        self.hideKeyboardWhenTappedAround()
        
    }
    
    //setup of image picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //get count of items in the dropdowns
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
   
    //display the names in the pickers
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
    
    //close the picker when done choosing
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
    //when clicking the textflied, what happens
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
    
    //submit data to firebase
    @IBAction func addCaseInfo(_ sender: Any) {
        
        
        
        let continueToNextPage = moveOn()
        
        if (continueToNextPage){
            guard let name = workOrderNumber.text else { return }
                futureReference = workOrderNumber.text
                ref?.child("Work Order: \(name)")
                

                ref?.child("Work Order: \(String(describing: workOrderNumber.text))").setValue(["Manager Name": managerNameDropdown.text, "Technician Name": evaluatedTechnician.text, "When": whenDropdown.text])
                
                let date = Date()

                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.none
                dateFormatter.dateStyle = DateFormatter.Style.medium

                let str = dateFormatter.string(from: date)
                print(str)
            
                ref?.child("Work Order: \(String(describing: futureReference))").child("date").setValue(["CurrentDate":str])

                presentingViewController?.dismiss(animated: true)
                
                //choose a path based on the text in the job completed bar
                if (whenDropdown.text == "Completed Job"){
                    
                    alternatePage = true
                    self.inputVals.removeAll()
                    
                    self.inputVals["Technician had professional presentation?"] = "N/A"
                    self.inputVals["Additional Comments"] = ""
                    
                    ref?.child("Work Order: \(String(describing: futureReference))").child("firstPage").setValue(self.inputVals)
                    self.inputVals.removeAll()
                    
                    self.inputVals["Appropriate PPE was used for the work order?"] = "N/A"
                    self.inputVals["Additional Comments"] = ""
                    
                    ref?.child("Work Order: \(String(describing: futureReference))").child("fifthPage").setValue(self.inputVals)
                    self.inputVals.removeAll()
                    
                    self.inputVals["Job site was presented to be a safe work zone?"] = "N/A"
                    self.inputVals["Additional Comments"] = ""
                    
                    ref?.child("Work Order: \(String(describing: futureReference))").child("sixthPage").setValue(self.inputVals)
                    
                    workOrderNumber.text = ""
                    evaluatedTechnician.text = ""
                    managerNameDropdown.text = ""
                    whenDropdown.text = ""
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let firstPageAlternateController = storyBoard.instantiateViewController(withIdentifier: "secondNoPage")
                    self.navigationController?.pushViewController(firstPageAlternateController, animated: true)
                    
                    
                }else{
                    dropDownValue = "--CHOOSE NOW--"
                    workOrderNumber.text = ""
                    evaluatedTechnician.text = ""
                    managerNameDropdown.text = ""
                    whenDropdown.text = ""
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let firstNoPageController = storyBoard.instantiateViewController(withIdentifier: "firstNoPage")
                    self.navigationController?.pushViewController(firstNoPageController, animated: true)
                }
        }else{
            print ("")
        }
        
        
        
    }
        
    //make sure all of the fields are entered before moving on
    func moveOn() -> Bool {
        
        var pass = true
        
        if let workNum = workOrderNumber.text, workNum.count < 1{
            pass = false
            let ac = UIAlertController(title: "Wait a minute", message: "Don't forget a Work Order Number!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac, animated: true)
                    }
        if let manageName = managerNameDropdown.text, manageName.count < 1{
            pass = false
            let ac = UIAlertController(title: "Wait a minute", message: "Don't forget your name!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac, animated: true)
        }
        if let techName = evaluatedTechnician.text, techName.count < 1{
            pass = false
            let ac = UIAlertController(title: "Wait a minute", message: "Don't forget the technician's name!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac, animated: true)
        }
        if let whenText = whenDropdown.text, whenText.count < 1 {
            pass = false
            let ac = UIAlertController(title: "Wait a minute", message: "Don't forget when!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(ac, animated: true)
        }
        
        
        return pass
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
