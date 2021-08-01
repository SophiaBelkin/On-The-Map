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

    @IBAction func addLocation(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "addLocationView") as! AddLocationViewController
        vc.region = region.text ?? "CA"
        vc.mediaURL = mediaURL.text ?? "https://www.udacity.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
