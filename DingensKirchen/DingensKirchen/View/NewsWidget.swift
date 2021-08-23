//
//  NewsWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct NewsWidget: View {
    
    var title: String = "Lindlarer News"
    @State var date: String = ""
    @State var newsTitle: String = ""
    @State var newsDesc: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .widgetText(isTitle: true)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(date)
                .widgetText()
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            Text(newsTitle)
                .widgetText(isTitle: true)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
            Text(newsDesc)
                .widgetText()
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        .background(Color.gray)
        .cornerRadius(5)
        .padding(5)
    }
}

struct NewsWidget_Previews: PreviewProvider {
    static var previews: some View {
        NewsWidget(date: "01.01.1970",
                   newsTitle: "Letzte Nachricht",
                   newsDesc: "Lorem Ipsum dolor sit amet, consetetur....")
    }
}
