//
//  PopTopConfigure.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/15.
//

import SwiftUI

public struct PopTopConfigure: Configurable {
    // MARK: - mask蒙版设置，蒙版默认是ignoresSafeArea
    // 如果想设置蒙版距离边界距离，请设置maskPaddingEdge
    var isMask: Bool = true
    var maskBackgroundColor: Color = Color.blue.opacity(0.5)
    var maskPaddingEdge: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    // 点击弹窗
    var tapOutsideCloses: Bool = false
    
    // MARK: - popView设置
    // 是否忽略安全区域
    var horizontalPadding: CGFloat = 0
    
    var isIgnoresSafeArea: Bool = true
    // 弹出位置的偏移量
    var topPadding: CGFloat = 0
    
    // 弹窗距离底部的位置
    var popTopPadding: CGFloat = 0
    
    // MARK: - 动画与自动隐藏相关参数
    // 是否自动隐藏
    var isAutoHidden: Bool = false
    var autoHiddenAfter: CGFloat = 2
    
    // 动画与动画时间，一定要精准的得到动画时间
    var animationDuration: Double = 0.6
    var animation: ((Double) -> (Animation))?
    
    func transitionAnimation() -> Animation {
        guard let animation else { return .easeInOut(duration: animationDuration)  }
        return animation(animationDuration)
    }
}

public extension PopTopConfigure {
    @discardableResult
    func isMask(_ value: Bool) -> Self { changing(path: \.isMask, to: value) }
    @discardableResult
    func maskBackgroundColor(_ value: Color) -> Self { changing(path: \.maskBackgroundColor, to: value) }
    @discardableResult
    func maskPaddingEdge(_ value: EdgeInsets) -> Self { changing(path: \.maskPaddingEdge, to: value) }

    @discardableResult
    func tapOutsideCloses(_ value: Bool) -> Self { changing(path: \.tapOutsideCloses, to: value) }
    
    @discardableResult
    func horizontalPadding(_ value: CGFloat) -> Self { changing(path: \.horizontalPadding, to: value) }
    
    @discardableResult
    func topPadding(_ value: CGFloat) -> Self { changing(path: \.topPadding, to: value) }
    
    @discardableResult
    func popTopPadding(_ value: CGFloat) -> Self { changing(path: \.popTopPadding, to: value) }
    
    
    // 是否自动隐藏
    @discardableResult
    func isAutoHidden(_ value: Bool) -> Self { changing(path: \.isAutoHidden, to: value) }
    @discardableResult
    func autoHiddenAfter(_ value: CGFloat) -> Self { changing(path: \.autoHiddenAfter, to: value) }
 
    // 动画与动画时间
    @discardableResult
    func animationDuration(_ value: CGFloat) -> Self { changing(path: \.animationDuration, to: value) }
    @discardableResult
    func animation(_ value: ((Double) -> (Animation))?) -> Self { changing(path: \.animation, to: value) }
}
