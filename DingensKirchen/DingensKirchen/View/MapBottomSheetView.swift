//
//  MapBottomSheetView.swift
//  DingensKirchen
//
//  Created by Pascal Schönthier on 01.09.21.
//

import SwiftUI

struct MapBottomSheetView<Content: View>: View {
    
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.secondary)
            .frame(width: 100, height: 5, alignment: .center)
    }
    
    init(isOpen: Binding<Bool>,
         maxHeight: CGFloat,
         @ViewBuilder content: () -> Content) {
        self.minHeight = 30
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .background(Color.primaryHighlight.opacity(0.85))
            .cornerRadius(15, corners: [.topLeft, .topRight])
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(DragGesture().updating(self.$translation) { value, state, _ in
                state = value.translation.height
            }.onEnded { value in
                let snapDistance = self.maxHeight * 0.6
                guard abs(value.translation.height) > snapDistance else {
                    return
                }
                self.isOpen = value.translation.height < 0
            })
        }
        
    }
    
    
}

//struct MapBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapBottomSheetView(isOpen: <#Binding<Bool>#>, maxHeight: <#CGFloat#>, content: <#() -> _#>)
//    }
//}
