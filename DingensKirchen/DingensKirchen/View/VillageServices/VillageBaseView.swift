//
//  VillageBaseView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI

extension View {
    func textField(_ title: String, binding: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField("", text: binding)
            Divider()
        }
    }
}
