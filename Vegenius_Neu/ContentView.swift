//
//  ContentView.swift
//  Vegenius
//
//  Created by Amira on 17.01.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            //1 Background color
            Color("BackgroundMint")
                .ignoresSafeArea()
            //2 Vertical Layout for logo, title, button
            VStack {
                //3 Logo Image
                Image("TurtleLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 290, height: 320)
                    .padding(.top, -50)
                // 4 App name
                Text("Vegenius")
                    .font(.system(size: 40, weight: .bold))
                    .padding(.top, -70)
                // 5 Space before Button
                Spacer()
                    .frame(height: 40)
                // 6 Button
                Button(action:  {
                    print("Los geht's!")
                }) {
                    Text("Los geht's!")
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.horizontal, 25)
                        .padding(.vertical, 13)
                        .background(Color("ButtonColor"))
                        .foregroundStyle(Color("TextColor"))
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.6), radius: 8, y: -2)
                        .shadow(color: Color.black.opacity(0.12), radius: 3, y: 7)

                        .padding(.top, 40)
                    
                }
            }
// moves everything slightly upward
            .padding(.top, 100)
        }
    }
    
}

#Preview {
    ContentView()
}
