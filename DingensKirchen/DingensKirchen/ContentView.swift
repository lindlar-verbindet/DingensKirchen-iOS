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
    
    @State var news: WPNews?
    @State var event: WPEvent?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView(.vertical) {
                    if let news = news {
                        NavigationLink(destination: NewsView()) {
                            NewsWidget(date: news.dateString,
                                       newsTitle: news.title,
                                       newsDesc: news.htmlFreeDesc)
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
                    if let event = self.event {
                        NavigationLink(destination: EventView()) {
                            EventWidget(date: event.dateString, eventTitle: event.title, eventDesc: event.desc)
                            
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
//                self.event = WPEventHelper().getlatestEvent() ?? nil
                WPEventHelper.getEvents { events in
                    print(events)
                    self.event = events.first
                }
                WPNewsHelper.getNews { news in
                        print(news)
                        self.news = news.first
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
