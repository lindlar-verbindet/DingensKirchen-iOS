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
    @State var newsTitle: String = NSLocalizedString("widget_news_loading", comment: "")
    @State var newsDesc: String = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack(alignment: .bottom){
                Spacer()
                Image(uiImage: UIImage(named: "ic_megaphone")!)
                    .resizable()
                    .frame(width: 120, height: 100)
                    .padding(.trailing, 20)
                    .foregroundColor(.black)
                    .opacity(0.2)
            }
            VStack(alignment: .leading) {
                Text(title.uppercased())
                    .font(Font.system(size: 26, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
                Text(date)
                    .font(Font.system(size: 12))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                Text(newsTitle)
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                Text(newsDesc.cutoffIfNeeded(maxChars: 120))
                    .font(Font.system(size: 16, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                    
            }
        }
        .widget(background: .primaryHighlight)
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
