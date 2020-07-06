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
    @IBOutlet var Show: UILabel!
    
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
        BMI.text = String(format: "%.1f", bmi)
        
        if(40 <= bmi) {
            Show.text = "고도비만 입니다!"
        } else if(35 <= bmi && bmi < 40) {
            Show.text = "중등도비만 입니다!"
        } else if(30 <= bmi && bmi < 35) {
            Show.text = "경도비만 입니다!"
        } else if(25 <= bmi && bmi < 30) {
            Show.text = "과체중 입니다!"
        } else if(18.5 <= bmi && bmi < 25) {
            Show.text = "정상체중 입니다^^"
        } else if(bmi < 18.5) {
            Show.text = "저체중 입니다!"
        }
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

