//
//  PopProtocol.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/15.
//

import SwiftUI

public protocol TopPop: Pop { associatedtype Config = PopTopConfigure }
public protocol BottomPop: Pop { associatedtype Config = PopBottomConfigure }
public protocol CenterPop: Pop { associatedtype Config = PopCenterConfigure }

public protocol Pop: View {
    associatedtype Config: Configurable
    associatedtype V: View
    
    var id: UUID { get }
    func createContent() -> V
    func configurePop(config: Config) -> Config
}

public extension Pop {
    var body: V { createContent() }
    func configurePop(config: Config) -> Config { config }
    
    // 显示
    func show() { PopManager.show(AnyPop<Config>(self)) }
    
    // 隐藏
    func dismiss() { PopManager.dismiss() }
    func dismiss(id: UUID) { PopManager.dismiss(id: id) }
    func dismiss(_ pop: any Pop) { PopManager.dismiss(pop) }
    func dismissAll() {}
}

// MARK: -Type Eraser
struct AnyPop<Config: Configurable>: Pop, Hashable {
    let id: UUID

    private let _body: AnyView
    private let _configBuilder: (Config) -> Config

    init(_ popup: some Pop) {
        self.id = popup.id
        self._body = AnyView(popup)
        self._configBuilder = popup.configurePop as! (Config) -> Config
    }
}

extension AnyPop {
    static func == (lhs: AnyPop<Config>, rhs: AnyPop<Config>) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

extension AnyPop {
    func createContent() -> some View { _body }
    func configurePop(config: Config) -> Config { _configBuilder(config) }
}



