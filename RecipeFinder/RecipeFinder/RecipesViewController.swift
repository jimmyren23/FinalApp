//
//  ViewController.swift
//  NationalParks
//
//  Created by Jimmy Ren on 11/14/20.
//
import UIKit
import Kingfisher

class RecipesViewController: UITableViewController {
    let ApplicationID = "88aacfa0"
    let ApplicationKey = "bc0142c2df700b2bc700369c300ed105"
    var currentSearch: String?
    var recipes = [Hit]()
    var endpoint: String = "https://api.edamam.com/search?q=chicken%20beans&app_id=88aacfa0&app_key=bc0142c2df700b2bc700369c300ed105&from=0&to=3&calories=591-722&health=alcohol-free"


    override func viewDidLoad() {
        print("View Loaded")
        currentSearch = currentSearch?.replacingOccurrences(of: " ", with: "%20")
        endpoint = "https://api.edamam.com/search?q=" + currentSearch! + "&app_id=88aacfa0&app_key=bc0142c2df700b2bc700369c300ed105&from=0&to=100"
        super.viewDidLoad()
        makeAPIRequest()
        refreshControl = UIRefreshControl();
        refreshControl?.addTarget(self, action:
        #selector(handleRefreshControl),
        for: .valueChanged)
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
    }

    private func makeAPIRequest() {
        // URLSession code
        print(endpoint)
        if let url = try? URL(string: endpoint) {

        let urlRequest = URLRequest(url: url)
            print("Making API Request...")
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error: API request failed...")
                    return
                }
                if let APIResponse = try?
                    JSONDecoder().decode(APIResponse.self, from: data) {
                    print("Now printing API.... \n")
                    print(APIResponse)
                    DispatchQueue.main.async {
                        self.recipes = APIResponse.hits
                        self.tableView.reloadData()
                    }
                }
            }
            // Actually run the URLSession
            task.resume()
        }
    }






    @objc func handleRefreshControl() {
        makeAPIRequest();
        // Dismiss the refresh control.
        DispatchQueue.main.async {
          self.refreshControl?.endRefreshing()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Recipe", for: indexPath)
        if let pic = cell.viewWithTag(1) as? UIImageView {
           var image: URL;
            if (recipes[indexPath.row].recipe.image != "") {
                image = URL(string: recipes[indexPath.row].recipe.image)!;
                pic.kf.setImage(with: image);
           }
        }
        if let label = cell.viewWithTag(2) as? UILabel{
            label.text = recipes[indexPath.row].recipe.label
        }


        if let designation = cell.viewWithTag(3) as? UILabel{
            designation.text = recipes[indexPath.row].recipe.source
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

    // Handle segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "RecipeDetails", sender: recipes[indexPath.row]);
        print("Performing Segue...\n")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "RecipeDetails" {
            if let screen = segue.destination as? RecipeInfoViewController {
                let recipeInfo = sender as! Hit
                screen.name = recipeInfo.recipe.label
                screen.pic = recipeInfo.recipe.image
                screen.source = recipeInfo.recipe.source
                screen.url = recipeInfo.recipe.url
                screen.calories = recipeInfo.recipe.calories
            }
        }
    }


}

