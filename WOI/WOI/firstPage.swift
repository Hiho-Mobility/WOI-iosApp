//
//  firstPage.swift
//  WOI
//
//  Created by Hussein Nagri on 2019-10-02.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class firstPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(homeButtonTapped))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func homeButtonTapped(){
          self.navigationController?.popToRootViewController(animated: true)
          
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
