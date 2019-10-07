//
//  firstPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-02.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown

class firstPage: UIViewController {
    
    
    
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
        
        
      
        dropDown.optionArray = ["YES", "NO" ,"N/A"]
        dropDown.optionIds = [1,2,3]
        

        
        huss = "HAHHAAHA"
       dropDown.didSelect{
           (selectedText , index ,id) in
        if selectedText == "YES"{
            self.nextButton.isEnabled = true
        }else{
            self.nextButton.isEnabled = false
        }
        
        }
        
        print("HI \(huss)")
        // Do any additional setup after loading the view.
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
    
    
    
    
    
 //--------------This is to make the checkbox unclick and reclick ------------
//    @IBAction func firstItem(_ sender: Any) {
//
//        if firstButtonClick == true{
//            firstButton.setImage(UIImage(named: "checkBoxOUTLINE"), for: .normal)
//            firstButtonClick = !firstButtonClick
//        }else{
//            firstButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
//            firstButtonClick = !firstButtonClick
//        }
//
//    }
    


}

extension UILabel {
    func getFontSizeForLabel() -> CGFloat {
        let text: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText!)
        text.setAttributes([NSAttributedString.Key.font: self.font!], range: NSMakeRange(0, text.length))
        let context: NSStringDrawingContext = NSStringDrawingContext()
        context.minimumScaleFactor = self.minimumScaleFactor
        text.boundingRect(with: self.frame.size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: context)
        let adjustedFontSize: CGFloat = self.font.pointSize * context.actualScaleFactor
        return adjustedFontSize
    }
}
