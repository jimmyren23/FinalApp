//
//  ParkInfoViewController.swift
//  NationalParks
//
//  Created by Jimmy Ren on 11/14/20.
//
import Foundation
import UIKit
import Kingfisher

class RecipeInfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var name: String?
    var pic: String?
    var source: String?
    var url: String?
    var calories: Double?
    
    var WeekDays: [[String]] = [[]]
    var currentDay: Int = 0
    var currentMealTime: Int = 0
    
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var RecipeLabel: UILabel!
    @IBOutlet weak var RecipeSource: UILabel!
    @IBOutlet weak var RecipeURL: UILabel!
    @IBOutlet weak var RecipeCalories: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeekDays = [["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], ["Breakfast", "Lunch", "Dinner"]]
        
        self.WeekDay.dataSource = self
        self.WeekDay.delegate = self
        RecipeLabel.text = name;
        let RecImage = URL(string: pic!)
        RecipeImage.kf.setImage(with: RecImage)
        RecipeSource.text = source
        RecipeURL.text = url
        RecipeCalories.text = "Calories: " + String(calories!)
    }
    @IBOutlet weak var WeekDay: UIPickerView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WeekDays[component].count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return WeekDays[component][row]
    }
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(WeekDays[component][row])
        if(component == 1) {
            currentMealTime = row
            print("Set Time")
        } else {
            currentDay = row
            print("Set Day")
        }
    }
    @IBAction func AddToMealPlan(_ sender: Any) {
        let meal: Meal = Meal(label: name!, image: pic!, source: source!, url: url!, calories: calories!, mealtime: MealTime.init(rawValue: currentMealTime) ?? MealTime.Breakfast)
        print(meal)
        MyMealPlan.addMeal(day: currentDay, m: meal)
        print(MyMealPlan)
    }
}
