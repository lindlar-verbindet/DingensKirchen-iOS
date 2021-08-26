//
//  CouncilView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct CouncilView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                Image("ic_village_head")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFill()
                CouncilCellTrash()
                    .padding(5)
                CouncilCell(title: "Beantragung einer Meldebescheinigung", buttonTitle: "Jetzt online beantragen", index: 0)
                    .padding(5)
            }
            Spacer()
        }
    }
}

struct CouncilView_Previews: PreviewProvider {
    static var previews: some View {
        CouncilView()
    }
}
