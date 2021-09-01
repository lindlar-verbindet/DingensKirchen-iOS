//
//  View.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

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
    
    // rounding specific corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
