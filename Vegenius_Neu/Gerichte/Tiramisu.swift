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

Rezept aus meiner App Vegenius🙂
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
                        VStack(alignment: .leading, spacing: 10) {
                                                    ZutatenRow(emoji: "🍪", text: "200 g vegane Löffelbiskuits (nussfrei)")
                                                    ZutatenRow(emoji: "☕", text: "200 ml starker Kaffee (abgekühlt)")
                                                    ZutatenRow(emoji: "🥣", text: "400 g veganer Skyr oder Sojajoghurt")
                                                    ZutatenRow(emoji: "🥄", text: "40 g Zucker")
                                                    ZutatenRow(emoji: "🥄", text: "1 TL Vanilleextrakt")
                                                    ZutatenRow(emoji: "🧂", text: "🧂 1–2 EL Kakaopulver")
                                    
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Kaffee zubereiten und abkühlen lassen.")
                                                    ZubereitungRow(nummer: "2.", text: " Skyr oder Sojajoghurt mit Zucker und Vanilleextrakt glatt rühren.")
                                                    ZubereitungRow(nummer: "3.", text: "Löffelbiskuits kurz in Kaffee tauchen.")
                                                    ZubereitungRow(nummer: "4.", text: "Biskuits in Auflaufform legen.")
                                                    ZubereitungRow(nummer: "5.", text: "Creme darüber verteilen.")
                                                    ZubereitungRow(nummer: "6.", text: "Weitere Schicht getränkter Biskuits darauf legen.")
                                                    ZubereitungRow(nummer: "7.", text: "Restliche Creme darauf streichen.")
                                                    ZubereitungRow(nummer: "8.", text: "Mit Kakaopulver bestäuben.")
                                                    ZubereitungRow(nummer: "9.", text: "Mindestens 2 Stunden kalt stellen, dann servieren.")
                                                    Text(" 💡 Tipp: Für intensiveren Geschmack etwas Kaffeepulver in die Creme rühren.")
                                                        .padding(.top, 5)
                                                }
                                                .padding(.horizontal)
                                            }
                                            .padding(.bottom, 120)
                                        }
                           
                ZStack(alignment: .bottom) {
                    BottomBarView()
                    NavigationLink {
                        MakeItVeganView2()
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
                isFavorite: false,
            //    route: .defaultRecipe
            )
        )
    )
}
    
