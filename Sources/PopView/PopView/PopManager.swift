//
//  PopManager.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import SwiftUI

public class AnimationManger: ObservableObject {
    @Published var isShow: Bool = false
}

// 设置单例
public class PopManager: ObservableObject {
    static let shared: PopManager = PopManager()
    private init() { }
    
    @Published var popViews: [any PopContentView] = []
}

public extension PopManager {
    static func dismiss() {
        DispatchQueue.main.async {
            // 执行动画
            if !shared.popViews.isEmpty, let lastPop = shared.popViews.last {
                lastPop.dissmis { shared.popViews.removeAll { $0.id == lastPop.id } }
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
                popView.dissmis { shared.popViews.removeAll { $0.id == popView.id } }
            }
        }
    }
}

public extension PopManager {
    static func show(_ pop: some Pop) {
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

//extension PopManager {
//    static func canBeInserted(_ popContent: some PopContentView) -> Bool {
//        !shared.popViews.contains(where: { $0.id == popContent.id })
//    }
//}

