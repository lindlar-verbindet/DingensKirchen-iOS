//
//  Widget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct Widget: ViewModifier {

    @State var background: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .background(background)
            .cornerRadius(15)
    }
}

struct SmallWidget: ViewModifier {

    @State var background: Color
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 130, maxHeight: 130, alignment: .leading)
            .background(background)
            .cornerRadius(15)
    }
}

