//
//  Pasta mit Pistazienpesto & Pilzen.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct PistazienPestoView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Pasta mit Pistazienpesto & Pilzen
    Zutaten:
    🍝 200 g Pasta
    🍄 200 g Champignons
    🧄 1 Knoblauchzehe
    🌿 30 g Basilikum
    🥜 40 g Pistazien
    🫒 3 EL Olivenöl
    🍋 1 TL Zitronensaft
    🧂 Salz, Pfeffer
    💧 2–3 EL Nudelwasser


1.  Pasta in Salzwasser 8–10 Min kochen.

2.  Pistazien, Basilikum, Knoblauch, Olivenöl und Zitronensaft zu Pesto mixen.

3.  Champignons in Scheiben schneiden.

4.  Pilze in Pfanne 4–5 Min anbraten.

5.  Gekochte Pasta und etwas Nudelwasser zu den Pilzen geben.

6.  Pesto unterrühren und alles gut vermengen.

7.  Mit Salz und Pfeffer abschmecken.

8.  Servieren.

💡 Tipp: Etwas Zitronenabrieb im Pesto macht das Gericht frischer.

Rezept aus meiner App Vegenius 🙂
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
                                Text("Pasta mit Pistazienpesto & Pilzen")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Pistazienpesto")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 290)
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
                                Text("📝 Zutatenliste (für 2 Personen)")
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
                                                    ZutatenRow(emoji: "🍝", text: "200 g Pasta")
                                                    ZutatenRow(emoji: "🍄", text: "200 g Champignons")
                                                    ZutatenRow(emoji: "🧄", text: "1 Knoblauchzehe")
                                                    ZutatenRow(emoji: "🌿", text: "30 g Basilikum")
                                                    ZutatenRow(emoji: "🥜", text: "40 g Pistazien")
                                                    ZutatenRow(emoji: "🫒", text: "3 EL Olivenöl")
                                                    ZutatenRow(emoji: "🍋", text: "1 TL Zitronensaft")
                                                    ZutatenRow(emoji: "🧂", text: "Salz, Pfeffer")
                                                    ZutatenRow(emoji: "💧", text: "2–3 EL Nudelwasser")
                                                
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        
                
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                            Text("📝 Zubereitung")
                                                .font(.headline)
                                                .padding(.top)
                                            
                                            ZubereitungRow(nummer: "1.", text: "Pasta in Salzwasser 8–10 Min kochen.")
                                            ZubereitungRow(nummer: "2.", text: "Pistazien, Basilikum, Knoblauch, Olivenöl und Zitronensaft zu Pesto mixen.")
                                            ZubereitungRow(nummer: "3.", text: "Champignons in Scheiben schneiden.")
                                            ZubereitungRow(nummer: "4.", text: "Pilze in Pfanne 4–5 Min anbraten.")
                                            ZubereitungRow(nummer: "5.", text: "Gekochte Pasta und etwas Nudelwasser zu den Pilzen geben.")
                                            ZubereitungRow(nummer: "6.", text: "Pesto unterrühren und alles gut vermengen.")
                                            ZubereitungRow(nummer: "7.", text: "Mit Salz und Pfeffer abschmecken.")
                                                .padding(.top, 5)
                                        }
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
    PistazienPestoView(
        recipe: .constant(
            Recipe(
                title: "Pasta mit Pistazienpesto & Pilzen",
                imageName: "Pistazienpesto",
                category: .unter_zwanzig,
                filters: [],
                isFavorite: false,
               // route: .defaultRecipe
            )
        )
    )
}
