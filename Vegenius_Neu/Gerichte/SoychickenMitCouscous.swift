//
//  SoychickenMitCouscous.swift
//  Vegenius_Neu
//
//  Created by TA620 on 10.03.26.
//


import SwiftUI

struct SoychickenMitCouscousView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Soychicken mit Couscous
    Zutaten:
    🌱 100 g Sojachunks (trocken)
    🌾 160–200 g Couscous
    🧅 1 Zwiebel
    🧄 1–2 Knoblauchzehen
    🫑 1 Paprika (optional)
    🫒 1 EL Olivenöl
    🥫 1 EL Tomatenmark oder 2 EL Sojasauce
    🧂 Gewürze: Salz, Pfeffer, Paprikapulver, optional Chili
    💧 ca. 300 ml Gemüsebrühe (für Sojachunks + Couscous)


1.  Sojachunks mit heißer Brühe übergießen, 5–10 Min ziehen lassen, ausdrücken.

2.  Zwiebel, Knoblauch (optional Paprika) klein schneiden.

3.  Öl erhitzen, Gemüse 2–3 Min anbraten.

4.  Sojachunks zugeben, knusprig braten.

5.  Tomatenmark oder Sojasauce + Gewürze einrühren.

6.  Couscous mit heißer Brühe übergießen, 5 Min quellen lassen, mit Gabel auflockern.

7.  Couscous mit Soychicken servieren.

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
                                Text("Soychicken mit Couscous")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Soychicken Couscous")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 310)
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
                        VStack(alignment: .leading, spacing: 8) {
                            Zutaten(text: "🌱 100 g Sojachunks (trocken)")
                            Zutaten(text: "🌾 160–200 g Couscous")
                            Zutaten(text: "🧅 1 Zwiebel")
                            Zutaten(text: "🧄 1–2 Knoblauchzehen")
                            Zutaten(text: "🫑 1 Paprika (optional)")
                            Zutaten(text: "🫒 1 EL Olivenöl")
                            Zutaten(text: "🥫 1 EL Tomatenmark oder 2 EL Sojasauce")
                            Zutaten(text: "🧂 Gewürze: Salz, Pfeffer, Paprikapulver, optional Chili")
                            Zutaten(text: "💧 ca. 300 ml Gemüsebrühe (für Sojachunks + Couscous)")
                            
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
        
    1.⁠ ⁠Sojachunks mit heißer Brühe übergießen, 5–10 Min ziehen lassen, ausdrücken.
    
    2.⁠ ⁠Zwiebel, Knoblauch (optional Paprika) klein schneiden.
    
    3.⁠ ⁠Öl erhitzen, Gemüse 2–3 Min anbraten. 
    
    4.⁠ ⁠Sojachunks zugeben, knusprig braten.
    
    5.⁠ ⁠Tomatenmark oder Sojasauce + Gewürze einrühren.
    
    6.⁠ ⁠Couscous mit heißer Brühe übergießen, 5 Min quellen lassen, mit Gabel auflockern.
    
    7.⁠ ⁠Couscous mit Soychicken servieren.
    
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
    SoychickenMitCouscousView(
        recipe: .constant(
            Recipe(
                title: "Soychicken mit Couscous",
                imageName: "Soychicken Couscous",
                category: .herzhaft,
                filters: [.highProtein],
                isFavorite: false
            )
        )
    )
}
