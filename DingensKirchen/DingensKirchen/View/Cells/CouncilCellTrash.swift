//
//  CouncilCellTrash.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct CouncilCellTrash: View {
    
    let targetURLString = "https://abfallnavi.de/lindlar/"
    
    var body: some View {
        VStack {
            NavigationLink(destination: DKWebView(urlString: targetURLString, hideBackButtons: false)) {
                Image("ic_trash")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .scaledToFit()
                    .padding(15)
                    .background(Color.primaryHighlight)
                    .cornerRadius(15)
                    
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
            
    }
}

struct CouncilCellTrash_Previews: PreviewProvider {
    static var previews: some View {
        CouncilCellTrash()
    }
}
