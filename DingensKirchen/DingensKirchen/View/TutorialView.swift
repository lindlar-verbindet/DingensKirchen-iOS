//
//  TutorialView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 21.01.22.
//

import SwiftUI

struct TutorialView: View {
    
    
    @Binding var shown: Bool
    @State var index: Int = 0
    
    let closePadding = EdgeInsets(top: 10,
                                  leading: 0,
                                  bottom: 0,
                                  trailing: 40)
    let nextPadding = EdgeInsets(top: 0,
                                 leading: 0,
                                 bottom: 10,
                                 trailing: 40)
    let prevPadding = EdgeInsets(top: 0,
                                 leading: 40,
                                 bottom: 10,
                                 trailing: 0)
    
    var body: some View {
        ZStack(alignment: .center) {
            TabView(selection: $index) {
                Image("img_tutorial1")
                    .resizable()
                    .scaledToFit()
                    .tag(0)
                Image("img_tutorial2")
                    .resizable()
                    .scaledToFit()
                    .tag(1)
                Image("img_tutorial3")
                    .resizable()
                    .scaledToFit()
                    .tag(2)
                Image("img_tutorial3")
                    .resizable()
                    .scaledToFit()
                    .tag(3)
                Image("img_tutorial3")
                    .resizable()
                    .scaledToFit()
                    .tag(4)
                Image("img_tutorial3")
                    .resizable()
                    .scaledToFit()
                    .tag(5)
                Image("img_tutorial3")
                    .resizable()
                    .scaledToFit()
                    .tag(6)
            }
            .tabViewStyle(PageTabViewStyle())
            VStack(alignment: .trailing) {
                Button {
                    DispatchQueue.main.async {
                        self.shown.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.primaryHighlight)
                }
                .frame(width: 30, height: 30)
                .padding(closePadding)
                Spacer()
                HStack {
                    Button {
                        let newIndex = index - 1
                        withAnimation {
                            index = (newIndex >= 0) ? newIndex : 0
                        }
                        
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .foregroundColor(.primaryHighlight)
                    }
                    
                    .frame(width: 20, height: 30)
                    .padding(prevPadding)
                    Spacer()
                    Button {
                        let newIndex = index + 1
                        withAnimation {
                            index = (newIndex <= 6) ? newIndex : 6
                        }
                    } label: {
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .foregroundColor(.primaryHighlight)
                    }
                    .frame(width: 20, height: 30)
                    .padding(nextPadding)
                }
            }
        }
        .ignoresSafeArea()
        .padding()
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(shown: .constant(true))
    }
}
