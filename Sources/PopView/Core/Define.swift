//
//  Define.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import SwiftUI

class Define: ObservableObject {
    static let shared: Define = Define()
    
    // 获取 windowScene
    var windowScene: UIWindowScene? { UIApplication.shared.connectedScenes.first as? UIWindowScene }
    var keyWindow: UIWindow? { windowScene?.windows.first { $0.isKeyWindow } }
    var safeArea: UIEdgeInsets { windowScene?.keyWindow?.safeAreaInsets ?? .zero }
    
    var screenWidth: CGFloat { windowScene?.screen.bounds.width ?? 0 }
    var screenHeight: CGFloat { windowScene?.screen.bounds.height ?? 0 }
}

//extension Define {
//    func changeSize() {
//        NotificationCenter.default
//            .publisher(for: NSNotification.didResizeNotification)
//    }
//}


