//
//  WPNews.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 06.09.21.
//

import Foundation

struct News: Hashable, Decodable {
    var index:  Int
    let title:  String
    let desc:   String
    var htmlFreeDesc: String {
        get {
            let linkfree = desc.replacingOccurrences(of: "<figcaption>Favicon</figcaption>", with: "")
            return linkfree.replacingOccurrences(of: "<[^>]+>", with: "",options: .regularExpression)
        }
    }
    let date:   Date
    var dateString: String {
        get {
            let dateFormatter = DateFormatter()
//            dateFormatter.calendar = Calendar(identifier: .iso8601)
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.setLocalizedDateFormatFromTemplate("`dd-MM-YYYY`")
            
            return dateFormatter.string(from: self.date)
        }
    }
    let link:   String
    let imageURL: String?
}
