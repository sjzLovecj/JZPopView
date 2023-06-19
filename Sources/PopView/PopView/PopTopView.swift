//
//  PopTopView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/15.
//

import SwiftUI

struct PopTopView: PopContentView {
    var popView: AnyPop<PopTopConfigure>
    @ObservedObject var animationManger: AnimationManger = AnimationManger()
    @State var popHeight: CGFloat = 0
    
    func createContent() -> some View {
        ZStack(alignment: .top) {
            if isMask { createBackground() }
            else { Color.clear }
            
            configPopView()
        }
        .frame(width: Define.screenWidth, height: Define.screenHeight)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                show()
            }
        }
    }
}

extension PopTopView {
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

extension PopTopView {
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
            popView
                .padding(.top, config.popTopPadding)
                .padding(.leading, horizontalPadding + maskPaddingEdge.leading)
                .padding(.trailing, horizontalPadding + maskPaddingEdge.trailing)
                .readHeight(onChange: { popHeight = $0 })
                .offset(y: animationManger.isShow ? 0 : -popHeight)
            
            Spacer()
        }
        .clipped()
        .padding(.top, topPadding)
        .animation(config.transitionAnimation(), value: animationManger.isShow)
    }
}

extension PopTopView {
    // 背景颜色
    var isMask: Bool { config.isMask }
    var maskBackgroundColor: Color { config.maskBackgroundColor }
    var maskPaddingEdge: EdgeInsets { config.maskPaddingEdge }
    
    var tapOutsideCloses: Bool { config.tapOutsideCloses }
    
    var topPadding: CGFloat { config.topPadding }
    
    var isAutoHidden: Bool { config.isAutoHidden }
    var autoHiddenAfter: CGFloat { config.autoHiddenAfter }
    
    var animationDuration: Double { config.animationDuration }
    
    var horizontalPadding: CGFloat { config.horizontalPadding }
    
    var config: PopTopConfigure { popView.configurePop(config: .init()) }
}
