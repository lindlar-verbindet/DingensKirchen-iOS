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
    
}
