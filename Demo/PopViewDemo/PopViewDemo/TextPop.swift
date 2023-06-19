//
//  TextPop.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/16.
//

import SwiftUI

struct TextPop: TopPop {
    
    var text: String
    
    func createContent() -> some View {
        VStack {
            Text(text)
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(5)
        }
        .onTapGesture {
            dismiss()
        }
    }
    
    func configurePop(config: PopTopConfigure) -> PopTopConfigure {
        config
            .maskBackgroundColor(Color.gray.opacity(0.5))
            .tapOutsideCloses(true)
            .animationDuration(0.3)
            .horizontalPadding(20)
            .maskPaddingEdge(EdgeInsets(top: 0, leading: 100, bottom: 0, trailing: 0))
//            .bottomPadding(30)
            .popTopPadding(50)
            .animation { duration in
                .linear(duration: duration)
            }
    }
}

