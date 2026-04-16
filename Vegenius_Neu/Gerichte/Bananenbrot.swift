//
//  Bananenbrot.swift
//  Vegenius_Neu
//
//  Created by TA620 on 15.03.26.
//

import SwiftUI

struct BananenbrotView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Bananenbrot
    Zutaten:
    🍌 3 reife Bananen
    🌾 200 g glutenfreies Mehl
    🥄 50 g Ahornsirup (oder Agavendicksaft)
    🫒 50 ml Pflanzenöl (z. B. Sonnenblumen- oder Rapsöl)
    💧 50 ml Pflanzenmilch (Hafer- oder Sojamilch, ungesüßt)
    🧂 1 TL Backpulver
    🧂 1 Prise Salz
    🥄 1 TL Zimt (optional)
    🌾 1 TL Leinsamen + 3 TL Wasser


1.  Bananen mit Gabel zerdrücken.

2.  Leinsamen mit Wasser mischen, 5 Min quellen lassen.

3.  Öl, Pflanzenmilch und Ahornsirup zu den Bananen geben, gut verrühren.

4.  Mehl, Backpulver, Salz und Zimt dazugeben, kurz zu einem Teig verrühren.

5.  Teig in eine gefettete oder mit Backpapier ausgelegte Kastenform füllen.

6.  Backofen 180 °C, 40–45 Min backen, Stäbchenprobe machen.

7.  Abkühlen lassen, in Scheiben schneiden.

💡 Tipp: Für extra Saftigkeit Bananen leicht überreif verwenden und den Teig nicht zu lange rühren.


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
                                Text("Bananenbrot")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Bananenbrot")
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
                                Text("📝 Zutatenliste (für 8 Scheiben)")
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
                            Zutaten(text: "🍌 3 reife Bananen")
                            Zutaten(text: "🌾 200 g glutenfreies Mehl")
                            Zutaten(text: "🥄 50 g Ahornsirup (oder Agavendicksaft)")
                            Zutaten(text: "🫒 50 ml Pflanzenöl (z. B. Sonnenblumen- oder Rapsöl)")
                            Zutaten(text: "💧 50 ml Pflanzenmilch (Hafer- oder Sojamilch, ungesüßt)")
                            Zutaten(text: "🧂 1 TL Backpulver")
                            Zutaten(text: "🧂 1 Prise Salz")
                            Zutaten(text: "🥄 1 TL Zimt (optional)")
                            Zutaten(text: "🌾 1 TL Leinsamen + 3 TL Wasser")
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                       
                        // MARK: - Zubereitung
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                            Text("📝 Zubereitung")
                                .font(.headline)
                                .padding(.top)
                            
                            ZubereitungRow(nummer: "1.", text: "Bananen mit Gabel zerdrücken.")
                            ZubereitungRow(nummer: "2.", text: "Leinsamen mit Wasser mischen, 5 Min quellen lassen..")
                            ZubereitungRow(nummer: "3.", text: "Öl, Pflanzenmilch und Ahornsirup zu den Bananen geben, gut verrühren.")
                            ZubereitungRow(nummer: "4.", text: "Mehl, Backpulver, Salz und Zimt dazugeben, kurz zu einem Teig verrühren.")
                            ZubereitungRow(nummer: "5.", text: " Teig in eine gefettete oder mit Backpapier ausgelegte Kastenform füllen.")
                            ZubereitungRow(nummer: "6.", text: "Backofen 180 °C, 40–45 Min backen, Stäbchenprobe machen.")
                            ZubereitungRow(nummer: "7.", text: "Abkühlen lassen, in Scheiben schneiden.")
                          
                            
                            Text("💡 Tipp: Für extra Saftigkeit Bananen leicht überreif verwenden und den Teig nicht zu lange rühren.")
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
    BananenbrotView(
        recipe: .constant(
            Recipe(
                title: "Bananenbrot",
                imageName: "Bananenbrot",
                category: .suess,
                filters: [.nutFree, .glutenFree],
                isFavorite: false
            )
        )
    )
}
    
