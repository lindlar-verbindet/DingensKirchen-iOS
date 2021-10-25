//
//  MobilView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 24.08.21.
//

import SwiftUI
import WebKit
import MapboxMaps

struct AttributedText: UIViewRepresentable {
    
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.allowsEditingTextAttributes = false
                
        textView.isEditable = false
        textView.isSelectable = true
        textView.textAlignment = .natural
        textView.dataDetectorTypes = [.phoneNumber, .link]
                
        textView.backgroundColor = UIColor.clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        uiView.attributedText = try! NSAttributedString(data: text.data(using: .unicode)!,
                                                   options: [.documentType: NSAttributedString.DocumentType.html],
                                                   documentAttributes: nil)
    }
}

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
    
    @State var defaultTitle = "Lindlar Mobil"
    @State var defaultDesc = "<span style=\"font-family: sans-serif; font-size: 12pt;\"><strong>Nicht die richtige Mitfahrgelegenheit gefunden?</strong> <br>Versuchen Sie es doch mit unserem LiMo-Service: <br><a href=tel:+4922664407204>+49 2266 440 72 04</a></span>"
    
    var body: some View {
        GeometryReader { view in
            ZStack(alignment: .leading) {
                MapboxMap(parent: self)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                MapBottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: (view.size.height / 3) * 2)  {
                    VStack(alignment: .leading) {
                        Text(contextTitle == "" ? defaultTitle : contextTitle)
                            .font(.title)
                            .padding(5)
                        AttributedText(contextTitle == "" ? defaultDesc : contextDesc)
                        Spacer()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(EdgeInsets(top: view.safeAreaInsets.top, leading: 0, bottom: 0, trailing: 0))
                .ignoresSafeArea()
            }
        }
        .navigationBarTitle("Mobil", displayMode: .inline)
    }
}

struct MobilView_Previews: PreviewProvider {
    static var previews: some View {
        MobilView()
    }
}
