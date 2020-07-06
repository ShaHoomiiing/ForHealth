//
//  LogoutViewController.swift
//  ServerLogin
//
//  Created by SWU Mac on 2020/06/14.
//  Copyright © 2020 SJ. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    
    @IBOutlet var labelHello: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        /* 로그인한 사용자의 이름 표시 */
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            labelHello.text = "Hello ~ " + name
        }
    }
    
    @IBAction func buttonLogout(_ sender: Any) {
        /* UIAlertController 사용 */
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: "", preferredStyle: .alert)
        
        /* logout.php 스크립트 실행 */
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            let urlString: String = "http://condi.swu.ac.kr/student/loginPrefix/login/logout.php"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
