//
//  ViewController.swift
//  FinalApp
//
//  Created by Jimmy Ren on 11/20/20.
//

import UIKit

var SignInVC = SignInViewController()
class SignInViewController: UIViewController{
    var signedIn = false;
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var PlayBut: UIButton!
    @IBOutlet weak var SignInButton: UIButton!
    
    @IBAction func PlayButton(_ sender: Any) {

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserName.text = "Waiting for Username..."
        //PlayBut.isHidden = true;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignIn(_ sender: Any) {
        signedIn = true

    }

}

