//
//  ListPinsViewController.swift
//  OnTheMap
//
//  Created by sophia liu on 7/25/21.
//

import UIKit

class TableTabbedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        UdacityClient.getStudentsInfo { data, error in
            Global.studentsInfo = data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        UdacityClient.getStudentsInfo { data, error in
            Global.studentsInfo = data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InfoPostingViewController") as! InfoPostingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
   
}

extension TableTabbedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Global.studentsInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableTabbedViewCell
        let student = Global.studentsInfo[indexPath.row]
        
        cell.studentName.text = student.firstName
        cell.studentURL.text = student.mediaURL
       
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = Global.studentsInfo[indexPath.row]
        let url = URL(string: student.mediaURL)!
    
        UIApplication.shared.open(url)
    }
}



