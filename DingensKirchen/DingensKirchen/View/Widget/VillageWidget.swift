//
//  VillageWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct VillageWidget: View {
    
    let title: String = NSLocalizedString("widget_village_headline", comment: "")
    @State var desc: String = NSLocalizedString("widget_village_teaser",
                                                comment: "")
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(uiImage: UIImage(named: "ic_people")!)
                    .resizable()
                    .frame(width: 130, height: 100)
                    .padding(.trailing, 20)
                    .foregroundColor(.black)
                    .opacity(0.2)
            }
            VStack(alignment: .leading) {
                Text(title.uppercased())
                    .font(Font.system(size: 26, weight: .light))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                Text(desc)
                    .font(Font.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .widget(background: .secondaryHighlight)
        .padding(5)
    }
}

struct VillageWidget_Previews: PreviewProvider {
    static var previews: some View {
        VillageWidget()
    }
}
