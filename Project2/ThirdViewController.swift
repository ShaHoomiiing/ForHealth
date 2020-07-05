//
//  SecondViewController.swift
//  Project2
//
//  Created by SWU Mac on 2020/07/04.
//  Copyright © 2020 SJ. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var height: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var userName: UILabel!
    @IBOutlet var BMI: UILabel!
    @IBOutlet var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            userName.text = name + " 님의 BMI"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // delegate method
        if textField == self.height {
            textField.resignFirstResponder()
            self.weight.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }

    @IBAction func Calculate(_ sender: Any) {
        if height.text == "" {
            labelStatus.text = "키를 입력하세요"
            return
        }
        if weight.text == "" {
            labelStatus.text = "몸무게를 입력하세요"
            return
        }
        
        let h = Double(height.text!) ?? 0.0
        let w = Double(weight.text!) ?? 0.0
        let bmi = Double(w / (h*h))
        BMI.text = String(bmi)
    }
}

