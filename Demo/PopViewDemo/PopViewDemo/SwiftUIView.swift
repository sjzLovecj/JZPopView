//
//  SwiftUIView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/5/30.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Rectangle()
            .background(.red.opacity(0.5))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
