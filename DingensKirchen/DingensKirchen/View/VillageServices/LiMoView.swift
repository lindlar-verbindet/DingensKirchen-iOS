//
//  LiMoView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.10.21.
//

import SwiftUI
import SwiftyJSON

struct LiMoView: View {
    
    private let apiURL = NSLocalizedString("api_tool_url", comment: "")
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var givenName: String = ""
    @State var name: String = ""
    @State var phone: String = ""
    @State var email: String = ""
    @State var terms: Bool = false
    
    @State var requestSuccess: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .trailing) {
                    Image("ic_limo")
                        .resizable()
                        .frame(width: 150, height: 80)
                        .scaledToFit()
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
                textField("form_givenname", binding: $givenName)
                textField("form_familyname", binding: $name)
                textField("form_phone", binding: $phone)
                textField("form_mail", binding: $email)
                
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
                      dismissButton: .default(Text("OK"), action: {
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
        var json = JSON()
        json["form"].string = "limo"
        json["name"].string = givenName
        json["nachname"].string = name
        json["fon"].string = phone
        json["mail"].string = email
        json["datenschutz"].boolValue = terms
        
        APIHelper.sendPOST(url: apiURL, json: json) { success, response in
            requestSuccess = success
            showAlert.toggle()
        }
    }
}

struct LiMoView_Previews: PreviewProvider {
    static var previews: some View {
        LiMoView()
    }
}
