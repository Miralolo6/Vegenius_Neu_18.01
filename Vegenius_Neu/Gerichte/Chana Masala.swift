//
//  Chana Masala.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct ChanaMasalaView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    //@State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Chana Masala
    Zutaten:
    🧆 400 g Kichererbsen (Dose, abgespült)
    🍅 400 g gehackte Tomaten (Dose)
    🧅 1 Zwiebel
    🧄 2 Knoblauchzehen
    🫚 1 TL geriebener Ingwer
    🫒 1 EL Olivenöl
    🌾 100 g rote Linsen (für extra Protein)
    💧 200 ml Wasser oder Gemüsebrühe
    🧂 Gewürze: 1 TL Garam Masala, 1 TL Kreuzkümmel, 1 TL Paprikapulver, Salz, Pfeffer
    🌿 Frischer Koriander oder Petersilie (optional)


1.  Zwiebel, Knoblauch und Ingwer klein schneiden.

2.  Öl in Topf erhitzen, Zwiebel 2–3 Min anbraten.

3.  Knoblauch, Ingwer und Gewürze zugeben, 1 Min rösten.

4.  Tomaten, Linsen und Wasser einrühren.

5.  10–12 Min köcheln lassen, bis Linsen weich sind.

6.  Kichererbsen zugeben, 5–8 Min weiter köcheln.

7.  Abschmecken und optional Kräuter zugeben.

8.  Servieren.

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
                                Text("Chana Masala")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            )
                            .padding(.horizontal)
                            
                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Chana_Masala")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 350)
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
                                Text("📝 Zutatenliste (für 3 Personen)")
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
                            Zutaten(text: "🧆 400 g Kichererbsen (Dose, abgespült)")
                            Zutaten(text: "🍅 400 g gehackte Tomaten (Dose)")
                            Zutaten(text: "🧅 1 Zwiebel")
                            Zutaten(text: "🧄 2 Knoblauchzehen")
                            Zutaten(text: "🫚 1 TL geriebener Ingwer")
                            Zutaten(text: "🫒 1 EL Olivenöl")
                            Zutaten(text: "🌾 100 g rote Linsen (für extra Protein)")
                            Zutaten(text: "💧 200 ml Wasser oder Gemüsebrühe")
                            Zutaten(text: "🧂 Gewürze: 1 TL Garam Masala, 1 TL Kreuzkümmel, 1 TL Paprikapulver, Salz, Pfeffer")
                            Zutaten(text: "🌿 Frischer Koriander oder Petersilie (optional)")
                            
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
        
    1.  Zwiebel, Knoblauch und Ingwer klein schneiden.
    
    2.  Öl in Topf erhitzen, Zwiebel 2–3 Min anbraten.
    
    3.  Knoblauch, Ingwer und Gewürze zugeben, 1 Min rösten.
    
    4.  Tomaten, Linsen und Wasser einrühren.
    
    5.  10–12 Min köcheln lassen, bis Linsen weich sind.
    
    6.  Kichererbsen zugeben, 5–8 Min weiter köcheln.
    
    7.  Abschmecken und optional Kräuter zugeben.
    
    8.  Servieren.
    
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
    ChanaMasalaView(
        recipe: .constant(
            Recipe(
                title: "Chana Masala",
                imageName: "Chana_Masala",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree, .highProtein],
                isFavorite: false
            )
        )
    )
}
    
