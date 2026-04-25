//
//  Zimtschnecken.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct ZimtschneckenView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Zimtschnecken
    Zutaten:
    🌾 250 g Mehl
    🥄 40 g weißer Zucker
    🥄 40 g brauner Zucker
    🧂 1 Prise Salz
    🧂 1 Päckchen Trockenhefe (7 g)
    💧 150 ml Pflanzenmilch
    🫒 60 ml Pflanzenöl
    🥄 1–2 TL Zimt


1.  Pflanzenmilch leicht erwärmen.

2.  Mehl, Zucker, Salz und Hefe in Schüssel mischen.

3.  Pflanzenmilch und 40 ml Öl zugeben, 5–8 Min zu Teig kneten.

4.  Teig abdecken, 30–45 Min gehen lassen.

5.  Teig rechteckig ausrollen.

6.  Mit restlichem Öl bestreichen, braunen Zucker und Zimt darauf streuen.

7.  Teig aufrollen und in Stücke schneiden.

8.  In Auflaufform legen, 10–15 Min ruhen lassen.

9.  Backofen 180 °C, 20–25 Min backen.

💡 Tipp: Noch warm mit etwas Puderzucker oder einfachem Zuckerguss servieren.


Rezept aus meiner App Vegenius🙂
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
                                Text("Zimtschnecken")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Zimtschnecken")
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
                                Text("📝 Zutatenliste (für ca. 8 Stück)")
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
                                                    ZutatenRow(emoji: "🌾", text: "250 g Mehl")
                                                    ZutatenRow(emoji: "🥄", text: "40 g weißer Zucker")
                                                    ZutatenRow(emoji: "🥄", text: "40 g brauner Zucker")
                                                    ZutatenRow(emoji: "🧂", text: "1 Prise Salz")
                                                    ZutatenRow(emoji: "🧂", text: "1 Päckchen Trockenhefe (7 g)")
                                                    ZutatenRow(emoji: "💧", text: "150 ml Pflanzenmilch")
                                                    ZutatenRow(emoji: "🫒", text: "60 ml Pflanzenöl")
                          
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Pflanzenmilch leicht erwärmen.")
                                                    ZubereitungRow(nummer: "2.", text: "Mehl, Zucker, Salz und Hefe in Schüssel mischen.")
                                                    ZubereitungRow(nummer: "3.", text: "Pflanzenmilch und 40 ml Öl zugeben, 5–8 Min zu Teig kneten.")
                                                    ZubereitungRow(nummer: "4.", text: "Teig abdecken, 30–45 Min gehen lassen.")
                                                    ZubereitungRow(nummer: "5.", text: "Teig rechteckig ausrollen.")
                                                    ZubereitungRow(nummer: "6.", text: "Mit restlichem Öl bestreichen, braunen Zucker und Zimt darauf streuen.")
                                                    ZubereitungRow(nummer: "7.", text: "Teig aufrollen und in Stücke schneiden.")
                                                    ZubereitungRow(nummer: "8.", text: "In Auflaufform legen, 10–15 Min ruhen lassen.")
                                                    ZubereitungRow(nummer: "9.", text: "Backofen 180 °C, 20–25 Min backen.")
                                                    Text("💡 Tipp: Noch warm mit etwas Puderzucker oder einfachem Zuckerguss servieren.")
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
    ZimtschneckenView(
        recipe: .constant(
            Recipe(
                title: "Zimtschnecken",
                imageName: "Zimtschnecken",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false,
               // route: .defaultRecipe
            )
        )
    )
}

