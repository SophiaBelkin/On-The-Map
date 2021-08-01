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
    @IBOutlet weak var signupText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextView()
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
    
    func  updateTextView() {
        let signupUrl = "https://auth.udacity.com/sign-up"
        guard let text = signupText.text else { return }
        let attributedString = NSAttributedString.makeHyperlink(for: signupUrl, in: text, as: "Sign up")
        let font = signupText.font
        let textAlignment = signupText.textAlignment
        signupText.attributedText = attributedString
        signupText.font = font
        signupText.textAlignment = textAlignment
    }
    
}

