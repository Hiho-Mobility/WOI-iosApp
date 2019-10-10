//
//  fifthNAPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-09.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown

class fifthNAPage:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var naBorderBox: UIView!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var dropDown: DropDown!
    @IBOutlet var additionalCommentsBox: UITextView!
    
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var thirdImage: UIImageView!

    var imageSelected = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))

        
        
             
        additionalCommentsBox.delegate = self
        additionalCommentsBox.text = "Additional Comments"
        additionalCommentsBox.textColor = UIColor.lightGray
        
        naBorderBox.layer.borderWidth = 2
        naBorderBox.layer.borderColor = UIColor.gray.cgColor
        naBorderBox.layer.cornerRadius = 5
        
      
        self.nextButton.isEnabled = true
         
        
        
        
        
        
        
        
        dropDown.optionArray = ["YES", "NO" ,"N/A"]
        dropDown.optionIds = [1,2,3]
        dropDown.didSelect{
           (selectedText , index ,id) in
        if selectedText == "YES"{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let fifthYesPageController = storyBoard.instantiateViewController(withIdentifier: "fifthYesPage")
            self.navigationController?.pushViewController(fifthYesPageController, animated: false)
            
        }
        else if selectedText == "NO"{
          //  self.nextButton.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let fifthNoPageController = storyBoard.instantiateViewController(withIdentifier: "fifthNoPage")
            self.navigationController?.pushViewController(fifthNoPageController, animated: false)

           
        }
        else{
            print("")
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
    @objc func homeButtonTapped(){
        self.navigationController?.popToRootViewController(animated: true)
        
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
    

}

