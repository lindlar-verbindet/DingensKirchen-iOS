//
//  LindlarEventHelper.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.11.21.
//

import Foundation
import Alamofire
import SwiftyJSON
import Turf

struct LindlarEventHelper {
    static func getEvents(callback: @escaping ([Event]) -> Void) {
        requestEvents(callback: callback)
    }
    
    private static func requestEvents(callback: @escaping ([Event]) -> Void) {
        let currentDate = String(Date().timeIntervalSince1970)
        let currentTime = currentDate.split(separator: ".").first!
        
        let urlString: String = "https://lindlar.de/?eID=event_api&token=8_435!B!tV_9wuj-3P*e&mod=event&start=" + currentTime
        print(currentTime)
        
        var result = [Event]()
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        let request = AF.request(urlString, headers: headers)
                        .validate()
        request.responseData { response in
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "de_DE")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let timeFormatter = DateFormatter()
            timeFormatter.locale = Locale(identifier: "de_DE")
            timeFormatter.dateFormat = "HH:mm"
            
            switch response.result {
            case .success(let data):
                guard let json = JSON(data)["events"].array else { return }
                var index = 0
                for element in json {
                    let title = element["title"].string ?? ""
                    let desc = element["description"].string ?? ""
                    let location = element["venue"].string ?? ""
                    
                    let startTimestamp = element["event_dates"]["event_start"].int
                    let startDate = Date(timeIntervalSince1970: Double((startTimestamp ?? 0)))
                    let startTime = timeFormatter.string(from: startDate)
                    
                    let endTimestamp = element["event_dates"]["event_end"].int
                    let endDate = Date(timeIntervalSince1970: Double((endTimestamp ?? 0)))
                    let endTime = endTimestamp == 0 ? "" : timeFormatter.string(from: endDate)
                    
                    let link = element["url"].string ?? ""
                    
                    let event = Event(index: index,
                                        title: title,
                                        desc: desc,
                                        date: startDate,
                                        start: startTime,
                                        end: endTime,
                                        location: location,
                                        link: link)
                    if (element["hidden"].bool == false &&
                        element["deleted"].bool == false) {
                        result.append(event)
                        index += 1
                    }
                }
                callback(result)
            case.failure(let error):
                print(error)
                break
            }
        }
    }
}
