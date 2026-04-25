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
                        VStack(alignment: .leading, spacing: 10) {
                                                    ZutatenRow(emoji: "🌱 ", text:"100 g Sojachunks (trocken)")
                                                    ZutatenRow(emoji: "🌾", text: "160–200 g Couscous")
                                                    ZutatenRow(emoji: "🧅", text: "1 Zwiebel")
                                                    ZutatenRow(emoji: "🧄", text: "1–2 Knoblauchzehen")
                                                    ZutatenRow(emoji: "🫑", text: "1 Paprika (optional)")
                                                    ZutatenRow(emoji: "🫒", text: "1 EL Olivenöl")
                                                    ZutatenRow(emoji: "🥫", text: "1 EL Tomatenmark oder 2 EL Sojasauce")
                                                    ZutatenRow(emoji: "🧂", text: "Gewürze: Salz, Pfeffer, Paprikapulver, optional Chili")
                                                    ZutatenRow(emoji: "💧", text: "ca. 300 ml Gemüsebrühe (für Sojachunks + Couscous)")

                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Sojachunks mit heißer Brühe übergießen, 5–10 Min ziehen lassen, ausdrücken.")
                                                    ZubereitungRow(nummer: "2.", text: " ⁠Zwiebel, Knoblauch (optional Paprika) klein schneiden.")
                                                    ZubereitungRow(nummer: "3.", text: "Öl erhitzen, Gemüse 2–3 Min anbraten. ")
                                                    ZubereitungRow(nummer: "4.", text: "Sojachunks zugeben, knusprig braten.")
                                                    ZubereitungRow(nummer: "5.", text: "Tomatenmark oder Sojasauce + Gewürze einrühren.")
                                                    ZubereitungRow(nummer: "6.", text: "Couscous mit heißer Brühe übergießen, 5 Min quellen lassen, mit Gabel auflockern.")
                                                    ZubereitungRow(nummer: "7.", text: "Couscous mit Soychicken servieren.")
                                                   
                                                    
                                                   
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
    SoychickenMitCouscousView(
        recipe: .constant(
            Recipe(
                title: "Soychicken mit Couscous",
                imageName: "Soychicken Couscous",
                category: .herzhaft,
                filters: [.highProtein],
                isFavorite: false,
               // route: .defaultRecipe
            )
        )
    )
}
