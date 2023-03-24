//
//  VillageCellDoubleAction.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct VillageCellDoubleAction: View {
    
    @State var title: String
    @State var desc: String
    @State var btn1Title: String
    @State var tel: String?
    @State var btn2Title: String
    @State var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Font.system(size: 28, weight: .light))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
            Text(desc)
                .font(Font.system(size: 16, weight: .light))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
            HStack {
                Button(action: {
                    if let url = URL(string: "telprompt://\(tel!)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }, label: {
                    Text(btn1Title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .contentShape(RoundedRectangle(cornerRadius: 5))
                })
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.primaryTextColor)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 15, trailing: 5))
                Button(action: {}, label: {
                    if title == "Digitalbegleitung" {
                        NavigationLink(destination: DigitalView()) {
                            Text(btn2Title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .contentShape(RoundedRectangle(cornerRadius: 5))
                        }
                    } else if title == "Taschengeldbörse" {
                        NavigationLink(destination: PocketMoneyView()) {
                            Text(btn2Title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .contentShape(RoundedRectangle(cornerRadius: 5))
                        }
                    } else {
                        NavigationLink(destination: NeighbourView()) {
                            Text(btn2Title)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .contentShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                })
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, minHeight: 30)
                .background(Color.white)
                .cornerRadius(5)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 15))
            }
            .frame(maxWidth: .infinity)
        }
        .background(index % 2 == 0 ? Color.primaryHighlight : Color.secondaryHighlight)
        .cornerRadius(15)
    }
}

struct VillageCellDoubleAction_Previews: PreviewProvider {
    static var previews: some View {
        VillageCellDoubleAction(title: "title", desc: "foobar", btn1Title: "Anrufen", btn2Title: "Formular", index: 1)
    }
}
