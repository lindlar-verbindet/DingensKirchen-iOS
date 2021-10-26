//
//  APIHelper.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIHelper {
    
    static func sendPOST(url: String, json: JSON, callback: @escaping (_: String) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            let data = try json.rawData()
            request.httpBody = data
            AF.request(request).responseJSON { response in
                print(response)
                callback(response.debugDescription)
            }
        } catch {
            print(error)
        }
        
    }
}
