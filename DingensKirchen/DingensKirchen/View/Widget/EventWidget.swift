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
            Text(title.uppercased())
                .font(Font.system(size: 20))
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(date)
                .font(Font.system(size: 12))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            Text(eventTitle)
                .font(Font.system(size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Text(eventDesc)
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .widget(background: Color.primaryHighlight)
        .padding(5)
    }
}

struct EventWidget_Previews: PreviewProvider {
    static var previews: some View {
        EventWidget(date: "01.01.1970", eventTitle: "Beispieltermin", eventDesc: "Kurzbeschreibung")
    }
}
