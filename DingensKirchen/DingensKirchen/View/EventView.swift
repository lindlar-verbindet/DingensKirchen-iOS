//
//  EventVIew.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct EventView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                Image("ic_event_head")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                EventCell(imagePath: "ic_event_head", date: "01.01.1970", title: "Test", desc: "Some Description of the event", address: "Teststreet 1", website: "diesite.de", item: 0)
                    .padding(5)
                EventCell(date: "01.01.1970", title: "Test", desc: "Some Description of the event", address: "Teststreet 1", website: "diesite.de", item: 1)
                    .padding(5)
            }
            Spacer()
        }
    }
}

struct EventVIew_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
