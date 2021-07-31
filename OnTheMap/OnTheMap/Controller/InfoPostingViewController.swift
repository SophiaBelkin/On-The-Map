//
//  InfoPostingViewController.swift
//  OnTheMap
//
//  Created by sophia liu on 7/25/21.
//

import UIKit


class InfoPostingViewController: UIViewController {
  
    @IBOutlet weak var city: UITextField!
    
    @IBOutlet weak var mediaURL: UITextField!

    @IBAction func addLocation(_ sender: Any) {
        performSegue(withIdentifier: "getLocation", sender: city)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getLocation" {
            let vc = segue.destination as! AddLocationViewController
            
            vc.city = sender as! String
        }
    }
    
}
