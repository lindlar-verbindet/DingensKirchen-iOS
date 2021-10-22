//
//  EventVIew.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct EventView: View {
    
    @State var events: [WPEvent]
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("ic_clock")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.primaryBackground)
                        .scaledToFit()
                }
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackground)
                    .padding(.top, -10)
                    .ignoresSafeArea()
            }
            VStack(alignment: .leading) {
                ScrollView(.vertical) {
                    Spacer()
                        .frame(height: 120)
                    ForEach(events, id: \.self) { event in
                        NavigationLink(destination: DKWebView(urlString: event.link)) {
                            EventCell(date: event.dateString,
                                      start: event.start,
                                      end: event.end,
                                      title: event.title,
                                      desc: event.htmlFreeDesc,
                                      address: event.location,
                                      website: event.link,
                                      index: event.index)
                                .padding(5)
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle("Termine", displayMode: .inline)
    }
}

struct EventVIew_Previews: PreviewProvider {
    static var previews: some View {
        EventView(events: [WPEvent(index: 0, title: "heading", desc: "Description", date: Date(), start: "09:00", end: "17:00", location: "Teststreet", link: "pixelskull.de")])
    }
}
