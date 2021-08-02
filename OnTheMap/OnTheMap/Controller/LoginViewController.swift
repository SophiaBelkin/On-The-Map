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
        userName.delegate = self
        password.delegate = self
        displayIndicator(activityIndicator, display: false)
        updateTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userName.text = ""
        password.text = ""
        
        changeButtonState(button: loginButton, enable: false)
    }
    
    @IBAction func login(_ sender: Any) {
        setLoggingIn(true)
        let username = userName.text
        let password = password.text
        
        if username != nil && password != nil {
            UdacityClient.login(username: username!, password: password!, completion: handleLoginResponse(success:error:))
        } else {
            showFailedMessage(title: "Login Failed", message: "Please enter your Udacity username and password")
        }
    }
    
    private func handleLoginResponse(success: Bool, error: Error?) {
        DispatchQueue.main.async {
            self.setLoggingIn(false)
            if success {
                self.performSegue(withIdentifier: "showDashboard", sender: nil)
            } else {
                self.showFailedMessage(title: "Login Failed", message: error?.localizedDescription ?? "")
            }
        }
    }
        
    
    private func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            displayIndicator(activityIndicator, display: true)
        } else {
            displayIndicator(activityIndicator, display: false)
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

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange, with: string)
            var enable: Bool = false
            if textField == userName {
                let passwordText = password.text ?? ""
                enable = !updatedText.isEmpty && !passwordText.isEmpty
            } else if textField == password {
                let userNameText = userName.text ?? ""
                enable = !updatedText.isEmpty && !userNameText.isEmpty
            }
            changeButtonState(button: loginButton, enable: enable)
        }
        
        return true
    }
}

