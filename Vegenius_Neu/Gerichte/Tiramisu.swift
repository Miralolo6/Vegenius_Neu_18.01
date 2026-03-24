//
//  Tiramisu.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct TiramisuView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Tiramisu
    Zutaten:
    🍪 200 g vegane Löffelbiskuits (nussfrei)
    ☕ 200 ml starker Kaffee (abgekühlt)
    🥣 400 g veganer Skyr oder Sojajoghurt
    🥄 40 g Zucker
    🥄 1 TL Vanilleextrakt
    🧂 1–2 EL Kakaopulver


1.  Kaffee zubereiten und abkühlen lassen.

2.  Skyr oder Sojajoghurt mit Zucker und Vanilleextrakt glatt rühren.

3.  Löffelbiskuits kurz in Kaffee tauchen.

4.  Biskuits in Auflaufform legen.

5.  Creme darüber verteilen.

6.  Weitere Schicht getränkter Biskuits darauf legen.

7.  Restliche Creme darauf streichen.

8.  Mit Kakaopulver bestäuben.

9.  Mindestens 2 Stunden kalt stellen, dann servieren.

💡 Tipp: Für intensiveren Geschmack etwas Kaffeepulver in die Creme rühren.

Rezept aus meiner App 🙂
"""

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) { //Bottom Bar bleibt unten
                Color(red: 247/255, green: 253/255, blue: 252/255)
                    .ignoresSafeArea() // damit sie den ganzen Bildschirm füllt
                ScrollView {
                    VStack(spacing: 0) {
                        
                        // MARK: - HEADER
                        VStack(spacing: 12) {
                            
                            HStack {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                Spacer()
                                
                                Image(systemName: "chevron.left")
                                    .opacity(0)
                            }
                            .overlay(
                                Text("Tiramisu")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Tiramisu")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 250)
                                    .clipped()
                                
                                Button {
                                    recipe.isFavorite.toggle()
                                } label: {
                                    Image(systemName: recipe.isFavorite ? "bookmark.fill" : "bookmark")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(Color(red: 82/255, green: 199/255, blue: 185/255))
                                        .padding(12)
                                        .background(Color(red: 247/255, green: 253/255, blue: 252/255))
                                        .clipShape(Circle())
                                }
                                .padding(10)
                            }
                        }
                        .padding(.top)
                        
                        // MARK: - Zutaten + Share
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("📝 Zutatenliste (für 4 Portionen)")
                                    .font(.headline)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Button {
                                    showShareSheet = true
                                } label: {
                                    Image(systemName: "square.and.arrow.up.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.mintDark)
                                        .padding(10)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                            }
                        }
                        .padding(.top)
                        
                        // MARK: - Zutaten Liste
                        VStack(alignment: .leading, spacing: 8) {
                            Zutaten(text: "🍪 200 g vegane Löffelbiskuits (nussfrei)")
                            Zutaten(text: "☕ 200 ml starker Kaffee (abgekühlt)")
                            Zutaten(text: "🥣 400 g veganer Skyr oder Sojajoghurt")
                            Zutaten(text: "🥄 40 g Zucker")
                            Zutaten(text: "🥄 1 TL Vanilleextrakt")
                            Zutaten(text: "🧂 1–2 EL Kakaopulver")
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📝 Zubereitung")
                                .font(.headline)
                                .padding(.top)
                            
                            Text("""
        
    1.  Kaffee zubereiten und abkühlen lassen.
    
    2.  Skyr oder Sojajoghurt mit Zucker und Vanilleextrakt glatt rühren.
    
    3.  Löffelbiskuits kurz in Kaffee tauchen.
    
    4.  Biskuits in Auflaufform legen.
    
    5.  Creme darüber verteilen.
    
    6.  Weitere Schicht getränkter Biskuits darauf legen.
    
    7.  Restliche Creme darauf streichen.
    
    8.  Mit Kakaopulver bestäuben.
    
    9.  Mindestens 2 Stunden kalt stellen, dann servieren.
    
    💡 Tipp: Für intensiveren Geschmack etwas Kaffeepulver in die Creme rühren.
    
    """)
                            .font(.body)
                            .padding(.bottom, 20)
                        }//Ende VStackZubereitung
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 120)
                }
                
                ZStack(alignment: .bottom) {
                    BottomBarView()
                    NavigationLink {
                        MakeItVeganView()
                            .navigationBarBackButtonHidden(true)
                            .toolbar(.hidden, for: .navigationBar)
                    } label: {
                        TranslationCenterButton()
                    }
                    .buttonStyle(.plain)
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showShareSheet) {
                RecipeShareSheet(activityItems: [shareText])
            }
        }
    }
}





#Preview {
    TiramisuView(
        recipe: .constant(
            Recipe(
                title: "Tiramisu",
                imageName: "Tiramisu",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}
    
