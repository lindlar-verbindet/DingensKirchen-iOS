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
    
    func makeUIViewController(context: Context) -> MapViewController {
        MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
    
}

struct MobilView: View {
    
    @State private var bottomSheetShown = false
    
    var body: some View {
        ZStack {
            MapboxMap()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Mobil", displayMode: .inline)
            MapBottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: 400) {
                VStack(alignment: .leading) {
                    Text("Heading")
                        .font(.title)
                        .padding(5)
                    Text("Description")
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
