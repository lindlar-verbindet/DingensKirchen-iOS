//
//  VillageBaseView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI

extension View {
    func textField(_ title: String,
                   hint: String? = nil,
                   contentType: UITextContentType? = nil,
                   keyboardType: UIKeyboardType = .default,
                   binding: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString(title, comment: ""))
            ZStack {
                if (binding.wrappedValue == "") {
                    Text(hint != nil ? hint! : "")
                        .foregroundColor(Color.tertiaryHighlight)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                TextField("", text: binding) //hint != nil ? hint! :
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textContentType(contentType != nil ? contentType : .none)
                    .keyboardType(keyboardType)
            }
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
