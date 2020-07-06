//
//  AddExerciseViewController.swift
//  Project2
//
//  Created by SWU Mac on 2020/07/05.
//  Copyright © 2020 SJ. All rights reserved.
//

import UIKit
import CoreData

class AddExerciseViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return labelArray[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return labelArray.count
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    @IBOutlet var exerciseName: UITextField!
    @IBOutlet var exercisePart: UIPickerView!
    @IBOutlet var exerciseMethod: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buttonCamera: UIButton!
    
    let labelArray: Array<String> = ["가슴", "복부", "등", "허리", "어깨", "팔", "허벅지", "종아리"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if !(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let alert = UIAlertController(title: "Error!!", message: "Device has no Camera!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            buttonCamera.isEnabled = false // 카메라 버튼 사용을 금지시킴
        }
    }
    
    @IBAction func selectPicture(_ sender: UIButton) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.sourceType = .photoLibrary
        self.present(myPicker, animated: true, completion: nil)
    }
    
    // 앨범에서 이미지 선택을 위한 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 카메라를 작동시키기 위한 함수
    @IBAction func takePicture(_ sender: UIButton) {
        let myPicker = UIImagePickerController()
        myPicker.delegate = self;
        myPicker.allowsEditing = true
        myPicker.sourceType = .camera
        self.present(myPicker, animated: true, completion: nil)
    }
    
    @IBAction func saveExercise(_ sender: Any) {
        if (exerciseName.text == "" || exerciseMethod.text == "") {
            let alert = UIAlertController(title: "운동이름과 방법을 입력하세요", message: "Save Failed!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        guard let myImage = imageView.image else {
            let alert = UIAlertController(title: "이미지를 선택하세요", message: "Save Failed!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        // 운동이름, 방법, 날짜를 Core Data에 저장
        object.setValue(exerciseName.text, forKey: "exerciseName")
        object.setValue(exerciseMethod.text, forKey: "exerciseMethod")
        object.setValue(Date(), forKey: "exerciseDate")
        
        // 이미지를 Core Data에 저장
        let imageData = myImage.jpegData(compressionQuality: 1.0)
        object.setValue(imageData, forKey: "exerciseImage")
        
        // 선택된 PickerView 글자를 Core Data에 저장
        let label: String = labelArray[self.exercisePart.selectedRow(inComponent: 0)]
        object.setValue(label, forKey: "exercisePart")
        
        do{
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        //self.dismiss(animated: true, completion: nil)
    self.navigationController?.popViewController(animated: true)
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
