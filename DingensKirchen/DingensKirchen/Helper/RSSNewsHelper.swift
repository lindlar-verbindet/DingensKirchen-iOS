//
//  RSSNewsHelper.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 27.09.21.
//

import Foundation
import Alamofire
import SWXMLHash


struct RSSNewsHelper {
    
    static func getNews(callback: @escaping ([News]) -> Void) {
        requestNews(callback: callback)
    }
    
    private static func requestNews(callback: @escaping ([News]) -> Void) {
        let urlString: String = NSLocalizedString("lindlar_server_url", comment: "")
        
        var result = [News]()
                
        let request = AF.request(urlString).validate()
        
        request.responseData { response in
            if let data = response.data {
                let xml = SWXMLHash.config { config in
                    config.encoding = .unicode
                }.parse(data)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
                
                var index = 0
                xml["rss"]["channel"]["item"].all.forEach { item in
                    let title = item["title"].element?.text ?? ""
                    let desc = item["content:encoded"].element?.text.replacingOccurrences(of: "&nbsp;", with: "") ?? ""
                    let date = formatter.date(from: item["pubDate"].element!.text)
                    let link = item["link"].element?.text ?? ""
                    let imageURL = ImageURLGetter.getImageURL(content: desc)
                    
                    if let date = date {
                        let news = News(index: index, title: title, desc: desc, date: date, link: link, imageURL: imageURL)
                        index += 1
                        result.append(news)
                    }
                }
                callback(result)
            }
        }
    }
    
}
