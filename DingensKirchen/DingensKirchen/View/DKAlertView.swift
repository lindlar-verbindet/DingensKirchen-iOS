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
            Button {
                shown = false
            } label: {
                Text("tipp_button")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .contentShape(RoundedRectangle(cornerRadius: 5))
            }
            .frame(width: screen.width - 100, height: 40)
            .background(Color.primaryHighlight)
            .foregroundColor(Color.black)
            .cornerRadius(5)
            .padding(.bottom, 30)
        }
        .frame(width: screen.width - 50, height: 340, alignment: .topLeading)
        .background(Color.white)
    }
}

struct DKAlertView_Previews: PreviewProvider {
    static var previews: some View {
        DKAlertView(shown: .constant(false), title: "test", content: "Qui aliqua ullamco anim labore officia sint quis minim id velit amet consectetur cupidatat quis qui adipisicing dolore ex aute fugiat enim minim elit cillum irure nostrud Lorem Lorem consequat ex irure in sint sunt aute aliquip in aliqua exercitation consectetur consequat nostrud dolore aute aliqua nulla eiusmod in ad eu deserunt commodo ullamco sunt ea aliquip incididunt ea officia veniam velit cupidatat laboris veniam in do cillum Lorem adipisicing in elit deserunt dolore mollit labore ipsum in occaecat pariatur irure velit nostrud aute eiusmod elit ex nulla duis irure sunt fugiat tempor est non in consectetur et proident sint.")
    }
}
