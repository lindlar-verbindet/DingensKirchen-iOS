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
            
            Text(date)
                .font(Font.system(size: 10))
                .foregroundColor(.white)
                .fontWeight(.light)
                
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.white)
            
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
