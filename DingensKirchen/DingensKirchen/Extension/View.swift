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
    
    func widget(background: Color = Color.primaryBackground) -> some View {
        modifier(Widget(background: background))
    }
    
    func smallWidget(background: Color = Color.primaryBackground) -> some View {
        modifier(SmallWidget(background: background))
    }
}
