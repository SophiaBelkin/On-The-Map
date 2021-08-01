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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        updateTextView()
    }
    
    @IBAction func login(_ sender: Any) {
        setLoggingIn(true)
        let username = userName.text
        let password = password.text
        
        if username != nil && password != nil {
            UdacityClient.login(username: username!, password: password!, completion: handleLoginResponse(success:error:))
        } else {
            showLoginFailure(message: "Please enter your Udacity username and password")
        }
    }
    
    private func handleLoginResponse(success: Bool, error: Error?) {
        DispatchQueue.main.async {
            self.setLoggingIn(false)
            if success {
                self.performSegue(withIdentifier: "showDashboard", sender: nil)
            } else {
                self.showLoginFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    private func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        show(alertVC, sender: nil)
    }
    
    private func setLoggingIn(_ loggingIn: Bool) {
   
        if loggingIn {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
        userName.isEnabled = !loggingIn
        password.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        signupText.isSelectable = !loggingIn
   
    }
    
    private func updateTextView() {
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

