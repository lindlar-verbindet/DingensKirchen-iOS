//
//  LiMoView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI
import SwiftyJSON

struct LiMoView: View {
    
    private let apiURL = "https://vermittlungstool.dev.bergnet.de/input/app"
    
    @State var givenName: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var terms: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(named: "ic_limo")!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(20)
                textField("Ihr Vorname", binding: $givenName)
                textField("Ihr Nachname", binding: $name)
                textField("Ihre Telefon oder Mobilnummer", binding: $phone)
                textField("Ihre E-Mail-Adresse", binding: $email)
                
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
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitle("Lindlar Mobil")
    }
    
    private func sendForm() {
        var json = JSON()
        json["form"].string = "limo"
        json["name"].string = givenName
        json["nachname"].string = name
        json["fon"].string = phone
        json["mail"].string = email
        json["datenschutz"].boolValue = terms
        APIHelper.sendPOST(url: apiURL, json: json) { response in
            print(response)
        }
    }
}

struct LiMoView_Previews: PreviewProvider {
    static var previews: some View {
        LiMoView()
    }
}
