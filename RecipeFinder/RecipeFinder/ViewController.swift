//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Jimmy Ren on 12/4/20.
//

import UIKit

var MyMealPlan: MealPlan = MealPlan()

class ViewController: UIViewController {

    @IBOutlet weak var Search: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SearchButton(_ sender: Any) {
        print("Your Search: " + Search.text! + "\n")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segueing...")
        if segue.identifier! == "Search" {
            print(segue.destination)
            if let screen = segue.destination as? RecipesViewController {
                screen.currentSearch = Search.text
                print("Sending " + Search.text! + "...\n")
            }
        } else if segue.identifier! == "ShowMealPlan" {
            print("Heading over!")
        }

    }
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        <#code#>
//    }

}

