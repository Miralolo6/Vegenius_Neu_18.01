//
//  Animation neu.swift
//  Vegenius_Neu
//
//  Created by TA617 on 11.03.26.
//

import SwiftUI

struct ContentView: View {
    // Bildnamen in der richtigen Reihenfolge
    let frames = ["S1", "S2", "S3", "S4", "S5"]

    @State private var currentFrameIndex = 0
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Color(
                red: 247/255,
                green: 253/255,
                blue: 252/255
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                // Aktuelles Frame anzeigen
                Image(frames[currentFrameIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Button(action: startAnimation) {
                    Text("Los geht´s!")
                        .foregroundColor(Color(red: 30/255, green: 109/255, blue: 129/255))
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Color(red: 173/255, green: 246/255, blue: 237/255))
                        .clipShape(Capsule())
                        .shadow(radius: 8)
                }
                .disabled(isAnimating) // während der Animation nicht erneut klicken
            }
            .padding()
            .background(Color(red: 0.96, green: 0.99, blue: 0.98))
            .ignoresSafeArea()
        }
    }

    // Animation starten
    func startAnimation() {
        guard !isAnimating else { return }
        isAnimating = true

        currentFrameIndex = 0

        // Dauer zwischen Frames (z.B. 0.08 = 80 ms → relativ schnell)
        let frameDuration: TimeInterval = 0.4

        for i in 0..<frames.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + frameDuration * Double(i)) {
                currentFrameIndex = i
            }
        }

        // Nach letztem Frame Animation beenden, optional wieder zu S1 zurück
        DispatchQueue.main.asyncAfter(deadline: .now() + frameDuration * Double(frames.count)) {
            isAnimating = false
            // Wenn du am Ende die schlafende Schildkröte (S5) lassen willst, nichts ändern.
            // Wenn du wieder bei S1 starten willst, dann:
            // currentFrameIndex = 0
        }
    }
}

#Preview {
    ContentView()
}
