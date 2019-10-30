//
//  fifthNoPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-09.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseDatabase
import FirebaseStorage

public var dropDownValueFifth : String? = ""


class fifthNoPage:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var thirdImage: UIImageView!

    
    @IBOutlet var firstPara: UILabel!
    @IBOutlet var secondPara: UILabel!
    
    @IBOutlet var dropDown: DropDown!
    @IBOutlet var additionalCommentsBox: UITextView!
    
    
    var ref: DatabaseReference?
    var inputVals = [String: Any]()
    
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var noBorderBox: UIView!
    
    var firstButtonClick = false
    var secondButtonClick = false
    
    var imageSelected = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))

        ref = Database.database().reference()
    
        additionalCommentsBox.delegate = self
        additionalCommentsBox.text = "Additional Comments"
        additionalCommentsBox.textColor = UIColor.lightGray
        
        noBorderBox.layer.borderWidth = 2
        noBorderBox.layer.borderColor = UIColor.gray.cgColor
        noBorderBox.layer.cornerRadius = 5
        
      
        self.setNext(val: dropDownValueFifth)
        
        dropDown.optionArray = ["1", "2", "3", "4", "5", "N/A"]
        dropDown.optionIds = [1,2,3,4,5,6]
        
        dropDown.text = dropDownValueFifth
        
        dropDown.didSelect{
           (selectedText , index ,id) in
            
            dropDownValueFifth = selectedText
            
        if selectedText == "N/A"{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let fifthNAPageController = storyBoard.instantiateViewController(withIdentifier: "fifthNAPage")
            self.navigationController?.pushViewController(fifthNAPageController, animated: false)
        }
        else {
           self.nextButton.isEnabled = true
        }
         
        
        }
        
        
        
        
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        
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
    func setNext(val:String?) -> Void {
        if (val == "1" || val == "2" || val == "3" || val == "4" || val == "5" ){
            self.nextButton.isEnabled = true
        }
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fontSize1 = self.firstPara.getFontSizeForLabel()
        let fontSize2 = self.secondPara.getFontSizeForLabel()

        print(fontSize1)
        print(fontSize2)
        let smallestFontSize = min(fontSize1, fontSize2)

        self.firstPara.font = self.firstPara.font.withSize(smallestFontSize)
        self.secondPara.font = self.secondPara.font.withSize(smallestFontSize)

        self.firstPara.adjustsFontSizeToFitWidth = false
        self.secondPara.adjustsFontSizeToFitWidth = false
        
        
        
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
           
           
           
           self.inputVals["Appropriate PPE was used for the work order?"] = dropDownValueFifth
           self.inputVals["Additional Comments"] = additionalCommentsBox.text
           
           if additionalCommentsBox.text == "Additional Comments"{
               self.inputVals["Additional Comments"] = ""
           }

           if firstButtonClick{
               self.inputVals["Reason1"] = firstPara.text
           }
           if secondButtonClick {
               self.inputVals["Reason2"] = secondPara.text

           }
           
           
           ref?.child("Work Order: \(String(describing: futureReference))").child("fifthPage").setValue(self.inputVals)
           
           if imageSelected[0] {
               
               guard let imageData = firstImage.image?.jpegData(compressionQuality: 0.8) else{
                   return
               }
               
               let storageRef = Storage.storage().reference(forURL: "gs://woi-254713.appspot.com")
               let imageName = UUID().uuidString
               print(imageName)
               let storageIosPicRef = storageRef.child("iosAppPics").child(imageName)
               
               let metadata = StorageMetadata()
               metadata.contentType = "image/jpg"
               
               
               storageIosPicRef.putData(imageData, metadata: metadata) {
                   (storageMetaData, err) in
           
                   if err != nil{
                       print(err?.localizedDescription)
                       return
                   }
                   storageIosPicRef.downloadURL (completion: { (url, err) in
                       if let metaImageUrl = url?.absoluteString {
                           self.ref?.child("Work Order: \(String(describing: futureReference))").child("fifthPage").child("pic1").setValue(metaImageUrl)
                       }
         
                   })
               }
               
               
               
               
           }

           if imageSelected[1] {
             guard let imageData = secondImage.image?.jpegData(compressionQuality: 0.8) else{
                 return
             }
             
               let storageRef = Storage.storage().reference(forURL: "gs://woi-254713.appspot.com")
               let imageName = UUID().uuidString
               print(imageName)
               let storageIosPicRef = storageRef.child("iosAppPics").child(imageName)
             
               let metadata = StorageMetadata()
               metadata.contentType = "image/jpg"
               storageIosPicRef.putData(imageData, metadata: metadata) {
                 (storageMetaData, err) in
         
                 if err != nil{
                     print(err?.localizedDescription)
                     return
                 }
                 storageIosPicRef.downloadURL (completion: { (url, err) in
                     if let metaImageUrl = url?.absoluteString {
                         self.ref?.child("Work Order: \(String(describing: futureReference))").child("fifthPage").child("pic2").setValue(metaImageUrl)
                     }
       
                 })
             }
           }

           if imageSelected[2] {
             guard let imageData = thirdImage.image?.jpegData(compressionQuality: 0.8) else{
                 return
             }
             
             let storageRef = Storage.storage().reference(forURL: "gs://woi-254713.appspot.com")
             let imageName = UUID().uuidString
             print(imageName)
             let storageIosPicRef = storageRef.child("iosAppPics").child(imageName)
             
             let metadata = StorageMetadata()
             metadata.contentType = "image/jpg"
            
             storageIosPicRef.putData(imageData, metadata: metadata) {
                 (storageMetaData, err) in
         
                 if err != nil{
                     print(err?.localizedDescription)
                     return
                 }
                 storageIosPicRef.downloadURL (completion: { (url, err) in
                     if let metaImageUrl = url?.absoluteString {
                         self.ref?.child("Work Order: \(String(describing: futureReference))").child("fifthPage").child("pic3").setValue(metaImageUrl)
                     }
       
                 })
             }
           }
           
           
           print("")
       }


    
}
