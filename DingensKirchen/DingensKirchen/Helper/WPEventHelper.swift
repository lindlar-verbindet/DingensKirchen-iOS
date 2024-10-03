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
    
    static func getEvents(callback: @escaping ([Event]) -> Void) {
        requestEvents(callback: callback)
    }
    
    private static func parseResult(data: Data,  callback: @escaping ([Event]) -> Void) {
        var result = [Event]()
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let json = JSON(data)
        if !json["content_json"].isEmpty {
            let data = json["content_json"]
            var index = 0
            let sorted = data.sorted { a, b in
                formatter.date(from: a.0)! <= formatter.date(from: b.0)!
            }
            for (key, value) in sorted {
                
                let date = formatter.date(from: key)
                guard let appointmentArray = value.array else { return }
                
                appointmentArray.forEach { element in
//                    let content = element.1[0]
                    let content = element
                    let title = content["data"]["title"].string
                    let desc = content["data"]["content"].string
                    let start = content["data"]["time"]["start"].string ?? ""
                    let end = content["data"]["time"]["end"].string ?? ""
                    var location = ""
                    for loc in content["data"]["locations"] {
                        location = loc.1["name"].string!
                        if loc.1["address"].exists() {
                            location = loc.1["address"].string!
                        }
                    }
                    let link = content["data"]["permalink"].string
                    
                    let event = Event(index: index,
                                      title: title!,
                                      desc: desc!,
                                      date: date!,
                                      start: start,
                                      end: end,
                                      location: location,
                                      link: link!)
                    result.append(event)
                    index += 1
                }
                
            }
        }
        callback(result)
    }
    
    private static func requestEvents(callback: @escaping ([Event]) -> Void) {
        let urlString: String = NSLocalizedString("live_event_url", comment: "")
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        let request = AF.request(urlString, headers: headers)
                        .validate()
        request.responseData { response in
            switch response.result {
            case .success(let data):
                parseResult(data: data, callback: callback)
            case .failure(let error):
                print(error)
                callback([Event]())
                break
            }
        }
    }
}
