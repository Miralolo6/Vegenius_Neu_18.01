//
//  VeganLoadingView.swift
//  Vegenius_Neu
//
//  Created by Miriam Nguyen on 18.10.26.
//


import SwiftUI

struct VeganLoadingView: View {

    private let mintBackground = Color(
        red: 247 / 255,
        green: 253 / 255,
        blue: 252 / 255
    )

    private let turquoise = Color(
        red: 25 / 255,
        green: 190 / 255,
        blue: 177 / 255
    )

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {

                Spacer()

                // MARK: - Illustration
                
                // MARK: - Illustration
                Image("TurtleLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 40)

                // MARK: - Loading Text
                Text("Dein Rezept wird gerade\nins Vegane übersetzt.")
                    .font(.system(size: 29, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .lineSpacing(9)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 24)

                // MARK: - Animated Progress
                AnimatedVeganProgressBar()
                    .padding(.horizontal, 54)
                    .padding(.top, 44)

                Spacer()

                // MARK: - Branding
                Text("Vegenius")
                    .font(.system(size: 23, weight: .bold))
                    .foregroundStyle(.black)
                    .padding(.bottom, 28)
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
            .background(mintBackground)
        }
        .ignoresSafeArea()
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "Dein Rezept wird gerade ins Vegane übersetzt. Bitte warten."
        )
    }
}


struct AnimatedVeganProgressBar: View {

    @State private var isAnimating = false

    private let turquoise = Color(
        red: 25 / 255,
        green: 190 / 255,
        blue: 177 / 255
    )

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {

                Capsule()
                    .fill(turquoise.opacity(0.15))

                Capsule()
                    .fill(turquoise)
                    .frame(width: geometry.size.width * 0.7)
                    .offset(
                        x: isAnimating
                        ? geometry.size.width * 0.3
                        : 0
                    )
            }
            .clipShape(Capsule())
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 1.1)
                    .repeatForever(autoreverses: true)
                ) {
                    isAnimating = true
                }
            }
        }
        .frame(height: 12)
    }
}


#Preview {
    VeganLoadingView()
}
