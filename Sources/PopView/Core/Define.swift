//
//  Define.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import SwiftUI

struct Define {
    // 获取 windowScene
    static var windowScene: UIWindowScene? { UIApplication.shared.connectedScenes.first as? UIWindowScene }
    static var screenWidth: CGFloat { windowScene?.screen.bounds.width ?? 0 }
    static var screenHeight: CGFloat { windowScene?.screen.bounds.height ?? 0 }
    static var safeArea: UIEdgeInsets { windowScene?.keyWindow?.safeAreaInsets ?? .zero }
}
