//
//  VillageBaseView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI

extension View {
    func textField(_ title: String, hint: String? = nil,  binding: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString(title, comment: ""))
            TextField(hint != nil ? hint! : "", text: binding)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Divider()
        }
    }
    
    func getAlertTitle(_ requestSuccess: Bool) -> String {
        return requestSuccess ? "Geschafft" : "Fehler"
    }
    
    func getAlertText(_ requestSuccess: Bool) -> String {
        return requestSuccess ?
        "Deine Angaben wurden an Lindlar verbindet e.V. übermittelt." :
        "Bitte überprüfe deine Angaben und versuche es nochmal"
    }
}
