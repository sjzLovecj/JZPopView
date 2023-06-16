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
    
    func createContent() -> some View {
        VStack {
            
        }
    }
    
    func show() {
        
    }
    
    func dissmis(complate: () -> ()) {
        
    }
}

