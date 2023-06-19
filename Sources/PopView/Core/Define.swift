//
//  Define.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import SwiftUI
import Combine

class Define: ObservableObject {
    static let shared: Define = Define()
    
    // 获取 windowScene
    var windowScene: UIWindowScene? { UIApplication.shared.connectedScenes.first as? UIWindowScene }
    var keyWindow: UIWindow? { windowScene?.windows.first { $0.isKeyWindow } }
    var safeArea: UIEdgeInsets { windowScene?.keyWindow?.safeAreaInsets ?? .zero }
    
}


