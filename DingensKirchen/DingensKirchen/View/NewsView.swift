//
//  NewsView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct NewsView: View {
    
    @State var news: [News]
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(news, id: \.self) { n in
                NavigationLink(destination: DKWebView(urlString: n.link)) {
                    NewsCell(index: n.index,
                             title: n.title,
                             desc: n.htmlFreeDesc,
                             date: n.dateString)
                        .padding(5)
                }
            }
        }
        .navigationBarTitle("Lindlarer News", displayMode: .inline)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(news: [News(index: 0, title: "title", desc: "desc", date: Date(), link: "pixelskull.de")])
    }
}
