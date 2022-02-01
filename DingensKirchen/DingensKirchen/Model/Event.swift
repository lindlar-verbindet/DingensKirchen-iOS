//
//  WPEvent.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 06.09.21.
//

import Foundation

struct Event: Hashable {
    var index:      Int
    let title:      String
    let desc:       String
    var htmlFreeDesc: String {
        get {
            let linkfree = desc.replacingOccurrences(of: "<figcaption>Favicon</figcaption>", with: "")
            return linkfree.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression)
        }
    }
    let date:       Date
    var dateString: String {
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
            
            return dateFormatter.string(from: self.date)
        }
    }
    let start:      String
    let end:        String
    let location:   String
    let link:       String
}
