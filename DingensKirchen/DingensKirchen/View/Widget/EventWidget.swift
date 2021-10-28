//
//  EventWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct EventWidget: View {
    
    let title: String = "Termine"
    
    @State var date: String = ""
    @State var eventTitle: String = NSLocalizedString("widget_events_loading", comment: ""   )
    @State var eventDesc: String = ""

    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(uiImage: UIImage(named: "ic_clock")!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.trailing, 20)
                    .foregroundColor(.black)
                    .opacity(0.2)
            }
            VStack(alignment: .leading) {
                Text(title.uppercased())
                    .font(Font.system(size: 26, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                Text(date)
                    .font(Font.system(size: 12))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Text(eventTitle)
                    .font(Font.system(size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Text(eventDesc)
                    .font(Font.system(size: 16, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .widget(background: .primaryHighlight)
        .padding(5)
    }
}

struct EventWidget_Previews: PreviewProvider {
    static var previews: some View {
        EventWidget(date: "01.01.1970", eventTitle: "Beispieltermin", eventDesc: "Kurzbeschreibung")
    }
}
