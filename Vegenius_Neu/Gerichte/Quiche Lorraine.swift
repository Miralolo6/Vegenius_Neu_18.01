//
//  Quiche Lorraine.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct QuicheLorraineView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Quiche Lorraine
    Zutaten:
    🌾 200 g Mehl
    🫒 60 ml Olivenöl
    💧 80 ml Wasser
    🧂 1 Prise Salz
    🧅 1 Zwiebel
    🧄 1 Knoblauchzehe
    🥓 120 g Räuchertofu
    🥣 200 g Seidentofu
    🌾 40 g Kichererbsenmehl
    💧 80 ml Pflanzenmilch
    🧂 Gewürze: Salz, Pfeffer, Muskat
    🌿 Schnittlauch oder Petersilie (optional)


1.  Mehl, Salz, Öl und Wasser zu einem Teig kneten.

2.  Teig in Quiche- oder Springform drücken.

3.  Zwiebel, Knoblauch und Räuchertofu klein schneiden.

4.  In Pfanne 3–4 Min anbraten.

5.  Seidentofu, Kichererbsenmehl, Pflanzenmilch und Gewürze glatt mixen.

6.  Tofu-Zwiebel-Mischung auf dem Teig verteilen.

7.  Tofu-Creme darüber gießen.

8.  Backofen 180 °C, 35–40 Min backen.

9.  Kurz abkühlen lassen, anschneiden und servieren.

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
                                Text("Quiche Lorraine")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Quiche_Lorraine")
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
                                Text("📝 Zutatenliste (für 4 Personen)")
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
                                                    ZutatenRow(emoji: "🌾", text: "200 g Mehl")
                                                    ZutatenRow(emoji: "🫒", text: "60 ml Olivenöl")
                                                    ZutatenRow(emoji: "💧", text: "80 ml Wasser")
                                                    ZutatenRow(emoji: "🧂", text: "1 Prise Salz")
                                                    ZutatenRow(emoji: "🧅", text: "1 Zwiebel")
                                                    ZutatenRow(emoji: "🧄", text: "1 Knoblauchzehe")
                                                    ZutatenRow(emoji: "🥓", text: "120 g Räuchertofu")
                                                    ZutatenRow(emoji: "🥣", text: " 200 g Seidentofu")
                                                    ZutatenRow(emoji: "🌾", text: "40 g Kichererbsenmehl")
                                                    ZutatenRow(emoji: "💧", text: "80 ml Pflanzenmilch")
                                                  ZutatenRow(emoji: "🧂 ", text: "Gewürze: Salz, Pfeffer, Muskat")
                                                  ZutatenRow(emoji: "🌿", text: "Schnittlauch oder Petersilie (optional)")
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: " Mehl, Salz, Öl und Wasser zu einem Teig kneten.")
                                                    ZubereitungRow(nummer: "2.", text: "Teig in Quiche- oder Springform drücken.")
                                                    ZubereitungRow(nummer: "3.", text: "Zwiebel, Knoblauch und Räuchertofu klein schneiden.")
                                                    ZubereitungRow(nummer: "4.", text: "In Pfanne 3–4 Min anbraten.")
                                                    ZubereitungRow(nummer: "5.", text: "Seidentofu, Kichererbsenmehl, Pflanzenmilch und Gewürze glatt mixen.")
                                                    ZubereitungRow(nummer: "6.", text: "Tofu-Zwiebel-Mischung auf dem Teig verteilen.")
                                                    ZubereitungRow(nummer: "7.", text: "Tofu-Creme darüber gießen.")
                                                    ZubereitungRow(nummer: "8.", text: "Backofen 180 °C, 35–40 Min backen.")
                                                    ZubereitungRow(nummer: "9.", text: "Kurz abkühlen lassen, anschneiden und servieren.")
                                                    
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
    QuicheLorraineView(
        recipe: .constant(
            Recipe(
                title: "Quiche Lorraine",
                imageName: "Quiche_Lorraine",
                category: .unter_zwanzig,
                filters: [],
                isFavorite: false,
               // route: .defaultRecipe
            )
        )
    )
}
