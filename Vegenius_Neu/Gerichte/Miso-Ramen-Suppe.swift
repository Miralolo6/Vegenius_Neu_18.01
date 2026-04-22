//
//  Miso-Ramen-Suppe.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct MisoRamenSuppeView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Miso-Ramen-Suppe
    Zutaten:
    🍜 200 g Ramen- oder Weizennudeln
    🥣 800 ml Gemüsebrühe
    🥄 2 EL Miso-Paste
    🥓 150 g Räuchertofu
    🥬 100 g Pak Choi oder Spinat
    🧅 2 Frühlingszwiebeln
    🧄 1 Knoblauchzehe
    🫚 1 TL geriebener Ingwer
    🫒 1 TL Sesam- oder Pflanzenöl
    🥄 1 EL Sojasauce


1.  Knoblauch, Ingwer und Frühlingszwiebeln klein schneiden.

2.  Öl im Topf erhitzen, Knoblauch und Ingwer 1–2 Min anbraten.

3.  Gemüsebrühe zugeben und aufkochen lassen.

4.  Nudeln hinzufügen und 4–5 Min kochen.

5.  Räuchertofu würfeln und in die Suppe geben.

6.  Pak Choi oder Spinat zugeben, 2–3 Min mitköcheln.

7.  Miso-Paste mit etwas Brühe verrühren und einrühren.

8.  Mit Sojasauce abschmecken.

9.  In Schüsseln füllen und servieren.

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
                                Text("Miso-Ramen-Suppe")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Miso-Ramen-Suppe")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 260)
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
                        VStack(alignment: .leading, spacing: 10) {
                                                    ZutatenRow(emoji: "🍜", text: "200 g Ramen- oder Weizennudeln")
                                                    ZutatenRow(emoji: "🥣", text: "800 ml Gemüsebrühe")
                                                    ZutatenRow(emoji: "🥄", text: "2 EL Miso-Paste")
                                                    ZutatenRow(emoji: "🥓", text: "150 g Räuchertofu")
                                                    ZutatenRow(emoji: "🥬", text: "100 g Pak Choi oder Spinat")
                                                    ZutatenRow(emoji: "🧅", text: "2 Frühlingszwiebeln")
                                                    ZutatenRow(emoji: "🧄", text: " 1 Knoblauchzehe")
                                                    ZutatenRow(emoji: "🫚", text: "1 TL geriebener Ingwer")
                                                    ZutatenRow(emoji: "🫒", text: "1 TL Sesam- oder Pflanzenöl")
                                                   ZutatenRow(emoji: "🥄", text: "1 EL Sojasauce")
                    
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Knoblauch, Ingwer und Frühlingszwiebeln klein schneiden.")
                                                    ZubereitungRow(nummer: "2.", text: "Öl im Topf erhitzen, Knoblauch und Ingwer 1–2 Min anbraten.")
                                                    ZubereitungRow(nummer: "3.", text: "Gemüsebrühe zugeben und aufkochen lassen.")
                                                    ZubereitungRow(nummer: "4.", text: "Nudeln hinzufügen und 4–5 Min kochen.")
                                                    ZubereitungRow(nummer: "5.", text: "Räuchertofu würfeln und in die Suppe geben.")
                                                    ZubereitungRow(nummer: "6.", text: "Pak Choi oder Spinat zugeben, 2–3 Min mitköcheln.")
                                                    ZubereitungRow(nummer: "7.", text: "Miso-Paste mit etwas Brühe verrühren und einrühren.")
                                                    ZubereitungRow(nummer: "8.", text: "Mit Sojasauce abschmecken.")
                                                    ZubereitungRow(nummer: "9.", text: "In Schüsseln füllen und servieren.")
                                                    Text(" ")
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
    MisoRamenSuppeView(
        recipe: .constant(
            Recipe(
                title: "Miso-Ramen-Suppe",
                imageName: "Miso-Ramen-Suppe",
                category: .unter_zwanzig,
                filters: [.glutenFree],
                isFavorite: false
            )
        )
    )
}
