//
//  LiMoView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI
import SwiftyJSON
import Focuser

fileprivate enum FormFields: FocusStateCompliant {
    case givenname, name, date, time, destination, phone, email
    
    static var last: FormFields {
        .email
    }
    
    var next: FormFields? {
        switch self {
        case .givenname:
            return .name
        case .name:
            return .date
        case .date:
            return .time
        case .time:
            return .destination
        case .destination:
            return .phone
        case .phone:
            return .email
        default: return nil
        }
    }
}

struct LiMoView: View {
    
    private let apiURL = NSLocalizedString("api_tool_url", comment: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    @FocusStateLegacy fileprivate var focusedField: FormFields?
    
    @State var givenName: String = ""
    @State var name: String = ""
    @State var date: String = ""
    @State var time: String = ""
    @State var destination: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var terms: Bool = false
    
    @State var nameHint: Bool = false
    @State var phoneHint: Bool = false
    
    @State var requestSuccess: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .trailing) {
                    Image("ic_limo")
                        .resizable()
                        .frame(width: 180, height: 80)
                    Image("img_limo")
                        .resizable()
                        .scaledToFit()
                }
                Text("limo_desc")
                    .font(Font.system(size: 16, weight: .light))
                    .padding(.bottom, 10)
                
                Rectangle()
                    .foregroundColor(.primaryHighlight)
                    .frame(maxWidth: .infinity, maxHeight: 4)
                    .padding(.bottom, 20)
                VStack {
                    textField("form_givenname", contentType: .givenName, binding: $givenName)
                        .focusedLegacy($focusedField, equals: .givenname)
                    textField("form_familyname",
                              hint: nameHint ? NSLocalizedString("form_mandatory_hint", comment: "") : nil,
                              contentType: .familyName,
                              binding: $name)
                        .focusedLegacy($focusedField, equals: .name)
                    textField("form_date", binding: $date)
                        .focusedLegacy($focusedField, equals: .date)
                    textField("form_time", binding: $time)
                        .focusedLegacy($focusedField, equals: .time)
                    textField("form_destination", binding: $destination)
                        .focusedLegacy($focusedField, equals: .destination)
                    textField("form_phone",
                              hint: phoneHint ? NSLocalizedString("form_mandatory_hint", comment: "") : nil,
                              contentType: .telephoneNumber,
                              binding: $phone)
                        .focusedLegacy($focusedField, equals: .phone)
                    textField("form_mail", contentType: .emailAddress, keyboardType: .emailAddress, binding: $email)
                        .focusedLegacy($focusedField, equals: .email)
                }
                
                Toggle(isOn: $terms, label: {
                    Text("form_datapolicy")
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            terms.toggle()
                            focusedField = nil
                        }
                })
                .toggleStyle(CheckboxStyle())
                
                Button("form_button", action: {
                    sendForm()
                })
                .disabled(!terms)
                .frame(maxWidth: .infinity, minHeight: 40)
                .padding(5)
                .background(!terms ? Color.primaryBackground : Color.secondaryHighlight)
                .foregroundColor(terms ? Color.black : Color.white)
                .cornerRadius(5)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(getAlertTitle(requestSuccess)),
                      message: Text(getAlertText(requestSuccess)),
                      dismissButton: .default(Text("form_alert_button"), action: {
                    if requestSuccess {
                        presentationMode.wrappedValue.dismiss()
                    }
                }))
            }
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitle("limo_navigation_title")
    }
    
    private func sendForm() {
        if !checkFields() { return }
        
        var json = JSON()
        json["form"].string = "limo"
        json["name"].string = givenName
        json["nachname"].string = name
        json["datum"].string = date
        json["uhr"].string = time
        json["ziel"].string = destination
        json["fon"].string = phone
        json["mail"].string = email
        json["datenschutz"].boolValue = terms
        
        APIHelper.sendPOST(url: apiURL, json: json) { success, response in
            requestSuccess = success
            showAlert.toggle()
        }
    }
    
    private func checkFields() -> Bool {
        var ok = true
        if givenName == "" {
            nameHint = true
            ok = false
        }
        if phone == "" {
            phoneHint = true
            ok = false
        }
        return ok
    }
}

struct LiMoView_Previews: PreviewProvider {
    static var previews: some View {
        LiMoView()
    }
}
