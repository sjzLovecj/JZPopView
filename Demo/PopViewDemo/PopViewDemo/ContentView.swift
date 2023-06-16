//
//  ContentView.swift
//  PopViewDemo
//
//  Created by S JZ on 2023/5/18.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow
    
    let pop = TextPop(text: "falfjalfja;lfja;fjalfjaslfjslfjsalfjlsjflajlfjslfkjalfjladfjal")
    let pop1 = TextPop(text: "abcfsfsfsfs")
    let pop2 = TextPop(text: "你好")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onTapGesture {
            pop.show()
//            pop1.show()
//            pop2.show()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
