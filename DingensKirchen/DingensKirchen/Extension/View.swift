//
//  View.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

extension View {
    
    func widgetText(isTitle: Bool = false) -> some View {
        modifier(WidgetText(isTitle: isTitle))
    }
}
