//
//  Zitronen-Blaubeer-Torte.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct ZitronenBlaubeerTorteView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Zitronen-Blaubeer-Torte
    Zutaten:
    🌾 250 g Mehl
    🥄 120 g Zucker
    🧂 1 Prise Salz
    🧂 1 Päckchen Backpulver (15 g)
    🍋 1 Zitrone (Saft + Abrieb)
    💧 200 ml Pflanzenmilch
    🫒 80 ml Pflanzenöl
    🫐 150 g Blaubeeren
    🧂 1 EL Puderzucker (optional zum Bestäuben)


1.  Backofen auf 180 °C vorheizen.

2.  Mehl, Zucker, Salz und Backpulver in Schüssel mischen.

3.  Pflanzenmilch, Öl, Zitronensaft und Zitronenabrieb zugeben, kurz verrühren.

4.  Blaubeeren vorsichtig unterheben.

5.  Teig in gefettete oder mit Backpapier ausgelegte Form füllen.

6.  Backofen 180 °C, 35–40 Min backen.

7.  Abkühlen lassen, optional mit Puderzucker bestäuben.

8.  In Stücke schneiden und servieren.  

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
                                Text("Zitronen-Blaubeer-Torte")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Zitronen-Blaubeer-Torte")
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
                                Text("📝 Zutatenliste (für 8 Stück)")
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
                            Zutaten(text: "🌾 250 g Mehl")
                            Zutaten(text: "🥄 120 g Zucker")
                            Zutaten(text: "🧂 1 Prise Salz")
                            Zutaten(text: "🧂 1 Päckchen Backpulver (15 g)")
                            Zutaten(text: "🍋 1 Zitrone (Saft + Abrieb)")
                            Zutaten(text: "💧 200 ml Pflanzenmilch")
                            Zutaten(text: "🫒 80 ml Pflanzenöl")
                            Zutaten(text: "🫐 150 g Blaubeeren")
                            Zutaten(text: "🧂 1 EL Puderzucker (optional zum Bestäuben)")
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Backofen auf 180 °C vorheizen.")
                                                    ZubereitungRow(nummer: "2.", text: "Mehl, Zucker, Salz und Backpulver in Schüssel mischen.")
                                                    ZubereitungRow(nummer: "3.", text: "Pflanzenmilch, Öl, Zitronensaft und Zitronenabrieb zugeben, kurz verrühren.")
                                                    ZubereitungRow(nummer: "4.", text: "Blaubeeren vorsichtig unterheben.")
                                                    ZubereitungRow(nummer: "5.", text: "Teig in gefettete oder mit Backpapier ausgelegte Form füllen.")
                                                    ZubereitungRow(nummer: "6.", text: "Backofen 180 °C, 35–40 Min backen.")
                                                    ZubereitungRow(nummer: "7.", text: "Abkühlen lassen, optional mit Puderzucker bestäuben.")
                                                    ZubereitungRow(nummer: "8.", text: "In Stücke schneiden und servieren.")
                                                    
                                                   
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
    ZitronenBlaubeerTorteView(
        recipe: .constant(
            Recipe(
                title: "Zitronen-Blaubeer-Torte",
                imageName: "Zitronen-Blaubeer-Torte",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}

    
