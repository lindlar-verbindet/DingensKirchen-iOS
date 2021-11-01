//
//  PocketMoney.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI
import SwiftyJSON

struct PocketMoneyView: View {
    
    private let apiURL = NSLocalizedString("api_tool_url", comment: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var givenName: String    = ""
    @State var name: String         = ""
    @State var address: String      = ""
    @State var phone: String        = ""
    @State var email: String        = ""
    @State var birthDate: String    = ""
    @State var topic: String        = ""
    @State var moreInfo: String     = ""
    @State var detailInfo: String   = ""
    @State var fromDate: String     = ""
    @State var untilDate: String    = ""
    @State var terms: Bool          = false
    
    @State var requestSuccess: Bool = false
    @State var showAlert: Bool = false
  
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Image("img_pocket_money")
                        .resizable()
                        .scaledToFit()
                    Text("pocket_money_desc")
                        .font(Font.system(size: 16, weight: .light))
                        .padding(.bottom, 10)
                    
                    Rectangle()
                        .foregroundColor(.primaryHighlight)
                        .frame(maxWidth: .infinity, maxHeight: 4)
                        .padding(.bottom, 20)
                    
                    textField("form_givenname", binding: $givenName)
                    textField("form_familyname", binding: $name)
                    textField("form_address", binding: $address)
                    textField("form_phone", binding: $phone)
                    textField("form_mail", binding: $email)
                    textField("form_birthdate", hint: "01.01.2021", binding: $birthDate)
                }
                Section {
                    Text("form_topic")
                    Picker(topic, selection: $topic) {
                        Text("pocket_money_form_spinner_1")
                            .tag(NSLocalizedString("pocket_money_form_spinner_1",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_2")
                            .tag(NSLocalizedString("pocket_money_form_spinner_2",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_3")
                            .tag(NSLocalizedString("pocket_money_form_spinner_3",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_4")
                            .tag(NSLocalizedString("pocket_money_form_spinner_4",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_5")
                            .tag(NSLocalizedString("pocket_money_form_spinner_5",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_6")
                            .tag(NSLocalizedString("pocket_money_form_spinner_6",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_7")
                            .tag(NSLocalizedString("pocket_money_form_spinner_7",
                                                   comment: ""))
                        Text("pocket_money_form_spinner_8")
                            .tag(NSLocalizedString("pocket_money_form_spinner_8",
                                                   comment: ""))
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.primaryHighlight)
                    .accentColor(.black)
                    .cornerRadius(5)
                }
                
                if topic == NSLocalizedString("pocket_money_form_spinner_8",
                                              comment: "") {
                    textField("form_detail", binding: $moreInfo)
                }
                textField("form_more", binding: $detailInfo)
                
                Text("form_time_headline")
                textField("form_time_from", hint: "01.01.2021", binding: $fromDate)
                textField("form_time_until", hint: "02.01.2021", binding: $untilDate)
                
                Toggle(isOn: $terms, label: {
                    Text("form_datapolicy")
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            terms.toggle()
                        }
                })
                .toggleStyle(CheckboxStyle())
            }
            Button("form_button") {
                sendForm()
            }
            .disabled(!terms)
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(5)
            .background(!terms ? Color.primaryBackground : Color.secondaryHighlight)
            .foregroundColor(terms ? .black : .white)
            .cornerRadius(5)
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
        .navigationBarTitle("pocket_money_navigation_title")
    }
    
    private func sendForm() {
        var json = JSON()
        json["form"].string = "taschengeld"
        json["name"].string = givenName
        json["nachname"].string = name
        json["strasse"].string = address
        json["plz"].string = "51789"
        json["ort"].string = "Lindlar"
        json["fon"].string = phone
        json["mail"].string = email
        json["geburtstag"].string = birthDate
        json["aufgabe"].string = topic
        json["aufgabe_beschreibung"].string = moreInfo
        json["freitext"].string = detailInfo
        json["zeit_start"].string = fromDate
        json["zeit_ende"].string = untilDate
        json["datenschutz"].boolValue = terms
        
        APIHelper.sendPOST(url: apiURL, json: json) { (success, response) in
            requestSuccess = success
            showAlert.toggle()
        }
    }
}

struct PocketMoney_Previews: PreviewProvider {
    static var previews: some View {
        PocketMoneyView()
    }
}
