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
    @State var tip: Tip? 
    @State var events: [WPEvent]?
    @State var showAlert: Bool = false
    
    @State private var animate = false
    
    private let benchTimerBig = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    ScrollView(.vertical) {
                        HStack {
                            Spacer()
                            Button {
                                if self.tip != nil {
                                    showAlert.toggle()
                                }
                            } label: {
                                Image(uiImage: UIImage(named: "ic_bench")!)
                                    .resizable()
                                    .scaledToFit()
                                    .scaleEffect(animate ? 1.1 : 1.0, anchor: .center)
                                    .rotationEffect(.degrees(animate ? -10 : 0), anchor: .topLeading)
                                    .animation(.linear(duration: 0.6))
                                    .frame(width: 200, height: 140)
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
                        }
                        
                        if let news = news {
                            NavigationLink(destination: NewsView(news: news)) {
                                NewsWidget(date: news.first!.dateString,
                                           newsTitle: news.first!.title,
                                           newsDesc: news.first!.htmlFreeDesc)
                            }
                        } else {
                            NewsWidget(date: "",
                                       newsTitle: NSLocalizedString("widget_news_loading", comment: ""),
                                       newsDesc: "")
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
                                        eventTitle: NSLocalizedString("widget_events_loading", comment: ""),
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
                .blur(radius: showAlert ? 5 : 0)
                .disabled(showAlert)
                if (showAlert) {
                    DKAlertView(shown: $showAlert, title: tip!.title, content: tip!.content)
                }
            }
            
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Image(uiImage:UIImage(named: "ic_logo")!)
                                    .resizable()
                                    .frame(width: 140, height: 30)
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
                    self.news?.sort(by: { n1, n2 in
                        n1.date > n2.date
                    })
                }
                RSSNewsHelper.getNews { news in
                    if self.news != nil {
                        self.news = append(news, toArray: self.news!)
                    } else {
                        self.news = news
                    }
                    self.news?.sort(by: { n1, n2 in
                        n1.date > n2.date
                    })
                }
                TipHelper.getTodaysTip { currentTip in
                    self.tip = currentTip
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
