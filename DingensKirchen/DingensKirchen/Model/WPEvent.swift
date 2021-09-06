//
//  WPEvent.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 06.09.21.
//

import Foundation

struct WPEvent {
    let title:      String
    let desc:       String
    let date:       Date
    var dateString: String {
        get{
            let dateFormatter = DateFormatter()
            return dateFormatter.string(from: self.date)
        }
    }
    let start:      String
    let end:        String
    let location:   String
    let link:       String
}
