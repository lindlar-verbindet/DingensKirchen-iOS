//
//  VillageWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct VillageWidget: View {
    
    let title: String = "Dorfleben"
    
    @State var desc: String = "Suche&Finde, DigitalBegleitung, Nachbarschaftshilfe, Taschengeldbörse"
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .widgetText(isTitle: true)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(desc)
                .widgetText()
                .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
        }
        .widget(background: Color.primaryHighlight)
        .padding(5)
    }
}

struct VillageWidget_Previews: PreviewProvider {
    static var previews: some View {
        VillageWidget()
    }
}