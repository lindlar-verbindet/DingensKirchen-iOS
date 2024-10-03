//
//  EventViewModel.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 01.02.22.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var response: [Event]?
    
    func loadEvents() {
        WPEventHelper.getEvents { self.handleResponse(events: $0) }
        LindlarEventHelper.getEvents { self.handleResponse(events: $0) }
    }
    
    private func handleResponse(events: [Event]) {
        let temp = (self.response ?? []) + events
        self.response = temp.sorted { $0.date < $1.date }
        if let responseCount = self.response?.count {
            for i in 0...(responseCount-1) {
                self.response?[i].index = i
            }
        }
    }
}
