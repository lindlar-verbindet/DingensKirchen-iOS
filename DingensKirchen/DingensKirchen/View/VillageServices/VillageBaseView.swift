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
        return requestSuccess ? NSLocalizedString("form_alert_success_title", comment: "") :
                                NSLocalizedString("form_alert_failure_title", comment: "")
    }
    
    func getAlertText(_ requestSuccess: Bool) -> String {
        return requestSuccess ? NSLocalizedString("form_alert_success_text", comment: "") :
                                NSLocalizedString("form_alert_failure_text", comment: "")
        
    }
}
