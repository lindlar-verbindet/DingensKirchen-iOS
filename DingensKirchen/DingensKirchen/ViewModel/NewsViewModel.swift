//
//  NewsViewModel.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 01.02.22.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var response: [News]?
    
    func loadNews() {
        WPNewsHelper.getNews { news in
            self.handleResponse(news: news)
        }
        RSSNewsHelper.getNews { news in
            self.handleResponse(news: news)
        }
    }
    
    private func handleResponse(news: [News]) {
        let temp = (self.response ?? []) + news
        self.response = temp.sorted { $0.date > $1.date }
        if let responseCount = self.response?.count {
            for i in 0...(responseCount-1) {
                self.response?[i].index = i
            }
        }
    }
}
