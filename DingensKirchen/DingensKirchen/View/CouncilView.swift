//
//  CouncilView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI
import SWXMLHash

struct CouncilView: View {
    @State var file = Bundle.main.url(forResource: "council_services", withExtension: "xml")
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("ic_council")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.primaryBackground)
                        .scaledToFill()
                }
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackground)
                    .padding(.top, -10)
                    .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 120)
                    CouncilCellTrash()
                        .padding(5)
                    ForEach(loadData(), id: \.self) { element in
                        CouncilCell(title: element.name,
                                    desc: element.desc,
                                    buttonTitle: element.btn,
                                    targetLink: element.link,
                                    index: element.index)
                    }
                    .padding(5)
                }
                Spacer()
            }
        }
        .navigationBarTitle("Rathaus", displayMode: .inline)
    }
    
    private func loadData() -> [CouncilService] {
        var result: [CouncilService] = [CouncilService]()
        if let file = file {
            if let data = try? Data(contentsOf: file, options: .alwaysMapped) {
                let xml = SWXMLHash.config { config in
                    config.encoding = .unicode
                }.parse(data)
                
                var i = 0
                for service in xml["council-services"].children {
                    let element = CouncilService(index: i,
                                                 name: service.element!.attribute(by: "name")?.text ?? "",
                                                 desc: service.element!.attribute(by: "desc")?.text ?? "",
                                                 link: service.element!.attribute(by: "link")?.text ?? "",
                                                 btn: service.element!.attribute(by: "btn")?.text ?? "")
                    i += 1
                    result.append(element)
                }
            }
        }
        return result
    }
}

struct CouncilView_Previews: PreviewProvider {
    static var previews: some View {
        CouncilView()
    }
}
