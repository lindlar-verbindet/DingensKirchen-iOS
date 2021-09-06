//
//  EventVIew.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct EventView: View {
    
    @State var events: [WPEvent] = [WPEvent]()
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                Image("ic_event_head")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                ForEach(events, id: \.self) { event in
                    EventCell(date: event.dateString,
                              title: event.title,
                              desc: event.htmlFreeDesc,
                              address: event.location,
                              website: event.link,
                              item: event.index)
                        .padding(5)
                }
            }
            Spacer()
        }
        .navigationBarTitle("Veranstaltungen&Termine", displayMode: .inline)
        .onAppear {
            getEvents()
        }
    }
    
    private func getEvents() {
        WPEventHelper.getEvents { events in
            self.events = events
        }
    }
}

struct EventVIew_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
