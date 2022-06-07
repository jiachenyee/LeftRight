//
//  ContentView.swift
//  LeftRight Watch App
//
//  Created by Jia Chen Yee on 7/6/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Color.blue.opacity(0.2)
                Text("Left")
            }
            ZStack {
                Color.clear
                Text("Right")
            }
        }
        .font(.title)
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
