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
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                Image("ic_event_head")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
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
        .navigationBarTitle("Veranstaltungen&Termine", displayMode: .inline)
    }
}

struct EventVIew_Previews: PreviewProvider {
    static var previews: some View {
        EventView(events: [WPEvent(index: 0, title: "heading", desc: "Description", date: Date(), start: "09:00", end: "17:00", location: "Teststreet", link: "pixelskull.de")])
    }
}
