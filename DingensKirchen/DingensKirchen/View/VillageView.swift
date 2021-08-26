//
//  VillageView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI

struct VillageView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical) {
                Image("ic_village_head")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                VillageCellDoubleAction(title: "Nachbarschaftshilfe", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing", btn1Title: "Anrufen", btn2Title: "Formular", index: 0)
                    .padding(5)
                VillageCellSingleAction(title: "Suche&Finde", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing", btnTitle: "Öffnen", index: 1)
                    .padding(5)
                VillageCellDoubleAction(title: "Taschengeldbörse", desc: "Lorem ipsum dolor sit amet, consetetur sadipscing", btn1Title: "Anrufen", btn2Title: "Formular", index: 2)
                    .padding()
            }
            Spacer()
        }
    }
}

struct VillageView_Previews: PreviewProvider {
    static var previews: some View {
        VillageView()
    }
}
