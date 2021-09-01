//
//  MobilView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI
import MapboxMaps

struct MapboxMap: UIViewControllerRepresentable {
        
    typealias UIViewControllerType = MapViewController
    var parent: MobilView
    
    init(parent: MobilView) {
        self.parent = parent
    }
    
    func makeUIViewController(context: Context) -> MapViewController {
        let viewController = MapViewController()
        viewController.mobilView = self.parent
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
    
}

struct MobilView: View {
    
    @State private var bottomSheetShown = false
    @State var contextTitle: String = ""
    @State var contextDesc: String = ""
    
    var body: some View {
        ZStack {
            MapboxMap(parent: self)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Mobil", displayMode: .inline)
            MapBottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 400) {
                VStack(alignment: .leading) {
                    Text(contextTitle)
                        .font(.title)
                        .padding(5)
                    Text(contextDesc)
                        .font(.callout)
                        .padding(5)
                    Spacer()
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct MobilView_Previews: PreviewProvider {
    static var previews: some View {
        MobilView()
    }
}
