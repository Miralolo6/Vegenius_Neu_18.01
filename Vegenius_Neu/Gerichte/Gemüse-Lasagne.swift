//
//  Gemüse-Lasagne.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct GemueseLasagneView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
   // @State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Gemüse-Lasagne
    Zutaten:
    🍝 200 g glutenfreie Lasagneplatten
    🥒 1 Zucchini
    🥕 1 Karotte
    🫑 1 Paprika
    🧅 1 Zwiebel
    🧄 1 Knoblauchzehe
    🍅 400 g gehackte Tomaten (Dose)
    🫒 1 EL Olivenöl
    💧 150 ml Pflanzenmilch
    🌾 1 EL Maisstärke
    🧂 Gewürze: Salz, Pfeffer, Oregano oder Basilikum


1.  Zucchini, Karotte, Paprika, Zwiebel und Knoblauch klein schneiden.

2.  Öl in Pfanne erhitzen, Zwiebel und Knoblauch 2–3 Min anbraten.

3.  Restliches Gemüse zugeben, 4–5 Min braten.

4.  Gehackte Tomaten und Gewürze einrühren, 5 Min köcheln lassen.

5.  Pflanzenmilch mit Maisstärke verrühren, in kleinem Topf 2–3 Min erhitzen bis dicklich.

6.  In Auflaufform schichten: Gemüsesauce → Lasagneplatten → Sauce → wiederholen.

7.  Weiße Sauce darüber verteilen.

8.  Backofen 180 °C, 30–35 Min backen.

9.  Kurz abkühlen lassen, servieren.

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
                                Text("Gemüse-Lasagne")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Gemüse-Lasagne")
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
                                Text("📝 Zutatenliste (für 3 Personen)")
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
                            Zutaten(text: "🍝 200 g glutenfreie Lasagneplatten")
                            Zutaten(text: "🥒 1 Zucchini")
                            Zutaten(text: "🥕 1 Karotte")
                            Zutaten(text: "🫑 1 Paprika")
                            Zutaten(text: "🧅 1 Zwiebel")
                            Zutaten(text: "🧄 1 Knoblauchzehe")
                            Zutaten(text: "🍅 400 g gehackte Tomaten (Dose)")
                            Zutaten(text: "🫒 1 EL Olivenöl")
                            Zutaten(text: "💧 150 ml Pflanzenmilch")
                            Zutaten(text: "🌾 1 EL Maisstärke")
                            Zutaten(text: "🧂 Gewürze: Salz, Pfeffer, Oregano oder Basilikum")
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Zucchini, Karotte, Paprika, Zwiebel und Knoblauch klein schneiden.")
                                                    ZubereitungRow(nummer: "2.", text: "Öl in Pfanne erhitzen, Zwiebel und Knoblauch 2–3 Min anbraten.")
                                                    ZubereitungRow(nummer: "3.", text: "Restliches Gemüse zugeben, 4–5 Min braten.")
                                                    ZubereitungRow(nummer: "4.", text: "Gehackte Tomaten und Gewürze einrühren, 5 Min köcheln lassen.")
                                                    ZubereitungRow(nummer: "5.", text: "Pflanzenmilch mit Maisstärke verrühren, in kleinem Topf 2–3 Min erhitzen bis dicklich.")
                                                    ZubereitungRow(nummer: "6.", text: "In Auflaufform schichten: Gemüsesauce → Lasagneplatten → Sauce → wiederholen.")
                                                    ZubereitungRow(nummer: "7.", text: "Weiße Sauce darüber verteilen.")
                                                    ZubereitungRow(nummer: "8.", text: " Backofen 180 °C, 30–35 Min backen.")
                                                    ZubereitungRow(nummer: "9.", text: "Kurz abkühlen lassen, servieren. ")
                                                 
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
    GemueseLasagneView(
        recipe: .constant(
            Recipe(
                title: "Gemüse-Lasagne",
                imageName: "Gemüse-Lasagne",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree],
                isFavorite: false
            )
        )
    )
}

