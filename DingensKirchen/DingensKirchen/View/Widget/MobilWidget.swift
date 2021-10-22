//
//  MobilWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 23.08.21.
//

import SwiftUI

struct MobilWidget: View {
    
    let title: String = "Mobil"
    
    @State var desc: String = "ÖPNV, Bürgerbus, LiMo, Carsharing Linde"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.uppercased())
                .font(Font.system(size: 26, weight: .light))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10))
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
