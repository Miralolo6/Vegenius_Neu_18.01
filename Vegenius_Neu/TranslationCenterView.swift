//
//  TranslationCenterView.swift
//  Vegenius_Neu
//
//  Created by TA620 on 15.03.26.
//

import SwiftUI

struct TranslationCenterButton: View { //die Eigenschaften vom Übersetzungsbutton
        var body: some View {
            
                ZStack {
                    // Halber Kreis HINTER dem Button
                    HalfCircle()
                        .fill(Color(red: 126/255, green: 222/255, blue: 211/255))
                        .frame(width: 120, height: 60)
                        .offset(y: -30)
                    
                    // Runder Button
                    Circle()
                        .fill(Color(red: 59/255, green: 161/255, blue: 148/255))
                        .frame(width: 90, height: 90)
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                        .overlay(
                            Image("Übersetzung_Pfeile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        )
            }
            .buttonStyle(.plain)
        }
    }
