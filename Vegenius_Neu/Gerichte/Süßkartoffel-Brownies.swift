//
//  Süßkartoffel-Brownies.swift
//  Vegenius_Neu
//
//  Created by TA620 on 15.03.26.
//

import SwiftUI

struct SuesskartorffelBrowniesView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Süßkartoffel-Brownies
    Zutaten:
    🍠 250 g Süßkartoffeln (gekocht oder gedämpft)
    🌾 50 g Lupinenmehl
    🥄 50 g Ahornsirup oder Agavendicksaft
    🫒 30 ml Pflanzenöl
    💧 30 ml Pflanzenmilch
    🍫 50 g vegane, nussfreie Schokotropfen
    🧂 1 Prise Salz
    🥄 1 TL Vanilleextrakt
    🥄 1 TL Backpulver (optional, für etwas Lockerung)
    🥄 2 EL Kakaopulver

1.  Süßkartoffeln weich kochen und pürieren.

2.  Öl, Pflanzenmilch, Ahornsirup und Vanilleextrakt verrühren, zu Süßkartoffelpüree geben.

3.  Mehl, Kakaopulver, Backpulver und Salz mischen, unter die feuchten Zutaten rühren.

4.  Schokotropfen unterheben 🍫.

5.  Teig in gefettete oder mit Backpapier ausgelegte Form füllen.

6.  Backofen 180 °C, 20–25 Min backen.

7.  Abkühlen lassen, in Stücke schneiden und servieren.

💡 Tipp: Für extra saftige Brownies nicht zu lange backen – Kern darf noch leicht feucht sein.

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
                                Text("Süßkartoffel-Brownies")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Süßkartoffel Brownies")
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
                                Text("📝 Zutatenliste (für 12 Stücke)")
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
                                                    ZutatenRow(emoji: "🍠", text: "250 g Süßkartoffeln (gekocht oder gedämpft)")
                                                    ZutatenRow(emoji: "🌾", text: "50 g Lupinenmehl")
                                                    ZutatenRow(emoji: "🥄", text: "50 g Ahornsirup oder Agavendicksaft")
                                                    ZutatenRow(emoji: "🫒", text: "30 ml Pflanzenöl")
                                                    ZutatenRow(emoji: "💧", text: "30 ml Pflanzenmilch")
                                                    ZutatenRow(emoji: "🍫", text: "50 g vegane, nussfreie Schokotropfen")
                                                    ZutatenRow(emoji: "🧂", text: "1 Prise Salz")
                                                    ZutatenRow(emoji: "🥄", text: "1 TL Vanilleextrakt")
                                                    ZutatenRow(emoji: "🥄", text: "1 TL Backpulver (optional)")
                                                    ZutatenRow(emoji: "🥄", text: "2 EL Kakaopulver")
                            
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Süßkartoffeln weich kochen und pürieren.")
                                                    ZubereitungRow(nummer: "2.", text: "Öl, Pflanzenmilch, Ahornsirup und Vanilleextrakt verrühren, zu Süßkartoffelpüree geben.")
                                                    ZubereitungRow(nummer: "3.", text: "Mehl, Kakaopulver, Backpulver und Salz mischen, unter die feuchten Zutaten rühren.")
                                                    ZubereitungRow(nummer: "4.", text: "Schokotropfen unterheben.")
                                                    ZubereitungRow(nummer: "5.", text: "Teig in gefettete oder mit Backpapier ausgelegte Form füllen.")
                                                    ZubereitungRow(nummer: "6.", text: " Backofen 180 °C, 20–25 Min backen.")
                                                    ZubereitungRow(nummer: "7.", text: "Abkühlen lassen, in Stücke schneiden und servieren.")
                                                 
                                                    
                                                    Text("💡 Tipp: Für extra saftige Brownies nicht zu lange backen – Kern darf noch leicht feucht sein. ")
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
    SuesskartorffelBrowniesView(
        recipe: .constant(
            Recipe(
                title: "Süßkartoffel-Brownies",
                imageName: "Süßkartoffel Brownies",
                category: .suess,
                filters: [.glutenFree, .lowCarb],
                isFavorite: false,
               // route: .defaultRecipe
            )
        )
    )
}

