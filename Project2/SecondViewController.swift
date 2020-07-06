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
    @IBOutlet var waterAmount: UITextField!
    
    @IBOutlet var waterTab: UITabBarItem!
    
    var waterCount = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.waterTab.badgeValue = String(format: "%d", waterCount)
    }
    
    @IBAction func Drink(_ sender: Any) {
        let current = Int(curWater.text!) ?? 0
        let addAmount = Int(waterAmount.text!) ?? 0
        curWater.text = String(current + addAmount)
        
        if (waterCount > 0) {
            waterCount -= addAmount
            self.waterTab.badgeValue = String(format: "%d", waterCount)
        } else {
            waterCount = 0
        }
    }
    
    @IBAction func Reset(_ sender: Any) {
        curWater.text = "0"
        waterCount = 2000
        self.waterTab.badgeValue = String(format: "%d", waterCount)
    }
    
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let urlString: String = "http://condi.swu.ac.kr/student/" + appDelegate.loginPrefix! + "/login/logout.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return }
            }
            task.resume()
                    
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginView = storyboard.instantiateViewController(withIdentifier: "loginView")
            loginView.modalPresentationStyle = .fullScreen
            self.present(loginView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}

