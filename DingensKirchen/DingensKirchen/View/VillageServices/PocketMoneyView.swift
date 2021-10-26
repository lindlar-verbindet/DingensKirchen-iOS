//
//  PocketMoney.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI
import SwiftyJSON

struct PocketMoneyView: View {
    
    private let apiURL = "https://vermittlungstool.dev.bergnet.de/input/app"
    
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
    
        
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    textField("Ihr Vorname", binding: $givenName)
                    textField("Ihr Nachname", binding: $name)
                    textField("Ihre Anschrift", binding: $address)
                    textField("Ihre Telefon oder Mobilnummer", binding: $phone)
                    textField("Ihre E-Mail-Adresse", binding: $email)
                    textField("Ihr Geburtsdatum", binding: $birthDate)
                }
                Section {
                    Text("Bei welchem Themengebiet haben Sie Fragen/Wünschen Sie Unterstützung")
                    Picker(topic, selection: $topic) {
                        Text("Bedienung Smartphone").tag("Bedienung Smartphone")
                        Text("Bedienung Computer").tag("Bedienung Computer")
                        Text("Updates/Apps/Programme installieren").tag("Updates/Apps/Programme installieren")
                        Text("Videokonferenzen").tag("Videokonferenzen")
                        Text("Windows").tag("Windows")
                        Text("macOS").tag("macOS")
                        Text("Android - Smartphone").tag("Android - Smartphone")
                        Text("iOS - iPhone").tag("iOS - iPhone")
                        Text("Anderes Thema").tag("Anderes Thema")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.tertiaryHighlight)
                    .accentColor(.white)
                    .cornerRadius(5)
                }
                
                if topic == "Anderes Thema" {
                    textField("Nicht dabei? Wobei können wir helfen? ", binding: $moreInfo)
                }
                textField("Optionale Angaben zu Ihrer Anfrage", binding: $detailInfo)
                
                textField("Von", binding: $fromDate)
                textField("Bis", binding: $untilDate)
                
                Toggle(isOn: $terms, label: {
                    Text("Hiermit erkläre ich mich einverstanden, dass meine in das Formular eingegebenen Daten elektronisch gespeichert und zum Zweck der Kontaktaufnahme verarbeitet und genutzt werden. Mir ist bekannt, dass ich meine Einwilligung jederzeit wiederrufen kann.")
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            terms.toggle()
                        }
                })
                .toggleStyle(CheckboxStyle())
            }
            Button("Absenden") {
                sendForm()
            }
            .disabled(!terms)
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(5)
            .background(!terms ? Color.primaryBackground : Color.secondaryHighlight)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitle("Taschengeldbörse")
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
        
        APIHelper.sendPOST(url: apiURL, json: json) { response in
            print(response)
        }
    }
}

struct PocketMoney_Previews: PreviewProvider {
    static var previews: some View {
        PocketMoneyView()
    }
}
