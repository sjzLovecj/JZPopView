//
//  PopManager.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import SwiftUI
import UIKit

public class AnimationManger: ObservableObject {
    @Published var isShow: Bool = false
}

// 设置单例
public class PopManager: ObservableObject {
    static let shared: PopManager = PopManager()
    private init() { }
    
    var popWindow: UIWindow?
    var popHosting: UIViewController?
    
    @Published var popViews: [any PopContentView] = []
    
    
    @Published var windowWidth: CGFloat = 0
    @Published var windowHeight: CGFloat = 0
}

public extension PopManager {
    static func dismiss() {
        DispatchQueue.main.async {
            // 执行动画
            if !shared.popViews.isEmpty, let lastPop = shared.popViews.last {
                lastPop.dissmis {
                    DispatchQueue.main.async {
                        shared.popViews.removeAll { $0.id == lastPop.id }
                        if shared.popViews.isEmpty { shared.popWindow?.isHidden = true }
                    }
                }
            }
        }
    }
    
    static func dismiss(_ pop: some Pop) {
        DispatchQueue.main.async {
            var id: UUID?
            if let popView = pop as? AnyPop<PopCenterConfigure> {
                id = popView.id
            }else if let popView = pop as? AnyPop<PopBottomConfigure> {
                id = popView.id
            }else if let popView = pop as? AnyPop<PopTopConfigure> {
                id = popView.id
            }
            
            if let id, let popView = shared.popViews.first(where: { $0.id == id }) {
                popView.dissmis {
                    DispatchQueue.main.async {
                        shared.popViews.removeAll { $0.id == popView.id }
                        if shared.popViews.isEmpty { shared.popWindow?.isHidden = true }
                    }
                }
            }
        }
    }
}

public extension PopManager {
    static func show(_ pop: some Pop) {
        DispatchQueue.main.async {
            if let _ = Define.shared.keyWindow?.rootViewController as? UIViewController, shared.popWindow == nil {
                shared.createPopWindow()
            }else if let popWindow = shared.popWindow {
                popWindow.isHidden = false
            }
            
            if let popView = pop as? AnyPop<PopCenterConfigure> {
                let center = PopCenterView(popView: popView)
                shared.popViews.append(center)
            }else if let popView = pop as? AnyPop<PopBottomConfigure> {
                let bottom = PopBottomView(popView: popView)
                shared.popViews.append(bottom)
            }else if let popView = pop as? AnyPop<PopTopConfigure> {
                let top = PopTopView(popView: popView)
                shared.popViews.append(top)
            }
        }
    }
    
    func createPopWindow() {
        if let windowScene = Define.shared.windowScene, popWindow == nil {
            popWindow = UIWindow(windowScene: windowScene)
            
            popWindow?.windowLevel = .statusBar
            popWindow?.backgroundColor = UIColor.red

            windowWidth = popWindow?.frame.size.width ?? 0
            windowHeight = popWindow?.frame.size.height ?? 0
            
            popWindow?.rootViewController = HostingController(rootView: PopView())
            popHosting?.view.backgroundColor = UIColor.clear
            
            popWindow?.isHidden = false
            
        }
    }
}


