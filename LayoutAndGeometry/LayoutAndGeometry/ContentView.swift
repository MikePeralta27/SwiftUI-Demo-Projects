//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Michael Peralta on 6/23/26.
//

import SwiftUI

struct ContentView: View {
    private let fadeDistance: CGFloat = 200
    private let minScale: CGFloat = 0.5

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .named("scroll")).minY
                        let scale = scale(for: minY, in: fullView.size.height)
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(scrollColor(for: minY, in: fullView.size.height))
                            .scaleEffect(scale, anchor: .bottom)
                            .opacity(fadeOpacity(for: minY))
                            .rotation3DEffect(.degrees(minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
            .coordinateSpace(name: "scroll")
        }
    }

    private func fadeOpacity(for minY: CGFloat) -> Double {
        if minY <= 0 {
            0
        } else if minY >= fadeDistance {
            1
        } else {
            Double(minY / fadeDistance)
        }
    }
    
    private func scale(for minY: CGFloat, in height: CGFloat) -> CGFloat {
        let clampedY = min(max(minY, 0), height)
        let progress = clampedY / height
        
        return minScale + (progress * (1 - minScale))
    }
    
    private func scrollColor(for minY: CGFloat, in height: CGFloat) -> Color {
        let clampedY = min(max(minY, 0), height)
        let hue = Double(clampedY / height)
        
        return Color(hue: hue, saturation: 1, brightness: 1)
    }
}


#Preview {
    ContentView()
}
