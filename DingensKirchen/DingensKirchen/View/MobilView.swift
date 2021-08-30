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
    var body: some View {
        MapboxMap()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Mobil", displayMode: .inline)
    }
}

struct MobilView_Previews: PreviewProvider {
    static var previews: some View {
        MobilView()
    }
}
