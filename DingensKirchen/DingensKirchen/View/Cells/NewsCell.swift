//
//  NewsCell.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 07.09.21.
//

import SwiftUI

struct NewsCell: View {
    
    @State var index: Int
    @State var title: String
    @State var desc: String
    @State var date: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            Text(date)
                .font(Font.system(size: 10))
                .foregroundColor(.white)
                .fontWeight(.light)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(5)
        .background(index % 2 == 0 ? Color.primaryBackground : Color.primaryHighlight)
        .cornerRadius(15)
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(index: 0, title: "Heading", desc: "Description", date: "01.01.1970")
    }
}
