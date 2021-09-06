//
//  WPEventHelper.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 06.09.21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WPEventHelper {
    
    private let urlString: String = "https://www.lindlar-verbindet.de/wp-json/mecexternal/v1/calendar/412"
    
    func getlatestEvent() -> WPEvent? {
        let events = requestEvents()
        if events.isEmpty {
            return nil
        } else {
            return events.first
        }
    }
    
    func getEvents() -> [WPEvent]? {
        let events = requestEvents()
        if events.isEmpty {
            return nil
        } else {
            return events
        }
    }
    
    private func requestEvents() -> [WPEvent] {
        var result = [WPEvent]()
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        let request = AF.request(urlString, headers: headers)
                        .validate()
        request.responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                if !json["content_json"].isEmpty {
                    let dummy = json["content_json"]
                    for element in dummy {
                        print(element.0)
                        let formatter = DateFormatter()
                        formatter.locale = Locale(identifier: "de_DE")
                        formatter.dateFormat = "yyyy-MM-dd"
                        if let date = formatter.date(from: String(element.0)) {
                            let content = element.1
                            let title = content["title"].string
                            let desc = content["desc"].string
                            let start = content["time"]["start_raw"].string
                            let end = content["time"]["end_raw"].string
                            var location = ""
                            for loc in content["locations"] {
                                location = loc.0
                            }
                            let link = content["permalink"].string
                            
                            let event = WPEvent(title: title!, desc: desc!, date: date, start: start!, end: end!, location: location, link: link!)
                            result.append(event)
                        }
                    }
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
        return result
    }
    
}
