//
//  WebViewModel.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 10.02.22.
//

import SwiftUI

class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false

    init (link: String) {
        self.link = link
    }
}
