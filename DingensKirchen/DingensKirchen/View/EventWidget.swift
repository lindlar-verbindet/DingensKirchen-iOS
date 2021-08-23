//
//  EventWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct EventWidget: View {
    
    let title: String = "Veranstaltungen & Termine"
    
    @State var date: String = ""
    @State var eventTitle: String = ""
    @State var eventDesc: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .widgetText(isTitle: true)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(date)
                .widgetText()
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            Text(eventTitle)
                .widgetText(isTitle: true)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Text(eventDesc)
                .widgetText()
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .background(Color.primaryHighlight)
        .cornerRadius(5)
        .padding(5)
    }
}

struct EventWidget_Previews: PreviewProvider {
    static var previews: some View {
        EventWidget(date: "01.01.1970", eventTitle: "Beispieltermin", eventDesc: "Kurzbeschreibung")
    }
}
