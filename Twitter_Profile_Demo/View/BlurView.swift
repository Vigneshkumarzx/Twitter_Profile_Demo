//
//  BlurView.swift
//  Twitter_Profile_Demo
//
//  Created by vignesh kumar c on 08/09/23.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIVisualEffectView {
          
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
