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
    
    @State private var animate = false
    @State private var scale = 1.0
    @State private var degrees = 10
    
    private let benchAnimation = Animation.easeInOut(duration: 1)
                                            .repeatCount(3, autoreverses: true)
//                                          .repeatForever(autoreverses: true)
    private let benchTimerBig = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
//    private let benchTimerSmall = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView(.vertical) {
                    HStack {
                        Spacer()
                        Image(uiImage: UIImage(named: "ic_bench")!)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(animate ? 1.1 : 1.0, anchor: .center)
                            .frame(width: 200, height: 140)
                            .animation(.linear(duration: 0.6))
                            .onChange(of: animate, perform: { newValue in
                                if newValue == true {
                                    animate.toggle()
                                }
                            })
                            .padding()
                            .onReceive(benchTimerBig) { _ in
                                animate.toggle()
                            }
                    }
                    
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
                        NavigationLink(destination: MobilView()) {
                            MobilWidget()
                        }
                        NavigationLink(destination: CouncilView()){
                            CouncilWidget()
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
                            .padding(.bottom, 40)
                    }
                    Image(uiImage: UIImage(named: "ic_skyline")!)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.primaryBackground)
                        .ignoresSafeArea()
                        .padding(.leading, -10)
                        .padding(.trailing, -10)
                        .padding(.bottom, -50)
        
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Image(uiImage:UIImage(named: "ic_logo")!)
                                    .resizable()
                                    .frame(width: 200, height: 30)
                                    .padding())
            .navigationBarItems(trailing: Image(uiImage: UIImage(named: "ic_info")!)
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .padding())
            .onAppear {
                guard events == nil else { return }
                WPEventHelper.getEvents { events in self.events = events }
                WPNewsHelper.getNews { news in
                    if self.news != nil {
                        self.news = append(news, toArray: self.news!)
                    } else {
                        self.news = news
                    }
                    
                }
                RSSNewsHelper.getNews { news in
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
        ContentView().previewDevice("iPod touch (7th generation)").environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
