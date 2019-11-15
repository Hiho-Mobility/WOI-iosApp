//
//  fourthNAPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-09.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseDatabase
import FirebaseStorage

class fourthNAPage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var naBorderBox: UIView!
    
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var dropDown: DropDown!
    @IBOutlet var additionalCommentsBox: UITextView!
    
    var ref: DatabaseReference?
    var inputVals = [String: Any]()
    
    
    
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var thirdImage: UIImageView!

    var imageSelected = [false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))

        
        ref = Database.database().reference()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        additionalCommentsBox.delegate = self
        additionalCommentsBox.text = "Additional Comments"
        additionalCommentsBox.textColor = UIColor.lightGray
        
        naBorderBox.layer.borderWidth = 2
        naBorderBox.layer.borderColor = UIColor.gray.cgColor
        naBorderBox.layer.cornerRadius = 5
        
      
        self.nextButton.isEnabled = true
         
        self.hideKeyboardWhenTappedAround()
        
        
        
        dropDown.optionArray = ["N/A", "5", "4", "3", "2", "1"]
        dropDown.optionIds = [1,2,3,4,5,6]
        
        dropDown.text = dropDownValueFourth
        
        dropDown.didSelect{
           (selectedText , index ,id) in
            
            dropDownValueFourth = selectedText
            
        if selectedText == "N/A"{
            print("")
            
        }
        else {
          //  self.nextButton.isEnabled = false
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let fourthNoPageController = storyBoard.instantiateViewController(withIdentifier: "fourthNoPage")
            self.navigationController?.pushViewController(fourthNoPageController, animated: false)

           
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
    
    @objc func keyboardWillShow(sender: NSNotification) {
               self.view.frame.origin.y = -150 // Move view 150 points upward
          }

       @objc func keyboardWillHide(sender: NSNotification) {
               self.view.frame.origin.y = 0 // Move view to original position
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
    
    @IBAction func nextButtonClick(_ sender: Any) {
     
     
    
        self.inputVals["Work order process was followed?"] = "N/A"
        self.inputVals["Additional Comments"] = additionalCommentsBox.text
        
        if additionalCommentsBox.text == "Additional Comments"{
            self.inputVals["Additional Comments"] = ""
        }
        
        ref?.child("Work Order: \(String(describing: futureReference))").child("fourthPage").setValue(self.inputVals)
        
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
                        self.ref?.child("Work Order: \(String(describing: futureReference))").child("fourthPage").child("pic1").setValue(metaImageUrl)
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
                      self.ref?.child("Work Order: \(String(describing: futureReference))").child("fourthPage").child("pic2").setValue(metaImageUrl)
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
                      self.ref?.child("Work Order: \(String(describing: futureReference))").child("fourthPage").child("pic3").setValue(metaImageUrl)
                  }
    
              })
          }
        }
        if (alternatePage){
            
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let firstPageAlternateController = storyBoard.instantiateViewController(withIdentifier: "finalPage")
                self.navigationController?.pushViewController(firstPageAlternateController, animated: true)
        }else{

            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let firstNoPageController = storyBoard.instantiateViewController(withIdentifier: "fifthNoPage")
            self.navigationController?.pushViewController(firstNoPageController, animated: true)
        }
        
        print("")
    }
    

}

