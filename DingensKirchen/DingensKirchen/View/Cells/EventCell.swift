//
//  EventCell.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct EventCell: View {
    
    @State var imagePath: String = ""
    @State var date: String
    @State var title: String
    @State var description: String
    @State var address: String
    @State var website: String
    @State var itemNumber: Int
    
    init(imagePath: String = "", date: String, title: String, desc: String, address: String, website: String, item: Int) {
        self.imagePath = imagePath
        self.date = date
        self.title = title
        self.description = desc
        self.address = address
        self.website = website
        self.itemNumber = item 
        
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if imagePath != ""{
                    Image(imagePath)
                        .resizable()
                        .frame(width: 120, height: 100)
                        .scaledToFit()
                }
                VStack(alignment: .leading) {
                    Text(date)
                    Text(title)
                    Text("DESC")
                }
            }
            HStack {
                Image(systemName: "signpost.right.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
                Text(address)
                Spacer()
            }
            HStack {
                Image(systemName: "link")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(.white)
                Text(website)
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(5)
        .background(itemNumber % 2 == 0 ? Color.primaryBackground : Color.primaryHighlight)
        .cornerRadius(5)
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(date: "01.01.1970", title: "test", desc: "testerino", address: "teststreet", website: "pixelskull.de", item: 0)
    }
}
