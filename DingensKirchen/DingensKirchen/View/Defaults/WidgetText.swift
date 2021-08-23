//
//  WidgetText.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct WidgetText: ViewModifier {
    
    @State var isTitle: Bool = false 
    
    func body(content: Content) -> some View {
        if isTitle {
            content
                .font(.headline)
                .foregroundColor(.white)
        } else {
            content
                .foregroundColor(.white)
        }

    }
}
