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
    @State var end: String = ""
    @State var title: String
    @State var desc: String = ""
    @State var address: String = ""
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
                    Text(String(htmlEncodedString: title) ?? "")
                        .foregroundColor(.black)
                        .font(Font.system(size: 28, weight: .light))
                        .multilineTextAlignment(.leading)
                    if desc != "" {
                      Text(String(htmlEncodedString: desc)?.cutoffIfNeeded(maxChars: 180) ?? "")
                            .font(Font.system(size: 16, weight: .light))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            if address != "" {
                HStack {
                    Image(systemName: "signpost.right.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    Text(address)
                        .font(Font.system(size: 12))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            HStack {
                Image(systemName: "link")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.black)
                Text((URL(string: website)?.host)!)
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
        if (start == "" || start == "00:00") {
            return date
        } else if start != end {
            let startTime = start != "" ? " von: " + start + " " : ""
            let endTime = end != "" ? "bis: " + end : ""
            return date + startTime + endTime
        } else {
            let startTime = start != "" ? " ab: " + start : ""
            return date + startTime
        }
        
        
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(date: "01.01.1970", start: "19:00", end: "22:00", title: "test", desc: "testerino", address: "teststreet", website: "pixelskull.de", index: 0)
    }
}
