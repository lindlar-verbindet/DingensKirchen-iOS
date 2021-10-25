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
    @State var start: String
    @State var end: String
    @State var title: String
    @State var desc: String
    @State var address: String
    @State var website: String
    @State var index: Int
    
    init(imagePath: String = "",
         date: String,
         start: String,
         end: String,
         title: String,
         desc: String,
         address: String,
         website: String,
         index: Int) {
        self.imagePath = imagePath
        self.date = date
        self.start = start
        self.end = end
        self.title = title
        self.desc = desc
        self.address = address
        self.website = website
        self.index = index
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
                    Text(getEventDateString())
                        .font(Font.system(size: 12))
                        .foregroundColor(.black)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                    Text(title)
                        .foregroundColor(.black)
                        .font(Font.system(size: 22, weight: .light))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                    Text(desc)
                        .font(Font.system(size: 14))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
            }
            HStack {
                Image(systemName: "signpost.right.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.black)
                Text(address)
                    .font(Font.system(size: 12))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Image(systemName: "link")
                    .resizable()
                    .frame(width: 10, height: 10, alignment: .center)
                    .foregroundColor(.black)
                Text(website)
                    .font(Font.system(size: 12))
                    .foregroundColor(.black)
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(index % 2 == 0 ? Color.primaryHighlight : Color.secondaryHighlight)
        .cornerRadius(15)
    }
    
    private func getEventDateString() -> String {
        if start != end {
            let startTime = start != "" ? " Von: " + start + " " : ""
            let endTime = end != "" ? "Bis: " + end : ""
            return date + startTime + endTime
        } else {
            let startTime = start != "" ? " Ab: " + start : ""
            return date + startTime
        }
        
        
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(date: "01.01.1970", start: "19:00", end: "22:00", title: "test", desc: "testerino", address: "teststreet", website: "pixelskull.de", index: 0)
    }
}
