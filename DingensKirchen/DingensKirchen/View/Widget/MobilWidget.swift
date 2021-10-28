//
//  MobilWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct MobilWidget: View {
    
    let title: String = NSLocalizedString("widget_mobil_headline", comment: "")
    
    @State var desc: String = NSLocalizedString("Mit dem Öffentlichen Personennahverkehr unterwegs in Lindlar.", comment: "")
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Image(uiImage: UIImage(named: "ic_location")!)
                    .resizable()
                    .frame(width: 70, height: 100)
                    .padding(.trailing, 20)
                    .foregroundColor(.black)
                    .opacity(0.2)
            }
            VStack(alignment: .leading) {
                Text(title.uppercased())
                    .font(Font.system(size: 26, weight: .light))
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                Text(desc)
                    .font(Font.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
        }
        
        .smallWidget(background: .primaryHighlight)
        .padding(5)
    }
}

struct MobilWidget_Previews: PreviewProvider {
    static var previews: some View {
        MobilWidget()
    }
}
