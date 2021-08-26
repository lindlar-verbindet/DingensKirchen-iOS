//
//  CouncilWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct CouncilWidget: View {
    
    let title: String = "Rathaus"
    
    @State var desc: String = "OnlineServices, Müllkalender"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .widgetText(isTitle: true)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(desc)
                .widgetText()
                .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
        }
        .smallWidget()
        .padding(5)
    }
}

struct CouncilWidget_Previews: PreviewProvider {
    static var previews: some View {
        CouncilWidget()
    }
}
