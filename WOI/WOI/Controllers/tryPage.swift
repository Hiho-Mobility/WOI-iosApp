//
//  tryPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-06.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown


class tryPage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var thirdImage: UIImageView!

    
    @IBOutlet var firstPara: UILabel!
    
    @IBOutlet var secondPara: UILabel!
    
    @IBOutlet var thirdPara: UILabel!
    
    @IBOutlet var dropDown: DropDown!
    @IBOutlet var additionalCommentsBox: UITextView!
    
    var firstButtonClick = false
    var secondButtonClick = false
    var thirdButtonClick = false
    
    var imageSelected = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dropDown.optionArray = ["YES", "NO" ,"N/A"]
             dropDown.optionIds = [1,2,3]
             
        additionalCommentsBox.delegate = self
        additionalCommentsBox.text = "Additional Comments"
        additionalCommentsBox.textColor = UIColor.lightGray
        
        
        self.hideKeyboardWhenTappedAround()
     
             
           
            dropDown.didSelect{
                (selectedText , index ,id) in
             if selectedText == "NO"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let firstViewController = storyBoard.instantiateViewController(withIdentifier: "firstPage")
//                self.dismiss(animated: false, completion: nil)
//                self.view.addSubview(firstViewController.view)
                self.navigationController?.pushViewController(firstViewController, animated: false)
//                self.present(firstViewController, animated:false, completion:nil)
                //present(firstPage, animated: false)
             }else{
                 
             }
             
             }

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

    @IBAction func firstButtonPressed(_ sender: Any) {
        
           if firstButtonClick == true{
                firstButton.setImage(UIImage(named: "checkBoxOUTLINE "), for: .normal)
                firstButtonClick = !firstButtonClick
            }else{
                firstButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
                firstButtonClick = !firstButtonClick
            }
        
        
    }
    
    
    @IBAction func secondButtonPressed(_ sender: Any) {
        if secondButtonClick == true{
            secondButton.setImage(UIImage(named: "checkBoxOUTLINE "), for: .normal)
            secondButtonClick = !secondButtonClick
        }else{
            secondButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
            secondButtonClick = !secondButtonClick
        }
    }
    
    
    @IBAction func thirdButtonPressed(_ sender: Any) {
        
        if thirdButtonClick == true{
           thirdButton.setImage(UIImage(named: "checkBoxOUTLINE "), for: .normal)
           thirdButtonClick = !thirdButtonClick
       }else{
           thirdButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
           thirdButtonClick = !thirdButtonClick
       }
    }
    
    
    @IBAction func imagePick(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let ac = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }else{
                let noCam = UIAlertController(title: "No Camera Available", message: "The camera is not currently functioning on this device", preferredStyle: .alert)
                noCam.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(noCam, animated: true)
            }
           

        }))
        ac.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
            
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        self.present(ac, animated: true)
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        
        if imageSelected[0] == true && imageSelected[1] == true && imageSelected[2] == true {
            firstImage.image = image
        }
        else if imageSelected[0] == false{
            firstImage.image = image
            imageSelected[0] = true
        }
        else if imageSelected[1] == false{
            secondImage.image = image
            imageSelected[1] = true
        }
        else if imageSelected[2] == false{
            thirdImage.image = image
            imageSelected[2] = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        let fontSize1 = self.firstPara.getFontSizeForLabel()
//        let fontSize2 = self.secondPara.getFontSizeForLabel()
//        let fontSize3 = self.thirdPara.getFontSizeForLabel()
//
//        print(fontSize1)
//        print(fontSize2)
//        print(fontSize3)
//        let smallestFontSize = min(min(fontSize1, fontSize2), fontSize3)
//
//        self.firstPara.font = self.firstPara.font.withSize(smallestFontSize)
//        self.secondPara.font = self.secondPara.font.withSize(smallestFontSize)
//        self.thirdPara.font = self.thirdPara.font.withSize(smallestFontSize)
//
//        self.firstPara.adjustsFontSizeToFitWidth = false
//        self.secondPara.adjustsFontSizeToFitWidth = false
//        self.thirdPara.adjustsFontSizeToFitWidth = false
//    }


    
}
