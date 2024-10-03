//
//  SurveyWidget.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier.
//

import SwiftUI

struct ActionsWidget: View {
    
    @State var title: String
    @State var desc: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image(uiImage: UIImage(named: "ic_actions")!)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                        .opacity(0.2)
                }
                VStack(alignment: .leading) {
                    Text(title.uppercased())
                        .font(Font.system(size: 26, weight: .light))
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    Text(desc)
                        .font(Font.system(size: 16, weight: .light))
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .widget(background: .secondaryHighlight)
        .padding(5)
    }
}

struct ActionsWidget_Previews: PreviewProvider {
    static var previews: some View {
        SurveyWidget(title: "UMFRAGE", desc: "Was soll mit der App geschehen?")
    }
}
