//
//  ViewEx.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/14.
//

import SwiftUI

//extension View {
//    func initPopView() -> some View {
//        self.overlay {
//            PopView()
//        }
//    }
//}

// MARK: - 上下布局
extension View {
    func alignToBottom(_ value: CGFloat = 0) -> some View {
        VStack(spacing: 0) {
            Spacer()
            self
            Spacer().frame(height: value)
        }
    }
    
    func alignToTop(_ value: CGFloat = 0) -> some View {
        VStack(spacing: 0) {
            Spacer().frame(height: value)
            self
            Spacer()
        }
    }
}

// MARK: - 获取View的高度
extension View {
    func readHeight(onChange action: @escaping (CGFloat) -> ()) -> some View {
        background(heightReader).onPreferenceChange(HeightPreferenceKey.self, perform: action)
    }
}

private extension View {
    var heightReader: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }
}

fileprivate struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
