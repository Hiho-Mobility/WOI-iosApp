//
//  thirdNoPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-08.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseDatabase
import FirebaseStorage

public var dropDownValueThird : String? = ""

class thirdNoPage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    @IBOutlet var fourtButton: UIButton!
    @IBOutlet var fifthButton: UIButton!
    
    
    
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var thirdImage: UIImageView!

    
    @IBOutlet var firstPara: UILabel!
    @IBOutlet var secondPara: UILabel!
    @IBOutlet var thirdPara: UILabel!
    @IBOutlet var forthPara: UILabel!
    @IBOutlet var cautionPara: UILabel!
    @IBOutlet var fifthPara: UILabel!
    
    
    var ref: DatabaseReference?
    var inputVals = [String: Any]()
    
    
    
    @IBOutlet var dropDown: DropDown!
    @IBOutlet var additionalCommentsBox: UITextView!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var noBorderBox: UIView!
    
    var firstButtonClick = false
    var secondButtonClick = false
    var thirdButtonClick = false
    var fourthButtonClick = false
    var fifthButtonClick = false
    
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
        
        cautionPara.layer.borderColor = UIColor.gray.cgColor
        cautionPara.layer.borderWidth = 1
        cautionPara.layer.cornerRadius = 5
        
        
        self.setNext(val: dropDownValueThird)
        
        dropDown.optionArray = ["1", "2", "3", "4", "5", "N/A"]
        dropDown.optionIds = [1,2,3,4,5,6]
        
        dropDown.text = dropDownValueThird
        
        dropDown.didSelect{
           (selectedText , index ,id) in
            
            dropDownValueThird = selectedText
            
        if selectedText == "N/A"{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let thirdNAPageController = storyBoard.instantiateViewController(withIdentifier: "thirdNAPage")
            self.navigationController?.pushViewController(thirdNAPageController, animated: false)
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
    
    
    @IBAction func thirdButtonPressed(_ sender: Any) {
        
        if thirdButtonClick == true{
            thirdButton.setImage(UIImage(named: "checkBoxOUTLINE "), for: .normal)
           thirdButtonClick = !thirdButtonClick
            
       }else{
           thirdButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
           thirdButtonClick = !thirdButtonClick
           
       }
    }
    
    @IBAction func fourtButtonPressed(_ sender: Any) {
        if fourthButtonClick == true{
           fourtButton.setImage(UIImage(named: "checkBoxOUTLINE "), for: .normal)
           fourthButtonClick = !fourthButtonClick
          
       }else{
           fourtButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
           fourthButtonClick = !fourthButtonClick
          
       }
    }
    
    @IBAction func fifthButtonPressed(_ sender: Any) {
        
        if fifthButtonClick == true{
           fifthButton.setImage(UIImage(named: "checkBoxOUTLINE "), for: .normal)
           fifthButtonClick = !fifthButtonClick
           
       }else{
           fifthButton.setImage(UIImage(named: "checkBoxFILLED"), for: .normal)
           fifthButtonClick = !fifthButtonClick
           
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
        let fontSize3 = self.thirdPara.getFontSizeForLabel()
        let fontSize4 = self.forthPara.getFontSizeForLabel()
        let fontSize5 = self.cautionPara.getFontSizeForLabel()
        let fontSize6 = self.fifthPara.getFontSizeForLabel()
        
        
        print(fontSize1)
        print(fontSize2)
        print(fontSize3)
        let smallestFontSize = min(min(min(min(min(fontSize1, fontSize2), fontSize3), fontSize4), fontSize5), fontSize6)

        self.firstPara.font = self.firstPara.font.withSize(smallestFontSize)
        self.secondPara.font = self.secondPara.font.withSize(smallestFontSize)
        self.thirdPara.font = self.thirdPara.font.withSize(smallestFontSize)
        self.forthPara.font = self.forthPara.font.withSize(smallestFontSize)
        self.cautionPara.font = self.cautionPara.font.withSize(smallestFontSize)
        self.fifthPara.font = self.fifthPara.font.withSize(smallestFontSize)
        
        
        
        self.firstPara.adjustsFontSizeToFitWidth = false
        self.secondPara.adjustsFontSizeToFitWidth = false
        self.thirdPara.adjustsFontSizeToFitWidth = false
        self.forthPara.adjustsFontSizeToFitWidth = false
        self.cautionPara.adjustsFontSizeToFitWidth = false
        self.fifthPara.adjustsFontSizeToFitWidth = false
        
        

    }

    @IBAction func nextButtonClick(_ sender: Any) {
        
        
        
        self.inputVals["The work performed was of Stanford,Facilities Operations and Trade Specific quality?"] = dropDownValueThird
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
        if thirdButtonClick{
            self.inputVals["Reason3"] = thirdPara.text
        }
        if fourthButtonClick{
            self.inputVals["Reason4"] = forthPara.text
        }
        if fifthButtonClick{
            self.inputVals["Reason5"] = fifthPara.text
        }
        
        
        ref?.child("Work Order: \(String(describing: futureReference))").child("thirdPage").setValue(self.inputVals)
        
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
                        self.ref?.child("Work Order: \(String(describing: futureReference))").child("thirdPage").child("pic1").setValue(metaImageUrl)
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
                      self.ref?.child("Work Order: \(String(describing: futureReference))").child("thirdPage").child("pic2").setValue(metaImageUrl)
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
                      self.ref?.child("Work Order: \(String(describing: futureReference))").child("thirdPage").child("pic3").setValue(metaImageUrl)
                  }
    
              })
          }
        }
        
        
        print("")
    }

    
}
