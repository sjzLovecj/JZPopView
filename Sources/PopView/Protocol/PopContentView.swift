//
//  PopContentView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/16.
//

import SwiftUI

// MARK: - PopContentView
protocol PopContentView: View {
    associatedtype V: View
    associatedtype Config: Configurable
    
    var id: UUID { get }
    var popView: AnyPop<Config> { get set }
    
    func createContent() -> V
    func show()
    func dissmis(complate: @escaping () -> ())
}

extension PopContentView {
    var id: UUID { popView.id }
    var body: V { createContent() }
}
