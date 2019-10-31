//
//  finalPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-30.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseDatabase
import FirebaseStorage


class finalPage:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var naBorderBox: UIView!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var additionalCommentsBox: UITextView!
    
    var inputVals = [String: Any]()


    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))

        
        ref = Database.database().reference()
             
        dropDownValueSixth = ""
        dropDownValueFourth = ""
        
        additionalCommentsBox.delegate = self
        additionalCommentsBox.text = "Additional Comments"
        additionalCommentsBox.textColor = UIColor.lightGray
        
        naBorderBox.layer.borderWidth = 2
        naBorderBox.layer.borderColor = UIColor.gray.cgColor
        naBorderBox.layer.cornerRadius = 5
        
      
        self.nextButton.isEnabled = true
         
        
        self.hideKeyboardWhenTappedAround()
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func homeButtonTapped(){
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            textView.text = "Additional Comments"
            textView.textColor = UIColor.lightGray
        }
    }

    
    @IBAction func nextButtonClick(_ sender: Any) {
             
        
              if additionalCommentsBox.text == "Additional Comments"{
                  self.inputVals["Are there any training opportunities you want to mention for this person’s performance reviews?"] = ""
              }else{
                self.inputVals["Are there any training opportunities you want to mention for this person’s performance reviews?"] = additionalCommentsBox.text
            }
        
        
             
              
              ref?.child("Work Order: \(String(describing: futureReference))").child("finalPage").setValue(self.inputVals)
              
              alternatePage = false
              print("")
          }
    





    
    @IBAction func nextButtonClicked(_ sender: Any) {
        let finishedSurveyAC = UIAlertController(title: "Success!", message: "Form was submitted successfully!", preferredStyle: .alert)
        finishedSurveyAC.addAction(UIAlertAction(title: "OK", style: .default, handler: restartApp) )
        self.present(finishedSurveyAC, animated: true)
        
    }
    
    func restartApp(action: UIAlertAction!){
        navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
