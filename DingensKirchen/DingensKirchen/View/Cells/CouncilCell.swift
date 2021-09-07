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
                .foregroundColor(.white)
                .widgetText(isTitle: true)
                .padding(5)
            HStack {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.white)
                Text(desc)
                    .foregroundColor(.white)
            }
            .padding(5)
            Button(action: {}, label: {
                NavigationLink(destination: DKWebView(urlString: targetLink)) {
                    Text(buttonTitle)
                }
            })
            .foregroundColor(.primaryTextColor)
            .frame(maxWidth: .infinity, minHeight: 30)
            .background(Color.white)
            .cornerRadius(5)
            .padding(5)
        }
        .padding(5)
        .background(index % 2 == 0 ? Color.primaryBackground : Color.primaryHighlight)
        .cornerRadius(5)
    }
}

struct CouncilCell_Previews: PreviewProvider {
    static var previews: some View {
        CouncilCell(title: "test", desc: "desc", buttonTitle: "Jetzt online beantragen", targetLink: "https://google.com", index: 0)
    }
}
