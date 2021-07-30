//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/18/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func login(_ sender: Any) {
        let username = userName.text
        let password = password.text
        
        if username != nil && password != nil {
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
    
    
    @IBAction func signup(_ sender: Any) {
        let signupUrl = "https://auth.udacity.com/sign-up"
        UIApplication.shared.open(URL(string: signupUrl)!)
    }
    
}

