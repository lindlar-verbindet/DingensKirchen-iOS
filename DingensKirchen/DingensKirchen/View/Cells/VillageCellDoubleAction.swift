//
//  VillageCellDoubleAction.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct VillageCellDoubleAction: View {
    
    @State var title: String
    @State var desc: String
    @State var btn1Title: String
    @State var tel: String?
    @State var btn2Title: String
    @State var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
            HStack {
                Button(btn1Title) {
                    if let url = URL(string: "telprompt://\(tel!)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.primaryTextColor)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 5))
                Button(action: {}, label: {
                    NavigationLink(destination: DigitalView()) {
                        Text(btn2Title)
                    }
                })
                .foregroundColor(.primaryTextColor)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.white)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 15))
            }
            .frame(maxWidth: .infinity)
        }
        .background(index % 2 == 0 ? Color.primaryBackground : Color.primaryHighlight)
        .cornerRadius(15)
    }
}

struct VillageCellDoubleAction_Previews: PreviewProvider {
    static var previews: some View {
        VillageCellDoubleAction(title: "title", desc: "foobar", btn1Title: "Anrufen", btn2Title: "Formular", index: 1)
    }
}
