//
//  ContentView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI
import CoreData

enum NavigationAction {
    case news
    case village
    case council
    case mobil
    case event
}

struct ContentView: View {
    
    @State var news: [News]?
    @State var events: [WPEvent]?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView(.vertical) {
                    if let news = news {
                        NavigationLink(destination: NewsView(news: news)) {
                            NewsWidget(date: news.first!.dateString,
                                       newsTitle: news.first!.title,
                                       newsDesc: news.first!.htmlFreeDesc)
                        }
                    } else {
                        NewsWidget(date: "", newsTitle: "Aktuell sind keine Nachrichten Vorhanden", newsDesc: "")
                    }
                    NavigationLink(destination: VillageView()) {
                        VillageWidget()
                    }
                    HStack {
                        NavigationLink(destination: CouncilView()){
                            CouncilWidget()
                        }
                        NavigationLink(destination: MobilView()) {
                            MobilWidget()
                        }
                    }
                    if let events = self.events {
                        NavigationLink(destination: EventView(events: events)) {
                            EventWidget(date: events.first!.dateString,
                                        eventTitle: events.first!.title,
                                        eventDesc: events.first!.htmlFreeDesc.cutoffIfNeeded(maxChars: 40))
                        }
                    } else {
                        EventWidget(date: "",
                                    eventTitle: "Es gibt aktuell keine Termine",
                                    eventDesc: "")
                            
                    }
                }
            }
            .navigationBarTitle("DingensKirchen")
            .onAppear {
                WPEventHelper.getEvents { events in self.events = events }
                WPNewsHelper.getNews { news in
                    if self.news != nil {
                        self.news = append(news, toArray: self.news!)
                    } else {
                        self.news = news
                    }
                    
                }
                RSSNewsHelper.getNews { news in
                    print(news)
                    if self.news != nil {
                        self.news = append(news, toArray: self.news!)
                    } else {
                        self.news = news
                    }
                }
            }
        }
        .accentColor(.secondaryHighlight)
    }
    
    @ViewBuilder func switchView(action:NavigationAction) -> some View {
        switch action {
        case .news:
            NewsWidget()
        case .village:
            VillageWidget()
        case .mobil:
            MobilWidget()
        case .event:
            EventWidget()
        case .council:
            CouncilWidget()
        }
    }
    
    func append(_ values:[News], toArray:[News]) -> [News] {
        var index = toArray.count
        var resultArray = toArray
        values.forEach { n in
            var new = n
            new.index = index
            resultArray.append(new)
            index += 1
        }
        
        return resultArray
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
