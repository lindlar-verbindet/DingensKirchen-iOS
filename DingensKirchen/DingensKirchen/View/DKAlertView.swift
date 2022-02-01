//
//  DKAlertView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 25.10.21.
//

import SwiftUI

struct DKAlertView: View {
    
    @Binding var shown: Bool
    
    @State var title: String
    @State var content: String
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: UIImage(named: "ic_bulb")!)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .background(Color.white)
                .clipShape(Circle())
                .padding(.top, -50)
            Text("tipp_headline")
                .font(Font.system(size: 26, weight: .light))
                .foregroundColor(Color.tertiaryHighlight)
                .bold()
            Text(title)
                .font(Font.system(size: 18, weight: .light))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text(content)
                .font(Font.system(size: 16, weight: .light))
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Spacer()
            Button("tipp_button") {
                shown = false
            }
            .frame(width: screen.width - 100, height: 40)
            .background(Color.primaryHighlight)
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .padding(.bottom, 30)
        }
        .frame(width: screen.width - 50, height: 300)
        .background(Color.white)
//        .cornerRadius(15)
    }
}

struct DKAlertView_Previews: PreviewProvider {
    static var previews: some View {
        DKAlertView(shown: .constant(false), title: "test", content: "some lorem ipsum")
    }
}
