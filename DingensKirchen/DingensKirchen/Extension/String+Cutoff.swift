//
//  String+Cutoff.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 06.09.21.
//

import Foundation

extension String {
    
    func cutoffIfNeeded(maxChars: Int) -> String {
        if self.count >= maxChars {
            return String(self.prefix(maxChars-3)+"...")
        } else {
            return self
        }
    }
    
    func dropLastChars(_ number: Int) -> String {
        var result = self
        let endIndex = (self.count - number)
        for _ in (0 ... endIndex){
            result = String(result.dropLast())
        }
        return result
    }
    
    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }
    
    func unicodeToUtf8() -> String {
        let data = self.data(using: .unicode)
        return String(data: data!, encoding: .utf8) ?? ""
    }
}
