//
//  Gemüsegratin mit Zucchini.swift
//  Vegenius_Neu
//
//  Created by TA620 on 15.03.26.
//




import SwiftUI

struct GemüsegratinMitZucchiniView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Gemüsegratin mit Zucchini
    Zutaten:
    🥒 2 kleine Zucchini
    🥕 1 Karotte
    🧅 1 Zwiebel
    🧄 1 Knoblauchzehe
    🍅 100 g passierte Tomaten
    🫒 1 EL Olivenöl
    🧂 Gewürze: Salz, Pfeffer, Paprikapulver, Kräuter nach Wahl (z. B. Thymian, Oregano)
    🌾 50 g glutenfreie Haferflocken
    💧 50 ml Pflanzenmilch (z. B. Hafer- oder Sojamilch, ungesüßt)

1.  Zucchini, Karotte, Zwiebel und Knoblauch klein schneiden.

2.  Öl in Pfanne erhitzen, Zwiebel & Knoblauch 2–3 Min anbraten.

3.  Karotte & Zucchini kurz mitbraten 3–4 Min.

4.  Passierte Tomaten + Gewürze einrühren, 2–3 Min köcheln.

5.  Haferflocken mit Pflanzenmilch mischen, als Topping auf das Gemüse geben.

6.  In Auflaufform füllen, Backofen 180 °C, 20–25 Min backen.

7.  Kurz abkühlen lassen, servieren.

💡 Tipp: Für extra Geschmack kannst du etwas Hefeflocken über das Topping streuen.

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
                                Text("Gemüsegratin mit Zucchini")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Gemüsegratin mit Zucchini")
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
                                                    ZutatenRow(emoji: "🥒", text: "2 kleine Zucchini")
                                                    ZutatenRow(emoji: "🥕", text: "1 Karotte")
                                                    ZutatenRow(emoji: "🧅", text: "1 Zwiebel")
                                                    ZutatenRow(emoji: "🧄", text: "1 Knoblauchzehe")
                                                    ZutatenRow(emoji: "🍅", text: "100 g passierte Tomaten")
                                                    ZutatenRow(emoji: "🫒", text: "1 EL Olivenöl")
                                                    ZutatenRow(emoji: "🧂", text: "Gewürze: Salz, Pfeffer, Paprikapulver, Kräuter nach Wahl (z. B. Thymian, Oregano)")
                                                    ZutatenRow(emoji: "🌾", text: "50 g glutenfreie Haferflocken")
                                                    ZutatenRow(emoji: "💧", text: "50 ml Pflanzenmilch (z. B. Hafer- oder Sojamilch, ungesüßt)")
                                                
                        
                          
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Zucchini, Karotte, Zwiebel und Knoblauch klein schneiden.")
                                                    ZubereitungRow(nummer: "2.", text: "Öl in Pfanne erhitzen, Zwiebel & Knoblauch 2–3 Min anbraten.")
                                                    ZubereitungRow(nummer: "3.", text: "Karotte & Zucchini kurz mitbraten 3–4 Min.")
                                                    ZubereitungRow(nummer: "4.", text: "Passierte Tomaten + Gewürze einrühren, 2–3 Min köcheln.")
                                                    ZubereitungRow(nummer: "5.", text: "Haferflocken mit Pflanzenmilch mischen, als Topping auf das Gemüse geben.")
                                                    ZubereitungRow(nummer: "6.", text: "In Auflaufform füllen, Backofen 180 °C, 20–25 Min backen.")
                                                    ZubereitungRow(nummer: "7.", text: "Kurz abkühlen lassen, servieren.")
                                                    
                                                    Text("💡 Tipp: Für extra Geschmack kannst du etwas Hefeflocken über das Topping streuen.")
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
    GemüsegratinMitZucchiniView(
        recipe: .constant(
            Recipe(
                title: "Gemüsegratin mit Zucchini",
                imageName: "Gemüsegratin mit Zucchini",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree],
                isFavorite: false
            )
        )
    )
}
