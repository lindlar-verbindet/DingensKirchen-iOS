//
//  CouncilWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct CouncilWidget: View {
    
    let title: String = NSLocalizedString("widget_council_headline",
                                          comment: "")
    @State var desc: String = NSLocalizedString("widget_council_teaser",
                                                comment: "")
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(uiImage: UIImage(named: "ic_council")!)
                    .resizable()
                    .frame(width: 100, height: 100)
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
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .smallWidget(background: .secondaryHighlight)
        .padding(5)
    }
}

struct CouncilWidget_Previews: PreviewProvider {
    static var previews: some View {
        CouncilWidget()
    }
}
