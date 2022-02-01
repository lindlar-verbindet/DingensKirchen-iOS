//
//  DigitalView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 07.09.21.
//

import SwiftUI
import SwiftyJSON
import Focuser

fileprivate enum FormFields: FocusStateCompliant {
    case givenname, name, address, phone, email, detail
    
    static var last: FormFields {
        .detail
    }
    
    var next: FormFields? {
        switch self {
        case .givenname:
            return .name
        case .name:
            return .address
        case .address:
            return .phone
        case .phone:
            return .email
        case .email:
            return .detail
        default: return nil
        }
    }
}

struct DigitalView: View {
    
    private let apiURL = NSLocalizedString("api_tool_url", comment: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    @FocusStateLegacy fileprivate var focusedField: FormFields?
    
    @State var givenName: String    = ""
    @State var name: String         = ""
    @State var address: String      = ""
    @State var district: String     = ""
    @State var phone: String        = ""
    @State var email: String        = ""
    @State var topic: String        = "Auswählen"
    @State var moreInfo: String     = ""
    @State var detailInfo: String   = ""
    @State var meeting: Bool        = false
    @State var terms: Bool          = false
    
    @State var requestSuccess: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    VStack(alignment: .trailing) {
                        Image("ic_digital")
                            .resizable()
                            .frame(width: 200, height: 60)
                        Image("img_digital")
                            .resizable()
                            .scaledToFit()
                    }
                    Text("digital_desc")
                        .font(Font.system(size: 16, weight: .light))
                        .padding(.bottom, 10)
                    
                    Rectangle()
                        .foregroundColor(.primaryHighlight)
                        .frame(maxWidth: .infinity, maxHeight: 4)
                        .padding(.bottom, 20)
                    
                    textField("form_givenname", contentType: .givenName, binding: $givenName)
                        .focusedLegacy($focusedField, equals: .givenname)
                    textField("form_familyname", contentType: .familyName, binding: $name)
                        .focusedLegacy($focusedField, equals: .name)
                    textField("form_address", contentType: .streetAddressLine1, binding: $address)
                        .focusedLegacy($focusedField, equals: .address)
                    Picker(topic, selection: $district) {
                        Text("form_district_spinner1")
                            .tag(NSLocalizedString("form_district_spinner1",
                                                   comment: ""))
                        Text("form_district_spinner2")
                            .tag(NSLocalizedString("form_district_spinner2",
                                                   comment: ""))
                        Text("form_district_spinner3")
                            .tag(NSLocalizedString("form_district_spinner3",
                                                   comment: ""))
                        Text("form_district_spinner4")
                            .tag(NSLocalizedString("form_district_spinner4",
                                                   comment: ""))
                        Text("form_district_spinner5")
                            .tag(NSLocalizedString("form_district_spinner5",
                                                   comment: ""))
                        Text("form_district_spinner6")
                            .tag(NSLocalizedString("form_district_spinner6",
                                                   comment: ""))
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.primaryHighlight)
                    .cornerRadius(5)
                    .onTapGesture {
                        focusedField = nil
                    }
                    textField("form_phone", contentType: .telephoneNumber, binding: $phone)
                        .focusedLegacy($focusedField, equals: .phone)
                    textField("form_mail", contentType: .emailAddress, keyboardType: .emailAddress, binding: $email)
                        .focusedLegacy($focusedField, equals: .email)
                }
                Section {
                    Text("Bei welchem Themengebiet haben Sie Fragen/Wünschen Sie Unterstützung")
                    Picker(topic, selection: $topic) {
                        Text("digital_form_spinner_1")
                            .tag(NSLocalizedString("digital_form_spinner_1",
                                                   comment: ""))
                        Text("digital_form_spinner_2")
                            .tag(NSLocalizedString("digital_form_spinner_2",
                                                   comment: ""))
                        Text("digital_form_spinner_3")
                            .tag(NSLocalizedString("digital_form_spinner_3",
                                                   comment: ""))
                        Text("digital_form_spinner_4")
                            .tag(NSLocalizedString("digital_form_spinner_4",
                                                   comment: ""))
                        Text("digital_form_spinner_5")
                            .tag(NSLocalizedString("digital_form_spinner_5",
                                                   comment: ""))
                        Text("digital_form_spinner_6")
                            .tag(NSLocalizedString("digital_form_spinner_6",
                                                   comment: ""))
                        Text("digital_form_spinner_7")
                            .tag(NSLocalizedString("digital_form_spinner_7",
                                                   comment: ""))
                        Text("digital_form_spinner_8")
                            .tag(NSLocalizedString("digital_form_spinner_8",
                                                   comment: ""))
                        Text("digital_form_spinner_9")
                            .tag(NSLocalizedString("digital_form_spinner_9",
                                                   comment: ""))
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.primaryHighlight)
                    .cornerRadius(5)
                    .onTapGesture {
                        focusedField = nil
                    }
                }
                
                if topic == NSLocalizedString("digital_form_spinner_9",
                                              comment: "") {
                    textField("form_detail", binding: $moreInfo)
                }
                textField("form_more", binding: $detailInfo)
                    .focusedLegacy($focusedField, equals: .detail)
                
                Toggle(isOn: $meeting, label: {
                    Text("form_location")
                        .onTapGesture {
                            meeting.toggle()
                        }
                })
                .toggleStyle(CheckboxStyle())
                
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
            Button("form_button", action: {
                sendForm()
            })
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
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
        .navigationBarTitle("digital_navigation_title")
    }
    
    private func sendForm() {
        var json = JSON()
        json["form"].string = "digital"
        json["name"].string = givenName
        json["nachname"].string = name
        json["strasse"].string = address
        json["kdorf"].string = district
        json["fon"].string = phone
        json["mail"].string = email
        json["aufgabe"].string = topic
        json["aufgabe_beschreibung"].string = moreInfo
        json["freitext"].string = detailInfo
        json["vorort"].boolValue = meeting
        json["datenschutz"].boolValue = terms
        
        APIHelper.sendPOST(url: apiURL, json: json) { (success, response) in
            requestSuccess = success
            showAlert.toggle()
        }
    }
}

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
 
            configuration.label
 
            Spacer()
 
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .foregroundColor(.primaryHighlight)
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .purple : .gray)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
 
    }
}

struct DigitalView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalView()
    }
}
