//
//  Chocolate Chip Cookies.swift
//  Vegenius_Neu
//
//  Created by TA620 on 15.03.26.
//

import SwiftUI

struct ChocolateChipCookiesView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
   // @State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Chocolate Chip Cookies
    Zutaten:
    🌾 150 g Mehl
    🥄 50 g Rohrzucker oder Kokosblütenzucker
    🥄 50 g brauner Zucker
    🫒 60 ml Pflanzenöl
    💧 50 ml Pflanzenmilch (Hafer- oder Sojamilch)
    🧂 1 Prise Salz
    🥄 1 TL Vanilleextrakt
    🧂 1 TL Backpulver
    🍫 50–70 g vegane, nussfreie Schokotropfen


1.  Zucker, Öl, Pflanzenmilch und Vanilleextrakt verrühren.

2.  Mehl, Backpulver und Salz mischen, dann kurz unter die feuchten Zutaten rühren.

3.  Schokotropfen unterheben.

4.  Teig in Portionen auf Backblech setzen, leicht flachdrücken.

5.  Backofen 180 °C, 10–12 Min backen.

6.  Kurz abkühlen lassen, servieren.

💡 Tipp: Nicht zu lange backen – außen knusprig, innen weich.

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
                                Text("Chocolate Chip Cookies")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Chocolate Chip Cookies")
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
                                Text("📝 Zutatenliste (für 12–14 Cookies)")
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
                            Zutaten(text: "🥄 50 g Rohrzucker oder Kokosblütenzucker")
                            Zutaten(text: "🥄 50 g brauner Zucker")
                            Zutaten(text: "🫒 60 ml Pflanzenöl")
                            Zutaten(text: "💧 50 ml Pflanzenmilch (Hafer- oder Sojamilch)")
                            Zutaten(text: "🧂 1 Prise Salz")
                            Zutaten(text: "🥄 1 TL Vanilleextrakt")
                            Zutaten(text: "🧂 1 TL Backpulver")
                            Zutaten(text: "🍫 50–70 g vegane, nussfreie Schokotropfen")
                            
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
        
        1.  Zucker, Öl, Pflanzenmilch und Vanilleextrakt verrühren.
        
        2.  Mehl, Backpulver und Salz mischen, dann kurz unter die feuchten Zutaten rühren.
        
        3.  Schokotropfen unterheben.
        
        4.  Teig in Portionen auf Backblech setzen, leicht flachdrücken.
        
        5.  Backofen 180 °C, 10–12 Min backen.
        
        6.  Kurz abkühlen lassen, servieren.
        
        💡 Tipp: Nicht zu lange backen – außen knusprig, innen weich.
        
        
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
    ChocolateChipCookiesView(
        recipe: .constant(
            Recipe(
                title: "Chocolate Chip Cookies",
                imageName: "Chocolate Chip Cookies",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}
    
