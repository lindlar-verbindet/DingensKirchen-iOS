//
//  VillageCellSingleAction.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct VillageCellSingleAction: View {
    
    @State var title: String
    @State var desc: String
    @State var btnTitle: String
    @State var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(5)
            Text(desc)
                .font(Font.system(size: 14))
                .foregroundColor(.white)
                .padding(5)
            HStack {
                Button(btnTitle) {
                    
                }
                .foregroundColor(Color.primaryTextColor)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.white)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 15))
            }
            .frame(maxWidth: .infinity)
        }
        .background(index % 2 == 0 ? Color.primaryBackground : Color.primaryHighlight)
        .cornerRadius(15)
    }
}

struct VillageCellSingleAction_Previews: PreviewProvider {
    static var previews: some View {
        VillageCellSingleAction(title: "Test Title", desc: "Test Description", btnTitle: "Öffnen", index: 1)
    }
}
