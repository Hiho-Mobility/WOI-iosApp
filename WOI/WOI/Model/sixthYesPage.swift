//
//  sixthYesPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-09.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseDatabase


class sixthYesPage: UIViewController {

    
    @IBOutlet var firstParagraph: UILabel!
    @IBOutlet var secondParagraph: UILabel!
    @IBOutlet var thirdParagraph: UILabel!
    @IBOutlet var fourthParagraph: UILabel!
    
    @IBOutlet var dropDown: DropDown!
    @IBOutlet var yesBorderBox: UIView!
    @IBOutlet var nextButton: UIButton!
    
    var ref: DatabaseReference?

    
    var firstButtonClick = false
    var paragraphStrings = [String]()
    
    
    var huss : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))
        
        yesBorderBox.layer.borderWidth = 2
        yesBorderBox.layer.borderColor = UIColor.gray.cgColor
        yesBorderBox.layer.cornerRadius = 5
       
        self.nextButton.isEnabled = true
        
        
        
        
        
        
        
        
      //dropdown settings
        dropDown.optionArray = ["YES", "NO" ,"N/A"]
        dropDown.optionIds = [1,2,3]
        dropDown.didSelect{
           (selectedText , index ,id) in
        if selectedText == "YES"{
            self.nextButton.isEnabled = true
            
        }
        else if selectedText == "NO"{
            self.nextButton.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let sixthNoPageController = storyBoard.instantiateViewController(withIdentifier: "sixthNoPage")
            self.navigationController?.pushViewController(sixthNoPageController, animated: false)
           
        }
        else{
            self.nextButton.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let sixthNAPageController = storyBoard.instantiateViewController(withIdentifier: "sixthNAPage")

            self.navigationController?.pushViewController(sixthNAPageController, animated: false)
        }
        
        }



    }
    
    @objc func homeButtonTapped(){
          self.navigationController?.popToRootViewController(animated: true)
          
      }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        let finishedSurveyAC = UIAlertController(title: "Success!", message: "Form was submitted successfully!", preferredStyle: .alert)
        finishedSurveyAC.addAction(UIAlertAction(title: "OK", style: .default, handler: restartApp) )
        self.present(finishedSurveyAC, animated: true)
        
    }
    
    func restartApp(action: UIAlertAction!){
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fontSize1 = self.firstParagraph.getFontSizeForLabel()
        let fontSize2 = self.secondParagraph.getFontSizeForLabel()
        let fontSize3 = self.thirdParagraph.getFontSizeForLabel()
        let fontSize4 = self.fourthParagraph.getFontSizeForLabel()

        let smallestFontSize = min(min(min(fontSize1, fontSize2), fontSize3), fontSize4)

        self.firstParagraph.font = self.firstParagraph.font.withSize(smallestFontSize)
        self.secondParagraph.font = self.secondParagraph.font.withSize(smallestFontSize)
        self.thirdParagraph.font = self.thirdParagraph.font.withSize(smallestFontSize)
        self.fourthParagraph.font = self.fourthParagraph.font.withSize(smallestFontSize)

        self.firstParagraph.adjustsFontSizeToFitWidth = false
        self.secondParagraph.adjustsFontSizeToFitWidth = false
        self.thirdParagraph.adjustsFontSizeToFitWidth = false
        self.fourthParagraph.adjustsFontSizeToFitWidth = false
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
                 
         ref?.child("Work Order: \(String(describing: futureReference))").child("sixthPage").setValue(["Job site was presented to be a safe work zone?":"YES"])
         print("")
     }
    
        


}

