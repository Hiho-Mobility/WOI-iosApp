//
//  firstBasePage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-08.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown

class firstBasePage: UIViewController {
    
    
    @IBOutlet var firstParagraph: UILabel!
    @IBOutlet var secondParagraph: UILabel!
    @IBOutlet var thirdParagraph: UILabel!

    @IBOutlet var dropDown: DropDown!
    @IBOutlet var yesBorderBox: UIView!
    @IBOutlet var nextButton: UIButton!
    
    
    var firstButtonClick = false
    var paragraphStrings = [String]()
    
    
    var huss : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))
        
        yesBorderBox.layer.borderWidth = 2
        yesBorderBox.layer.borderColor = UIColor.gray.cgColor
        yesBorderBox.layer.cornerRadius = 5
       
        
        
        
        
        
        
        
        
        
      //dropdown settings
        dropDown.optionArray = ["YES", "NO" ,"N/A"]
        dropDown.optionIds = [1,2,3]
        dropDown.didSelect{
           (selectedText , index ,id) in
        if selectedText == "YES"{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let firstYesPageController = storyBoard.instantiateViewController(withIdentifier: "firstYesPage")
            self.navigationController?.pushViewController(firstYesPageController, animated: false)
            
            
        }
        else if selectedText == "NO"{
            self.nextButton.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let firstNoPageController = storyBoard.instantiateViewController(withIdentifier: "firstNoPage")
            self.navigationController?.pushViewController(firstNoPageController, animated: false)
           
        }
        else{
            self.nextButton.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let firstNAPageController = storyBoard.instantiateViewController(withIdentifier: "firstNAPage")

            self.navigationController?.pushViewController(firstNAPageController, animated: false)
        }
        
        }



    }
    
    @objc func homeButtonTapped(){
          self.navigationController?.popToRootViewController(animated: true)
          
      }
    
    override func viewWillAppear(_ animated: Bool) {
        let fontSize1 = self.firstParagraph.getFontSizeForLabel()
        let fontSize2 = self.secondParagraph.getFontSizeForLabel()
        let fontSize3 = self.thirdParagraph.getFontSizeForLabel()

        let smallestFontSize = min(min(fontSize1, fontSize2), fontSize3)

        self.firstParagraph.font = self.firstParagraph.font.withSize(smallestFontSize)
        self.secondParagraph.font = self.secondParagraph.font.withSize(smallestFontSize)
        self.thirdParagraph.font = self.thirdParagraph.font.withSize(smallestFontSize)

        self.firstParagraph.adjustsFontSizeToFitWidth = false
        self.secondParagraph.adjustsFontSizeToFitWidth = false
        self.thirdParagraph.adjustsFontSizeToFitWidth = false
    }
}
    
