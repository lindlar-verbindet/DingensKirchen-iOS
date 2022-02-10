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
    
    @AppStorage("firstStart") var firstStart = true

    @StateObject var newsViewModel = NewsViewModel()
    @StateObject var eventViewModel = EventViewModel()
    
    @State var showAlert: Bool = false
    @State var showTutorial: Bool = false
    @State private var animate = false
    
    @State var tip: Tip?
    private let benchTimerBig = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    ScrollView(.vertical) {
                        VStack(alignment: .leading) {
                            Button {
                                self.showTutorial.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 30, height: 30)
                            .padding()
                            HStack {
                                Spacer()
                                Button {
                                    if self.tip != nil {
                                        self.showAlert = true
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
                                            DispatchQueue.main.async {
                                                animate.toggle()
                                            }
                                        }
                                }
                            }
                        }
                        
                        if let news = newsViewModel.response {
                            NavigationLink(destination: NewsView(newsViewModel: newsViewModel)) {
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
                        if let events = self.eventViewModel.response {
                            NavigationLink(destination: EventView(events: events)) {
                                EventWidget(date: events.first!.dateString,
                                            title: events.first!.title,
                                            eventDesc: events.first!.htmlFreeDesc.cutoffIfNeeded(maxChars: 40))
                            }
                        } else {
                            EventWidget(date: "",
                                        title: NSLocalizedString("widget_events_loading", comment: ""),
                                        eventDesc: "")
                        }
                        NavigationLink(destination: DKWebView(urlString: "https://www.lindlar-verbindet.de/umfrage", hideBackButtons: false)) {
                            SurveyWidget(title: NSLocalizedString("widget_survey_title", comment: ""),
                                         desc: NSLocalizedString("widget_survey_desc", comment: ""))
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
                .blur(radius: showTutorial ? 5 : 0)
                .disabled(showAlert)
                .disabled(showTutorial)
                if (showAlert) {
                    DKAlertView(shown: $showAlert,
                                title: tip!.title,
                                content: tip!.content)
                }
                if (showTutorial) {
                    TutorialView(shown: $showTutorial)
                }
            }
            
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Image(uiImage:UIImage(named: "ic_logo")!)
                                    .resizable()
                                    .frame(width: 140, height: 30)
                                    .padding())
            .navigationBarItems(trailing: NavigationLink(destination: InfoView(), label: {
                Image(uiImage: UIImage(systemName: "info")!)
                    .resizable()
                    .foregroundColor(.gray)
                    .frame(width: 15, height: 25)
                    .padding()
            }))
            .onAppear {
                if eventViewModel.response == nil {
                    eventViewModel.loadEvents()
                }
                if newsViewModel.response == nil {
                    newsViewModel.loadNews()
                }
                TipHelper.getTodaysTip { currentTip in
                    tip = currentTip
                }
                if firstStart {
                    showTutorial = firstStart
                    firstStart = false
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
            EventWidget(date: eventViewModel.response?.first?.dateString ?? "",
                        title: eventViewModel.response?.first?.title ?? "",
                        eventDesc: eventViewModel.response?.first?.desc ?? "")
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
