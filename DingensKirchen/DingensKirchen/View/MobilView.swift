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
        
        textView.linkTextAttributes = [
            .foregroundColor : UIColor.black,
            .underlineStyle : 0,
            .underlineColor : UIColor.clear
        ]
        
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
        uiView.attributedText = try! NSAttributedString(data: text.data(using: .unicode)!,
                                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                                   documentAttributes: nil)
        uiView.font = UIFont.systemFont(ofSize: 16, weight: .light)
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
    
    @State var defaultTitle = NSLocalizedString("mobil_placeholder_title",
                                                comment: "")
    @State var defaultDesc = NSLocalizedString("mobil_placeholder_description",
                                               comment: "")
    
    var body: some View {
        GeometryReader { view in
            ZStack(alignment: .leading) {
                MapboxMap(parent: self)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                MapBottomSheetView(isOpen: self.$bottomSheetShown, maxHeight: (view.size.height / 3) * 2)  {
                    VStack(alignment: .leading) {
                        Text("mobil_action")
                            .font(Font.system(size: 18))
                            .padding(10)
                        Text(contextTitle == "" ? defaultTitle : contextTitle)
                            .font(Font.system(size: 28, weight: .light))
                            .padding(10)
                        AttributedText(contextTitle == "" ? defaultDesc : contextDesc)
                            .font(Font.system(size: 16, weight: .light))
                            .foregroundColor(.black)
                            .padding(10)
                    }
                }
                .padding(EdgeInsets(top: view.safeAreaInsets.top, leading: 0, bottom: 0, trailing: 0))
                .ignoresSafeArea()
            }
        }
        .navigationBarTitle("mobil_navigation_title", displayMode: .inline)
    }
}

struct MobilView_Previews: PreviewProvider {
    static var previews: some View {
        MobilView()
    }
}


extension String {

    func textHeightFrom(width: CGFloat, fontName: String = "System Font", fontSize: CGFloat = 16.0) -> CGFloat {

        #if os(macOS)

        typealias UXFont = NSFont
        let text: NSTextField = .init(string: self)
        text.font = NSFont.init(name: fontName, size: fontSize)

        #else

        typealias UXFont = UIFont
        let text: UILabel = .init()
        text.text = self
        text.numberOfLines = 0

        #endif

        text.font = UXFont.init(name: fontName, size: fontSize)
        text.lineBreakMode = .byWordWrapping
        return text.sizeThatFits(CGSize.init(width: width, height: .infinity)).height
    }
}
