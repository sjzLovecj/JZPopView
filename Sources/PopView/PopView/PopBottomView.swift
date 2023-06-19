//
//  PopBottomView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/15.
//

import SwiftUI

struct PopBottomView: PopContentView {
    var popView: AnyPop<PopBottomConfigure>
    @ObservedObject var animationManger: AnimationManger = AnimationManger()
    @State var popHeight: CGFloat = 0
    
    @ObservedObject private var manager: PopManager = .shared
    
    func createContent() -> some View {
        ZStack(alignment: .bottom) {
            if isMask { createBackground() } else { Color.clear }
            configPopView()
        }
        .frame(width: manager.windowWidth, height: manager.windowHeight)
        .onAppear {
            // 延迟0.01秒，因为不延迟，开始直接显示，不展示动画
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                show()
            }
        }
    }
}

extension PopBottomView {
    func show() {
        animationManger.isShow = true
        if config.isAutoHidden {
            DispatchQueue.main.asyncAfter(deadline: .now() + autoHiddenAfter) {
                popView.dismiss(popView)
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

extension PopBottomView {
    func createBackground() -> some View {
        maskBackgroundColor
            .ignoresSafeArea()
            .opacity(animationManger.isShow ? 1.0 : 0.0)
            .padding(maskPaddingEdge)
            .animation(.easeIn(duration: 0.2), value: animationManger.isShow)
            .onTapGesture { if tapOutsideCloses { popView.dismiss(popView) } }
    }
    
    func configPopView() -> some View {
        VStack {
            Spacer()
            popView
                .padding(.bottom, config.popBottomPadding)
                .padding(.leading, horizontalPadding + maskPaddingEdge.leading)
                .padding(.trailing, horizontalPadding + maskPaddingEdge.trailing)
                .readHeight(onChange: { popHeight = $0 })
                .offset(y: animationManger.isShow ? 0 : popHeight)
        }
        .clipped()
        .padding(.bottom, bottomPadding)
        .animation(config.transitionAnimation(), value: animationManger.isShow)
    }
}

extension PopBottomView {
    // 背景颜色
    var isMask: Bool { config.isMask }
    var maskBackgroundColor: Color { config.maskBackgroundColor }
    var maskPaddingEdge: EdgeInsets { config.maskPaddingEdge }
    
    var tapOutsideCloses: Bool { config.tapOutsideCloses }
    
    var bottomPadding: CGFloat { config.bottomPadding }
    
    var isAutoHidden: Bool { config.isAutoHidden }
    var autoHiddenAfter: CGFloat { config.autoHiddenAfter }
    
    var animationDuration: Double { config.animationDuration }
    
    var horizontalPadding: CGFloat { config.horizontalPadding }
    
    var config: PopBottomConfigure { popView.configurePop(config: .init()) }
}
