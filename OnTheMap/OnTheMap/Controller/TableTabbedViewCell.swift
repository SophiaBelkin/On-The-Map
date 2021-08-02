//
//  TableTabbedViewCell.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/25/21.
//

import UIKit

class TableTabbedViewCell: UITableViewCell {

  
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentURL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
