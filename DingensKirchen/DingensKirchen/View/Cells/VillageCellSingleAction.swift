//
//  VillageCellSingleAction.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct VillageCellSingleAction: View {
    
    @State var title: String
    @State var desc: String
    @State var btnTitle: String
    @State var index: Int
    @State var url: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Font.system(size: 22, weight: .light))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
            HStack {
                NavigationLink(destination: DKWebView(urlString: url), label: {
//                    Button(btnTitle) {}
                    Text(btnTitle)
                })
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.white)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
            }
            .frame(maxWidth: .infinity)
        }
        .background(index % 2 == 0 ? Color.primaryHighlight : Color.secondaryHighlight)
        .cornerRadius(15)
    }
}

struct VillageCellSingleAction_Previews: PreviewProvider {
    static var previews: some View {
        VillageCellSingleAction(title: "Test Title", desc: "Test Description", btnTitle: "Öffnen", index: 1, url: "https://google.com")
    }
}
