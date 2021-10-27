//
//  WPNewsHelper.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 06.09.21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct WPNewsHelper {
    
    static func getNews(callback: @escaping ([News]) -> Void) {
        requestNews(callback: callback)
    }
    
    private static func requestNews(callback: @escaping ([News]) -> Void) {
        let newsID: String = NSLocalizedString("live_news_category", comment: "")
        let urlString: String = NSLocalizedString("live_news_url", comment: "")
        
        var result = [News]()
        
        let headers: HTTPHeaders = [.accept("application/json")]
        
        let request = AF.request(urlString+newsID, headers: headers)
                        .validate()
        request.responseJSON { response in
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "de_DE")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                var index = 0
                for element in json.arrayValue {
                    let title = element["title"]["rendered"].string
                    let desc = element["content"]["rendered"].string
                    let date = formatter.date(from: element["date"].string!)
                    let link = element["link"].string
                    let imageURL = ImageURLGetter.getImageURL(content: desc ?? "")
                
                    let news = News(index: index, title: title!, desc: desc!, date: date!, link: link!, imageURL: imageURL)
                    result.append(news)
                    index += 1
                }
                callback(result)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
