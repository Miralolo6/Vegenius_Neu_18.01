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
                        VStack(alignment: .leading, spacing: 10) {
                            ZutatenRow(emoji: "🌾", text: "150 g Mehl")
                            ZutatenRow(emoji: "🥄", text: "50 g Rohrzucker oder Kokosblütenzucker")
                            ZutatenRow(emoji: "🥄", text: "50 g brauner Zucker")
                            ZutatenRow(emoji: "🫒", text: "60 ml Pflanzenöl")
                            ZutatenRow(emoji: "💧", text: "50 ml Pflanzenmilch (Hafer- oder Sojamilch)")
                            ZutatenRow(emoji: "🧂", text: "1 Prise Salz")
                            ZutatenRow(emoji: "🥄", text: "1 TL Vanilleextrakt")
                            ZutatenRow(emoji: "🧂", text: "1 TL Backpulver")
                            ZutatenRow(emoji: "🍫", text: "50–70 g vegane, nussfreie Schokotropfen")
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("📝 Zubereitung")
                                .font(.headline)
                                .padding(.top)
                            
                            ZubereitungRow(nummer: "1.", text: "Zucker, Öl, Pflanzenmilch und Vanilleextrakt verrühren.")
                            ZubereitungRow(nummer: "2.", text: "Mehl, Backpulver und Salz mischen, dann kurz unter die feuchten Zutaten rühren.")
                            
                            ZubereitungRow(nummer: "3.", text: "Schokotropfen unterheben.")
                            ZubereitungRow(nummer: "4.", text: "Teig in Portionen auf Backblech setzen, leicht flachdrücken")
                            ZubereitungRow(nummer: "5.", text: "Backofen 180 °C, 10–12 Min backen.")
                            ZubereitungRow(nummer: "6.", text: " Kurz abkühlen lassen, servieren.")
                            
                            Text("💡 Tipp: Nicht zu lange backen – außen knusprig, innen weich. ")
                                .padding(.top, 5)
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
    
    
    
} // Ende von ChocolateChipCookiesView





// 👇 GANZ UNTEN!
#Preview {
    ChocolateChipCookiesView(
        recipe: .constant(
            Recipe(
                title: "Chocolate Chip Cookies",
                imageName: "Chocolate Chip Cookies",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false,
                //route: .defaultRecipe
            )
        )
    )
}
