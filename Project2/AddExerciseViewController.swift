//
//  AddExerciseViewController.swift
//  Project2
//
//  Created by SWU Mac on 2020/07/05.
//  Copyright © 2020 SJ. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return labelArray[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return labelArray.count
    }

    @IBOutlet var exerciseName: UITextField!
    @IBOutlet var exercisePart: UIPickerView!
    @IBOutlet var exerciseMethod: UITextView!
    
    let labelArray: Array<String> = ["가슴", "복부", "등", "허리", "어깨", "팔", "허벅지", "종아리"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveExercise(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
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
