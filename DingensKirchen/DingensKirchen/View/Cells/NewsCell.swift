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
    @State var imageURL: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = imageURL {
                CustomImageView(urlString: url)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(-10)
            }
            Text(title)
                .font(Font.system(size: 22, weight: .light))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            Text(date)
                .font(Font.system(size: 10))
                .foregroundColor(.black)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(5)
        .background(index % 2 == 0 ? Color.primaryHighlight : Color.secondaryHighlight)
        .cornerRadius(15)
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(index: 0, title: "Heading", desc: "Description", date: "01.01.1970")
    }
}
