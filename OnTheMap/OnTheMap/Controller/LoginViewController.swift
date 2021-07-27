//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/18/21.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        UdacityClient.login(username: "sophialu.belkin@gmail.com", password: "Luxin79lx!") { success, error in
            if success {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showDashboard", sender: nil)
                }
             
            } else {
                print(error ?? "")
            }
        }
       
    }
    
}

