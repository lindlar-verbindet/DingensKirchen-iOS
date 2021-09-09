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
                .padding(5)
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .padding(5)
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
                .padding(5)
                Button(action: {}, label: {
                    NavigationLink(destination: DigitalView()) {
                        Text(btn2Title)
                    }
                })
                .foregroundColor(.primaryTextColor)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.white)
                .cornerRadius(5)
                .padding(5)
            }
            .frame(maxWidth: .infinity)
        }
        .background(index % 2 == 0 ? Color.primaryBackground : Color.primaryHighlight)
        .cornerRadius(5)
    }
}

struct VillageCellDoubleAction_Previews: PreviewProvider {
    static var previews: some View {
        VillageCellDoubleAction(title: "title", desc: "foobar", btn1Title: "Anrufen", btn2Title: "Formular", index: 1)
    }
}
