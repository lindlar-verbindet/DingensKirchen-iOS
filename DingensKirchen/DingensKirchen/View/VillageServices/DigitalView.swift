//
//  DigitalView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 07.09.21.
//

import SwiftUI
import SwiftyJSON

struct DigitalView: View {
    
    private let apiURL = "https://vermittlungstool.dev.bergnet.de/input/app"
    
    @State var givenName: String = ""
    @State var name: String = ""
    @State var address: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var topic: String = "Auswählen"
    @State var moreInfo: String = ""
    @State var detailInfo: String = ""
    @State var meeting: Bool = false
    @State var terms: Bool = false
    
    fileprivate func textField(_ title: String, binding: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField("", text: binding)
            Divider()
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Image("ic_digital")
                        .resizable()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .scaledToFit()
                    
                    textField("Ihr Vorname", binding: $givenName)
                    textField("Ihr Nachname", binding: $name)
                    textField("Ihre Anschrift", binding: $address)
                    textField("Ihre Telefon oder Mobilnummer", binding: $phone)
                    textField("Ihre E-Mail-Adresse", binding: $email)
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
                    .accentColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(5)
                    .background(Color.tertiaryHighlight)
                    .cornerRadius(5)
                }
                
                if topic == "Anderes Thema" {
                    textField("Nicht dabei? Wobei können wir helfen?", binding: $moreInfo)
                }
                textField("Erzählen Sie uns ein bisschen mehr zum Thema. So können wir den richtigen Experten für Sie finden.", binding: $detailInfo)
                
                Toggle(isOn: $meeting, label: {
                    Text("Ist ein Vorort-Termin erwünscht?")
                        .onTapGesture {
                            meeting.toggle()
                        }
                })
                .toggleStyle(CheckboxStyle())
                
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
            Button("Absenden", action: {
                sendForm()
            })
            .disabled(!terms)
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(5)
            .background(!terms ? Color.primaryBackground : Color.secondaryHighlight)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
        .navigationBarTitle("Digitalbegleitung")
    }
    
    private func sendForm() {
        var json = JSON()
        json["form"].string = "digital"
        json["name"].string = givenName
        json["nachname"].string = name
        json["strasse"].string = address
        json["plz"].string = "51789"
        json["ort"].string = "Lindlar"
        json["fon"].string = phone
        json["mail"].string = email
        json["aufgabe"].string = topic
        json["aufgabe_beschreibung"].string = moreInfo
        json["freitext"].string = detailInfo
        json["vorort"].boolValue = meeting
        json["datenschutz"].boolValue = terms
        
        APIHelper.sendPOST(url: apiURL, json: json) { response in
            print(response)
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
