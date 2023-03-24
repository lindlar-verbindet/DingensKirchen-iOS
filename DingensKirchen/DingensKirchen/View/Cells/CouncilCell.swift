//
//  CouncilCell.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct CouncilCell: View {
    
    @State var title: String
    @State var desc: String
    @State var buttonTitle: String
    @State var targetLink: String
    @State var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.black)
                .font(Font.system(size: 22, weight: .light))
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            Text(desc)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
            .padding(5)
            Button(action: {}, label: {
                NavigationLink(destination: DKWebView(urlString: targetLink)) {
                    Text(buttonTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .contentShape(RoundedRectangle(cornerRadius: 5))
                }
            })
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, minHeight: 30)
            .background(Color.white)
            .cornerRadius(5)
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
        }
        .padding(5)
        .background(index % 2 == 0 ? Color.secondaryHighlight : Color.primaryHighlight)
        .cornerRadius(15)
    }
}

struct CouncilCell_Previews: PreviewProvider {
    static var previews: some View {
        CouncilCell(title: "test", desc: "desc", buttonTitle: "Jetzt online beantragen", targetLink: "https://google.com", index: 0)
    }
}
