//
//  ContentView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                NewsWidget(date: "01.01.1970",
                           newsTitle: "Letzte Nachricht",
                           newsDesc: "Lorem Ipsum dolor sit amet, consetetur...")
                EventWidget(date: "01.01.1970",
                            eventTitle: "Beispieltermin",
                            eventDesc: "Kurzbeschreibung...")
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
