//
//  Kimchi-Pancakes.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct KimchiPancakesView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
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

Rezept aus meiner App Vegenius 🙂
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
                            Text("Kimchi-Pancakes\nmit Gochujang-Dip")
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
                    VStack(alignment: .leading, spacing: 10) {
                                                ZutatenRow(emoji: "🌾", text: "150 g Mehl")
                                                ZutatenRow(emoji: "💧", text: "200 ml Wasser")
                                                ZutatenRow(emoji: "🧂", text: "1 Prise Salz")
                                                ZutatenRow(emoji: "🥬", text: "120 g veganes Kimchi")
                                                ZutatenRow(emoji: "🧅", text: "2 Frühlingszwiebeln")
                                                ZutatenRow(emoji: "🫒", text: "1 EL Pflanzenöl (zum Braten)")
                                                ZutatenRow(emoji: "🌶️", text: "1 EL Gochujang")
                                                ZutatenRow(emoji: "🥄", text: "1 TL Ahornsirup oder Zucker")
                                                ZutatenRow(emoji: "💧", text: "1–2 TL Wasser")
                                                ZutatenRow(emoji: "🧂", text: "1 TL Sojasauce")
                                            
                      
                    
                    }//Ende Zutatenliste
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .padding(.bottom, 20)

                    // MARK: - Zubereitung
                    VStack(alignment: .leading, spacing: 12) {
                                                Text("📝 Zubereitung")
                                                    .font(.headline)
                                                    .padding(.top)
                                                
                                                ZubereitungRow(nummer: "1.", text: " Mehl, Wasser und Salz zu glattem Teig verrühren.")
                                                ZubereitungRow(nummer: "2.", text: "Kimchi und Frühlingszwiebeln klein schneiden.")
                                                ZubereitungRow(nummer: "3.", text: "Beides in den Teig rühren.")
                                                ZubereitungRow(nummer: "4.", text: "Öl in Pfanne erhitzen.")
                                                ZubereitungRow(nummer: "5.", text: "Teig portionsweise in Pfanne geben, flach drücken und 3–4 Min pro Seite braten.")
                                                ZubereitungRow(nummer: "6.", text: "Gochujang, Sojasauce, Ahornsirup und Wasser zu Dip verrühren.")
                                                ZubereitungRow(nummer: "7.", text: "Pancakes mit Dip servieren.")
                                                
                                                
                                                Text("💡 Tipp: Der Teig sollte relativ dick sein – sonst werden die Pancakes eher wie dünne Pfannkuchen statt knusprig. ")
                                                    .padding(.top, 5)
                                            }
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
    KimchiPancakesView(
        recipe: .constant(
            Recipe(
                title: "Kimchi-Pancakes\nmit Gochujang-Dip",
                imageName: "Kimchi-Pancakes",
                category: .unter_zwanzig,
                filters: [.nutFree, .highProtein],
                isFavorite: false,
              //  route: .defaultRecipe
            )
        )
    )
}
    
