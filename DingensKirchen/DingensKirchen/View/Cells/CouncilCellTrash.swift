//
//  CouncilCellTrash.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 26.08.21.
//

import SwiftUI

struct CouncilCellTrash: View {
    var body: some View {
        VStack {
            Image("ic_trash")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 120)
                .background(Color.primaryHighlight)
                .cornerRadius(5)
        }
            
    }
}

struct CouncilCellTrash_Previews: PreviewProvider {
    static var previews: some View {
        CouncilCellTrash()
    }
}
