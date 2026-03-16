//
//  Kimchi-Pancakes.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct KimchiPancakesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Kimchi-Pancakes mit Gochujang-Dip
    Zutaten:
    🌾 150 g Mehl
    💧 200 ml Wasser
    🧂 1 Prise Salz
    🥬 120 g veganes Kimchi
    🧅 2 Frühlingszwiebeln
    🫒 1 EL Pflanzenöl (zum Braten)
    🌶️ 1 EL Gochujang
    🥄 1 TL Ahornsirup oder Zucker
    💧 1–2 TL Wasser
    🧂 1 TL Sojasauce


1.  Mehl, Wasser und Salz zu glattem Teig verrühren.

2.  Kimchi und Frühlingszwiebeln klein schneiden.

3.  Beides in den Teig rühren.

4.  Öl in Pfanne erhitzen.

5.  Teig portionsweise in Pfanne geben, flach drücken und 3–4 Min pro Seite braten.

6.  Gochujang, Sojasauce, Ahornsirup und Wasser zu Dip verrühren.

7.  Pancakes mit Dip servieren.

💡 Tipp: Der Teig sollte relativ dick sein – sonst werden die Pancakes eher wie dünne Pfannkuchen statt knusprig.

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
                            Text("Kimchi-Pancakes mit Gochujang-Dip")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        )
                        .padding(.horizontal)

                        // Bild + Favorit
                        ZStack(alignment: .topTrailing) {
                            Image("Kimchi-Pancakes")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 290)
                                .clipped()

                            Button {
                                isFavorite.toggle()
                            } label: {
                                Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
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
                            Text("📝 Zutatenliste (für 2-3 Personen)")
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
                        Zutaten(text: "🌾 150 g Mehl")
                        Zutaten(text: "💧 200 ml Wasser")
                        Zutaten(text: "🧂 1 Prise Salz")
                        Zutaten(text: "🥬 120 g veganes Kimchi")
                        Zutaten(text: "🧅 2 Frühlingszwiebeln")
                        Zutaten(text: "🫒 1 EL Pflanzenöl (zum Braten)")
                        Zutaten(text: "🌶️ 1 EL Gochujang")
                        Zutaten(text: "🥄 1 TL Ahornsirup oder Zucker")
                        Zutaten(text: "💧 1–2 TL Wasser")
                        Zutaten(text: "🧂 1 TL Sojasauce")
                    
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
    
1.  Mehl, Wasser und Salz zu glattem Teig verrühren.

2.  Kimchi und Frühlingszwiebeln klein schneiden.

3.  Beides in den Teig rühren.

4.  Öl in Pfanne erhitzen.

5.  Teig portionsweise in Pfanne geben, flach drücken und 3–4 Min pro Seite braten.

6.  Gochujang, Sojasauce, Ahornsirup und Wasser zu Dip verrühren.

7.  Pancakes mit Dip servieren.

💡 Tipp: Der Teig sollte relativ dick sein – sonst werden die Pancakes eher wie dünne Pfannkuchen statt knusprig.

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
        .sheet(isPresented: $showShareSheet) {
            RecipeShareSheet(activityItems: [shareText])
        }
    }
}





#Preview {
    KimchiPancakesView()
}
    
