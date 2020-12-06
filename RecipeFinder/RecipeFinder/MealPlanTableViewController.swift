//
//  ViewController.swift
//  NationalParks
//
//  Created by Jimmy Ren on 11/14/20.
//
import UIKit
import Kingfisher

class MealPlanTableViewController: UITableViewController {
    var meals = Array<Array<Meal>>()
    
    @IBAction func ClearWeek(_ sender: Any) {
        MyMealPlan.resetWeek()
        meals = Array<Array<Meal>>()
        self.tableView.reloadData()
    }
    
    var headers = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...6 {
            MyMealPlan.week[i].Meals.sort(by: { $0.mealtime.rawValue > $1.mealtime.rawValue })
            meals.append(MyMealPlan.week[i].Meals)
        }
        print("View Loaded")
        self.tableView.dataSource = self
    }

    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    // Set properties of the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Meal", for: indexPath)
        if let pic = cell.viewWithTag(1) as? UIImageView {
           var image: URL;
            if (meals[indexPath.section][indexPath.row].image != "") {
                image = URL(string: meals[indexPath.section][indexPath.row].image)!;
                pic.kf.setImage(with: image);
           }
        }
        if let label = cell.viewWithTag(2) as? UILabel{
            label.text = meals[indexPath.section][indexPath.row].label
        }


        if let designation = cell.viewWithTag(3) as? UILabel{
            designation.text = meals[indexPath.section][indexPath.row].source
        }
        
        if let designation = cell.viewWithTag(4) as? UILabel{
            if(meals[indexPath.section][indexPath.row].mealtime.rawValue == 0) {
                designation.text = "Breakfast"
            } else if (meals[indexPath.section][indexPath.row].mealtime.rawValue == 1) {
                designation.text = "Lunch"
            } else if (meals[indexPath.section][indexPath.row].mealtime.rawValue == 2) {
                designation.text = "Dinner"
            }
        }


        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].count
    }
    
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headers.count {
            return headers[section]
        }
        return nil
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        // TODO: If the editing style is deletion, remove the newsItem from your model and then delete the rows. CAUTION: make sure you aren't calling tableView.reloadData when you update your model -- calling both tableView.deleteRows and tableView.reloadData will make the app crash.
//        if editingStyle == .delete {
//            MyMealPlan.week[indexPath.row].Meals.remove(at: indexPath.section)
//            meals[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            //Remove from model
//        }
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowCharts") {
            print("Sending to Charts")
        }
    }
}

