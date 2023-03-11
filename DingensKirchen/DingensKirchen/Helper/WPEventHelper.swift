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
    
    private static func requestEvents(callback: @escaping ([Event]) -> Void) {
        let urlString: String = NSLocalizedString("live_event_url", comment: "")
        
        var result = [Event]()
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        let request = AF.request(urlString, headers: headers)
                        .validate()
        request.responseDecodable(of: JSON.self) { response in
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "de_DE")
            formatter.dateFormat = "yyyy-MM-dd"
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                if !json["content_json"].isEmpty {
                    let data = json["content_json"]
                    var index = 0
                    let sorted = data.sorted { a, b in
                        formatter.date(from: a.0)! <= formatter.date(from: b.0)!
                    }
                    for element in sorted {
                        if let date = formatter.date(from: String(element.0)) {
                            let content = element.1[0]
                            let title = content["data"]["title"].string
                            let desc = content["data"]["content"].string
                            let start = content["data"]["time"]["start_raw"].string ?? ""
                            let end = content["data"]["time"]["end_raw"].string ?? ""
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
                                                date: date,
                                                start: start,
                                                end: end,
                                                location: location,
                                                link: link!)
                            result.append(event)
                            index += 1 
                        }
                    }
                    callback(result)
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
