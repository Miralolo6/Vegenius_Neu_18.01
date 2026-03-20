//
//  Animation .swift
//  Vegenius_Neu
//
//  Created by TA617 on 25.02.26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isAnimating = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            // Hintergrund-Gradient
            LinearGradient(
                colors: [.white, Color(.systemTeal).opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 60) {
                Spacer()
                
                // Logo + Titel
                VStack(spacing: 24) {
                    Text("Vegenius")
                        .foregroundColor(
                            Color(
                                red:231/255,
                                green: 161/255,
                                blue: 176/255
                            )
                        )
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0xE0/255, green: 0x9E/255, blue: 0xB4/255))
                    
                   
                }
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .opacity(isAnimating ? 1.0 : 0.0)
                .animation(.spring(response: 0.8, dampingFraction: 0.7), value: isAnimating)
                
                Spacer()
                
                // Animierte Schildkröte + Muffin
                turtleAnimation
                
                Spacer()
                
                // Start Button
                Button {
                    // Navigation zur Rezept-Eingabe
                } label: {
                    HStack {
                        Image(systemName: "play.circle.fill")
                            .font(.title2)
                        Text("Starten")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0xE0/255, green: 0x9E/255, blue: 0xB4/255))
                            .shadow(color: .pink.opacity(0.3), radius: 12, x: 0, y: 6)
                    )
                }
                .opacity(showButton ? 1.0 : 0.0)
                .scaleEffect(showButton ? 1.0 : 0.9)
                .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(1.2), value: showButton)
            }
            .padding(40)
        }
        .onAppear {
            withAnimation {
                isAnimating = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showButton = true
            }
        }
    }
    
    // MARK: - Schildkröte Animation
    private var turtleAnimation: some View {
        ZStack {
            // Schildkröte (grünes Oval mit Kopf und Beinen)
            TurtleView()
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .rotationEffect(.degrees(isAnimating ? 5 : 0))
                .animation(
                    Animation.easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true)
                    .delay(0.3),
                    value: isAnimating
                )
            
            // Muffin (bewegt sich zur Schildkröte)
            MuffinView()
                .offset(x: isAnimating ? -20 : 80)
                .scaleEffect(isAnimating ? 0.85 : 1.0)
                .opacity(isAnimating ? 0.9 : 1.0)
                .animation(
                    Animation.spring(response: 1.2, dampingFraction: 0.6)
                    .repeatForever(autoreverses: true)
                    .delay(0.5),
                    value: isAnimating
                )
        }
        .frame(height: 200)
    }
}

// MARK: - Schildkröte Component
struct TurtleView: View {
    var body: some View {
        ZStack {
            // Schild (grünes Oval)
            Ellipse()
                .fill(Color(.systemGreen))
                .frame(width: 120, height: 100)
                .shadow(color: .green.opacity(0.3), radius: 8)
            
            // Kopf
            Circle()
                .fill(Color(.systemGreen))
                .frame(width: 50, height: 50)
                .offset(x: 35, y: -10)
            
            // Augen
            Circle()
                .fill(.white)
                .frame(width: 12, height: 12)
                .offset(x: 42, y: -12)
            Circle()
                .fill(.white)
                .frame(width: 12, height: 12)
                .offset(x: 48, y: -12)
            
            // Beine
            Rectangle()
                .fill(Color(.systemGreen))
                .frame(width: 20, height: 25)
                .rotationEffect(.degrees(-30))
                .offset(x: -25, y: 25)
            Rectangle()
                .fill(Color(.systemGreen))
                .frame(width: 20, height: 25)
                .rotationEffect(.degrees(30))
                .offset(x: 25, y: 25)
        }
    }
}

// MARK: - Muffin Component
struct MuffinView: View {
    @State private var biteTaken = false
    
    var body: some View {
        ZStack {
            // Muffin-Boden (braun)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.brown.opacity(0.9))
                .frame(width: 70, height: 50)
                .shadow(color: .brown.opacity(0.4), radius: 4)
            
            // Creme (weiß/pink)
            Ellipse()
                .fill(Color(red: 0xFF/255, green: 0xD4/255, blue: 0xD4/255))
                .frame(width: 60, height: 35)
                .offset(y: -15)
            
            // Biss (wenn animiert)
            if biteTaken {
                Circle()
                    .fill(Color.brown.opacity(0.9))
                    .frame(width: 20, height: 20)
                    .offset(x: -8, y: -5)
            }
        }
        .scaleEffect(biteTaken ? 0.9 : 1.0)
        .animation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: biteTaken)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                biteTaken.toggle()
            }
        }
    }
}

#Preview {
    OnboardingView()
}
