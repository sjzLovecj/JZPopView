//
//  PopCenterView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/15.
//

import SwiftUI

struct PopCenterView: PopContentView {
    var popView: AnyPop<PopCenterConfigure>
    @ObservedObject var animationManger: AnimationManger = AnimationManger()
    
    @ObservedObject private var manager: PopManager = .shared
    
    func createContent() -> some View {
        ZStack(alignment: .center, content: {
            if isMask { createBackground() }
            configPopView()
        })
        .frame(width: manager.windowWidth, height: manager.windowHeight)
        .onAppear { show() }
    }
}

extension PopCenterView {
    func show() {
        animationManger.isShow = true
        if config.isAutoHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + autoHiddenAfter) {
                PopManager.dismiss(id: popView.id)
            }
        }
    }
    
    func dissmis(complate: @escaping () -> ()) {
        animationManger.isShow = false
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            complate()
        }
    }
}

extension PopCenterView {
    func createBackground() -> some View {
        maskBackgroundColor
            .ignoresSafeArea()
            .opacity(animationManger.isShow ? 1.0 : 0.0)
            .animation(.easeIn(duration: 0.2), value: animationManger.isShow)
            .padding(maskPaddingEdge)
            .onTapGesture { if tapOutsideCloses { PopManager.dismiss(id: popView.id) } }
    }
    
    func configPopView() -> some View {
        popView
            .offset(y: popViewOffset)
            .padding(.leading, horizontalPadding + maskPaddingEdge.leading)
            .padding(.trailing, horizontalPadding + maskPaddingEdge.trailing)
            .opacity(animationManger.isShow ? 1.0 : 0.0)
            .animation(config.transitionAnimation(), value: animationManger.isShow)
    }
}

extension PopCenterView {
    // 背景颜色
    var isMask: Bool { config.isMask }
    var maskBackgroundColor: Color { config.maskBackgroundColor }
    var maskPaddingEdge: EdgeInsets { config.maskPaddingEdge }
    
    var tapOutsideCloses: Bool { config.tapOutsideCloses }
    
    var popViewOffset: CGFloat { config.popViewOffset }
    
    var isAutoHidden: Bool { config.isAutoHidden }
    var autoHiddenAfter: CGFloat { config.autoHiddenAfter }
    
    var animationDuration: Double { config.animationDuration }
    
    var horizontalPadding: CGFloat { config.horizontalPadding }
    
    var config: PopCenterConfigure { popView.configurePop(config: .init()) }
}
