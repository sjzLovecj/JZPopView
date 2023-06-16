//
//  PopView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/15.
//

import SwiftUI

struct PopView: View {
    @ObservedObject private var manager: PopManager = .shared
    
    var body: some View {
        ZStack {
            ForEach(0..<manager.popViews.count, id: \.self) { index in
                createPop(index)
            }
        }
    }
}

extension PopView {
    func createPop(_ index: Int) -> some View {
        let pop = manager.popViews[index]
        return AnyView(pop)
    }
}
