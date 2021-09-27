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
            Text(title.uppercased())
                .font(Font.system(size: 20))
                .foregroundColor(.white)
                .bold()
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
            Text(date)
                .font(Font.system(size: 12))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
            Text(newsTitle)
                .font(Font.system(size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            Text(newsDesc.cutoffIfNeeded(maxChars: 120))
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 2, leading: 15, bottom: 15, trailing: 15))
                
        }
        .widget()
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
