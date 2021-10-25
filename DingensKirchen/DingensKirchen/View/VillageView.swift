//
//  VillageView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI
import SWXMLHash

struct VillageView: View {
    
    @State var file = Bundle.main.url(forResource: "village_services", withExtension: "xml")
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Image("ic_people")
                        .resizable()
                        .frame(width: 150, height: 100)
                        .foregroundColor(.primaryBackground)
                        .padding(.trailing, 10)
                        .scaledToFit()
                }
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.primaryBackground)
                    .padding(.top, -20)
                    .ignoresSafeArea()
            }
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 120)
                    ForEach(loadData(), id: \.self) { element in
                        if element.type == 1 {
                            VillageCellDoubleAction(title: element.name,
                                                    desc: element.desc,
                                                    btn1Title: element.callbtn,
                                                    tel: element.tel,
                                                    btn2Title: element.actionbtn,
                                                    index: element.index)
                        } else {
                            VillageCellSingleAction(title: element.name,
                                                    desc: element.desc,
                                                    btnTitle: element.actionbtn,
                                                    index: element.index)
                        }
                    }
                    .padding(5)
                }
                Spacer()
            }
        }
        .navigationBarTitle("Dorfleben", displayMode: .inline)
    }
    
    private func loadData() -> [VillageService] {
        var result: [VillageService] = [VillageService]()
        if let file = file {
            if let data = try? Data(contentsOf: file, options: .alwaysMapped) {
                let xml = SWXMLHash.config { config in
                    config.encoding = .unicode
                }.parse(data)
                
                var i = 0
                for service in xml["village-services"].children {
                    let element = VillageService(index: i,
                                                 type: Int(service.element!.attribute(by: "type")?.text ?? "") ?? 0,
                                                 name: service.element!.attribute(by: "title")?.text ?? "",
                                                 desc: service.element!.attribute(by: "desc")?.text ?? "",
                                                 tel: service.element!.attribute(by: "tel")?.text ?? "",
                                                 callbtn: service.element!.attribute(by: "telbtn")?.text ?? "",
                                                 link: service.element!.attribute(by: "action")?.text ?? "",
                                                 actionbtn: service.element!.attribute(by: "actionbtn")?.text ?? "")
                    i += 1
                    result.append(element)
                }
            }
        }
        return result
    }
}

struct VillageView_Previews: PreviewProvider {
    static var previews: some View {
        VillageView()
    }
}
