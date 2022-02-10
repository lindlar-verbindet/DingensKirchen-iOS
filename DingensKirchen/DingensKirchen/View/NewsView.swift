//
//  NewsView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct NewsView: View {
    
    @State var newsViewModel = NewsViewModel()
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack{
                    Spacer()
                    Image(uiImage: UIImage(named: "ic_megaphone")!)
                        .foregroundColor(.primaryBackground)
                }
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackground)
                    .padding(.top, -20)
                    .ignoresSafeArea()
            }
            ScrollView(.vertical) {
                Spacer()
                    .frame(height: 120)
                ForEach(newsViewModel.response ?? [News](), id: \.self) { n in
                    NavigationLink(destination: DKWebView(urlString: n.link, hideBackButtons: false)) {
                        NewsCell(index: n.index,
                                 title: n.title,
                                 desc: n.htmlFreeDesc,
                                 date: n.dateString,
                                 imageURL: n.imageURL)
                            .padding(5)
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle("news_navigation_title", displayMode: .inline)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(newsViewModel: NewsViewModel())
    }
}
