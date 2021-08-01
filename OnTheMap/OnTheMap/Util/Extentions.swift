//
//  Extentions.swift
//  OnTheMap
//
//  Created by Sophia Lu on 7/31/21.
//

import Foundation


extension NSAttributedString {
    
    static func makeHyperlink(for path: String, in string: String, as subString: String) -> NSAttributedString {
        let substringRange = (string as NSString).range(of: subString)
        let attributeString = NSMutableAttributedString(string: string)
        
        attributeString.addAttribute(.link, value: path, range: substringRange)
        return attributeString
    }
}
