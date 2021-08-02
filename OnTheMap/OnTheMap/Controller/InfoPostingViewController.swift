//
//  InfoPostingViewController.swift
//  OnTheMap
//
//  Created by sophia liu on 7/25/21.
//

import UIKit


class InfoPostingViewController: UIViewController {
  
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var mediaURL: UITextField!
    @IBOutlet weak var findLocation: UIButton!
    
    @IBAction func addLocation(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "addLocationView") as! AddLocationViewController
        vc.region = region.text ?? "CA"
        vc.mediaURL = mediaURL.text ?? "https://www.udacity.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonState(button: findLocation, enable: false)
        region.delegate = self
        mediaURL.delegate = self
    }
    
}

extension InfoPostingViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

       if let text = textField.text,
          let textRange = Range(range, in: text) {
          let updatedText = text.replacingCharacters(in: textRange, with: string)
           var enable: Bool = false
           if textField == region {
                enable = !updatedText.isEmpty
                changeButtonState(button: findLocation, enable: enable)
           }
          
       }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
