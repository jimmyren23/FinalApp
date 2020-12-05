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
    
    
    var headers = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...6 {
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
//        if let pic = cell.viewWithTag(1) as? UIImageView {
//           var image: URL;
//            if (recipes[indexPath.row].recipe.image != "") {
//                image = URL(string: recipes[indexPath.row].recipe.image)!;
//                pic.kf.setImage(with: image);
//           }
//        }
        if let label = cell.viewWithTag(2) as? UILabel{
            label.text = meals[indexPath.section][indexPath.row].label
        }


//        if let designation = cell.viewWithTag(3) as? UILabel{
//            designation.text = recipes[indexPath.row].recipe.source
//        }

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

}

