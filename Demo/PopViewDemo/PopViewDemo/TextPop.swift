//
//  TextPop.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/6/16.
//

import SwiftUI

struct TextPop: CenterPop {
    
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
    
    func configurePop(config: PopCenterConfigure) -> PopCenterConfigure {
        config
            .maskBackgroundColor(Color.gray.opacity(0.5))
            .isAutoHidden(true)
            .horizontalPadding(20)
            .animation { duration in
                .linear(duration: duration)
            }
    }
}

