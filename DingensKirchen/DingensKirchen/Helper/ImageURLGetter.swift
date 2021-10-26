//
//  ImageURLGetter.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import Foundation

struct ImageURLGetter {
    static func getImageURL(content: String) -> String? {
        let imgTagPatter = "<img([\\w\\W]+?)/>"
        let urlPattern = "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{1,256}\\.[a-zA-Z0-9()]{1,6}\\b([-a-zA-Z0-9()@:%_\\+.~#?&//=]*)"
        
        do {
            let imgTagRegEx = try NSRegularExpression(pattern: imgTagPatter, options: .caseInsensitive)
            let imgMatches = imgTagRegEx.matches(in: content, options: [], range: NSRange(location: 0, length: content.count))
            let imgTags = imgMatches.map {
                String(content[Range($0.range, in: content)!])
            }
            
            var results = [String]()
            
            for img in imgTags {
                if let urlRange = img.range(of: urlPattern, options: .regularExpression) {
                    results.append(String(img[urlRange]))
                }
            }
            return results.first
        } catch {
            print(error)
            return nil
        }
    }
}
