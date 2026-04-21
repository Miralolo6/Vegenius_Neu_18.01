//
//  Spaghetti Aglio e Olio.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct SpaghettiView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
   // @State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Spaghetti Aglio e Olio
    Zutaten:
    🍝 200 g Spaghetti
    🧄 3 Knoblauchzehen
    🫒 3 EL Olivenöl
    🌶️ ½ TL Chiliflocken (optional)
    🧂 Salz, Pfeffer
    🌿 1 EL Petersilie (optional)
    💧 2–3 EL Nudelwasser


1.  Spaghetti in Salzwasser 8–10 Min kochen.

2.  Knoblauch in dünne Scheiben schneiden.

3.  Olivenöl in Pfanne erhitzen, Knoblauch 1–2 Min sanft anbraten.

4.  Chiliflocken zugeben.

5.  Gekochte Spaghetti und etwas Nudelwasser in Pfanne geben .

6.  Alles gut vermengen und 1–2 Min schwenken.

7.  Mit Salz, Pfeffer und Petersilie abschmecken.

8.  Servieren.

💡 Tipp: Knoblauch nur leicht goldbraun braten – wird er zu dunkel, schmeckt das Öl bitter.

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
                                Text("Spaghetti Aglio e Olio")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Spaghetti")
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
                        VStack(alignment: .leading, spacing: 8) {
                            Zutaten(text: "🍝 200 g Spaghetti")
                            Zutaten(text: "🧄 3 Knoblauchzehen")
                            Zutaten(text: "🫒 3 EL Olivenöl")
                            Zutaten(text: "🌶️ ½ TL Chiliflocken (optional)")
                            Zutaten(text: "🧂 Salz, Pfeffer")
                            Zutaten(text: "🌿 1 EL Petersilie (optional)")
                            Zutaten(text: "💧 2–3 EL Nudelwasser")
                            
                        }//Ende Zutatenliste
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                                                    Text("📝 Zubereitung")
                                                        .font(.headline)
                                                        .padding(.top)
                                                    
                                                    ZubereitungRow(nummer: "1.", text: "Spaghetti in Salzwasser 8–10 Min kochen.")
                                                    ZubereitungRow(nummer: "2.", text: "Knoblauch in dünne Scheiben schneiden.")
                                                    ZubereitungRow(nummer: "3.", text: "Olivenöl in Pfanne erhitzen, Knoblauch 1–2 Min sanft anbraten.")
                                                    ZubereitungRow(nummer: "4.", text: "Chiliflocken zugeben.")
                                                    ZubereitungRow(nummer: "5.", text: " Gekochte Spaghetti und etwas Nudelwasser in Pfanne geben .")
                                                    ZubereitungRow(nummer: "6.", text: "Alles gut vermengen und 1–2 Min schwenken.")
                                                    ZubereitungRow(nummer: "7.", text: "Mit Salz, Pfeffer und Petersilie abschmecken.")
                                                    ZubereitungRow(nummer: "8.", text: "Servieren.")
                                                    
                                                    Text("💡 Tipp: Knoblauch nur leicht goldbraun braten – wird er zu dunkel, schmeckt das Öl bitter.")
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
    SpaghettiView(
        recipe: .constant(
            Recipe(
                title: "Spaghetti Aglio e Olio",
                imageName: "Spaghetti",
                category: .unter_zwanzig,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}
