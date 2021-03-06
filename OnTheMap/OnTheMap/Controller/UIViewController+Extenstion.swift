//
//  UIViewController+Extenstion.swift
//  OnTheMap
//
//  Created by Sophia Lu on 8/1/21.
//

import UIKit

extension UIViewController {
    func showFailedMessage(title: String, message: String) {
        let alertVC = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertVC, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
     
    func changeButtonState(button: UIButton, enable: Bool) {
        if enable {
            button.isEnabled = true
            button.alpha = 1
        } else {
            button.isEnabled = false
            button.alpha = 0.5
        }
    }
    
    func displayIndicator(_ indicator: UIActivityIndicatorView, display: Bool) {
        if display {
            indicator.isHidden = false
            indicator.startAnimating()
        } else {
            indicator.isHidden = true
            indicator.stopAnimating()
        }
    }
    
}
