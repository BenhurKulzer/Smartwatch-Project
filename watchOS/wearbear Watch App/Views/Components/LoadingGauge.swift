//
//  LoadingGauge.swift
//  wearbear
//
//  Created by Benhur on 17/10/24.
//


import SwiftUI

struct LoadingGauge: View {
    let number: Int
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .foregroundColor(.gray.opacity(0.3))

            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .foregroundColor(.green)
                .rotationEffect(Angle(degrees: rotation))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
                .onAppear {
                    rotation = 360
                }

            Text("\(number)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 25, height: 25)
    }
}
