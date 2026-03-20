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

Rezept aus meiner App 🙂
"""

    var body: some View {
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
                    VStack(alignment: .leading, spacing: 8) {
                        Zutaten(text: "🥒 2 kleine Zucchini")
                        Zutaten(text: "🥕 1 Karotte")
                        Zutaten(text: "🧅 1 Zwiebel")
                        Zutaten(text: "🧄 1 Knoblauchzehe")
                        Zutaten(text: "🍅 100 g passierte Tomaten")
                        Zutaten(text: "🫒 1 EL Olivenöl")
                        Zutaten(text: "🧂 Gewürze: Salz, Pfeffer, Paprikapulver, Kräuter nach Wahl (z. B. Thymian, Oregano)")
                        Zutaten(text: "🌾 50 g glutenfreie Haferflocken")
                        Zutaten(text: "💧 50 ml Pflanzenmilch (z. B. Hafer- oder Sojamilch, ungesüßt)")
                    
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
    
1.  Zucchini, Karotte, Zwiebel und Knoblauch klein schneiden.

2.  Öl in Pfanne erhitzen, Zwiebel & Knoblauch 2–3 Min anbraten.

3.  Karotte & Zucchini kurz mitbraten 3–4 Min.

4.  Passierte Tomaten + Gewürze einrühren, 2–3 Min köcheln.

5.  Haferflocken mit Pflanzenmilch mischen, als Topping auf das Gemüse geben.

6.  In Auflaufform füllen, Backofen 180 °C, 20–25 Min backen.

7.  Kurz abkühlen lassen, servieren.

💡 Tipp: Für extra Geschmack kannst du etwas Hefeflocken über das Topping streuen.


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
                TranslationCenterButton()
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showShareSheet) {
            RecipeShareSheet(activityItems: [shareText])
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
