//
//  SecondViewController.swift
//  Project2
//
//  Created by SWU Mac on 2020/07/04.
//  Copyright © 2020 SJ. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var curWater: UILabel!
    @IBOutlet var finWater: UILabel!
    @IBOutlet var waterAmount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func Drink(_ sender: Any) {
        let current = Int(curWater.text!) ?? 0
        let addAmount = Int(waterAmount.text!) ?? 0
        curWater.text = String(current + addAmount)
    }
    
    @IBAction func Reset(_ sender: Any) {
        curWater.text = "0"
    }
    
}

