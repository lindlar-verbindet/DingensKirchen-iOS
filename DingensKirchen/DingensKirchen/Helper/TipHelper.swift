//
//  TipHelper.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 25.10.21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct TipHelper {
    
    static func getTodaysTip(callback: @escaping (Tip) -> Void) {
        let urlString = NSLocalizedString("tipp_server_url", comment: "")
        let currentDay = Calendar.autoupdatingCurrent.ordinality(of: .day, in: .year, for: Date()) ?? 0
        
        var result = [Tip]()
        let request = AF.request(urlString).validate()
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                var index = 0
                for element in json.arrayValue {
                    let id = element["id"].int ?? 0
                    let title = element["headline"].string ?? ""
                    let content = element["text"].string ?? ""
                    
                    let tip = Tip(id: id, title: title, content: content)
                    result.append(tip)
                    index += 1
                }
                guard result.count != 0 else { return } 
                callback(result[currentDay % result.count])
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
