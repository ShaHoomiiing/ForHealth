//
//  DetailExerciseViewController.swift
//  Project2
//
//  Created by SWU Mac on 2020/07/06.
//  Copyright © 2020 SJ. All rights reserved.
//

import UIKit
import CoreData

class DetailExerciseViewController: UIViewController {

    @IBOutlet var exerciseName: UILabel!
    @IBOutlet var exercisePart: UILabel!
    @IBOutlet var exerciseMethod: UITextView!
    @IBOutlet var exerciseImage: UIImageView!
    @IBOutlet var exerciseDate: UILabel!
    
    var inputImage: UIImage?
    
    var detailExercise: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let exercise = detailExercise {
            exerciseName.text = exercise.value(forKey: "exerciseName") as? String
            exercisePart.text = exercise.value(forKey: "exercisePart") as? String
            exerciseMethod.text = exercise.value(forKey: "exerciseMethod") as? String
            
            let dbDate: Date? = exercise.value(forKey: "exerciseDate") as? Date
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd h:mm"
            if let unwrapDate = dbDate {
                exerciseDate.text = formatter.string(from: unwrapDate as Date)
            }
            
            /*let imageData: UIImage? = exercise.value(forKey: "exerciseImage") as? UIImage
            if let image = imageData {
                exerciseImage.image = image
            }*/
            
            let imageData = exercise.value(forKey: "exerciseImage") as? Data
            let loadedImage = UIImage(data: imageData!)
            exerciseImage.image = loadedImage
            
            /*let imageData: UIImage = exercise.value(forKey: "exerciseImage") as! UIImage
            
            let imageData = im
            
            let context = self.getContext()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "Exercise")
            
            var fetchingImage = [Exercise]()
            
            do {
                fetchingImage = try context.fetch(fetchRequest) as! [Exercise]
            } catch {
                
            }
            
            if let imageData = try? Data(fetchRequest) {
                exerciseImage.image = UIImage(data: )
            }
        
            let imageData = inputImage = inputImage else {return}
            image = */
            
            
            //exerciseImage.image = exercise.value(forKey: "exerciseImage") as? UIImage
        }
    }
}
