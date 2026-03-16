//
//  Tex-Mex-Salat.swift
//  Vegenius_Neu
//
//  Created by TA620 on 16.03.26.
//

import SwiftUI

struct TexMexSalatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isFavorite: Bool = false
    @State private var showShareSheet = false
    
    let shareText = """
Tex-Mex-Salat
    Zutaten:
    🥬 150 g Blattsalat (z. B. Römersalat)
    🧆 200 g schwarze Bohnen (Dose, abgespült)
    🌽 150 g Mais
    🍅 150 g Cherrytomaten
    🫑 1 Paprika
    🧅 1 kleine rote Zwiebel
    🥑 1 Avocado
    🫒 2 EL Olivenöl
    🍋 2 EL Limetten- oder Zitronensaft
    🧂 Gewürze: 1 TL Kreuzkümmel, 1 TL Paprikapulver, Salz, Pfeffer
    🥄 1 TL Ahornsirup
    🌶️ ½ TL Chili (optional)


1.  Salat, Paprika, Zwiebel und Tomaten klein schneiden.

2.  Bohnen und Mais abspülen.

3.  Alles in große Schüssel geben.

4.  Avocado würfeln und zugeben.

5.  Olivenöl, Limettensaft, Ahornsirup und Gewürze zugeben.

6.  Alles gut vermengen.

7.  Abschmecken und servieren.

💡 Tipp: Für noch mehr Protein kannst du gewürfelten Tofu oder gekochte Quinoa hinzufügen.

Rezept aus meiner App 🙂
"""

    var body: some View {
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
                            Text("Tex-Mex-Salat")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        )
                        .padding(.horizontal)

                        // Bild + Favorit
                        ZStack(alignment: .topTrailing) {
                            Image("Tex-Mex-Salat")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 320)
                                .clipped()

                            Button {
                                isFavorite.toggle()
                            } label: {
                                Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
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
                        Zutaten(text: "🥬 150 g Blattsalat (z. B. Römersalat)")
                        Zutaten(text: "🧆 200 g schwarze Bohnen (Dose, abgespült)")
                        Zutaten(text: "🌽 150 g Mais")
                        Zutaten(text: "🍅 150 g Cherrytomaten")
                        Zutaten(text: "🫑 1 Paprika")
                        Zutaten(text: "🧅 1 kleine rote Zwiebel")
                        Zutaten(text: "🥑 1 Avocado")
                        Zutaten(text: "🫒 2 EL Olivenöl")
                        Zutaten(text: "🍋 2 EL Limetten- oder Zitronensaft")
                        Zutaten(text: "🧂 Gewürze: 1 TL Kreuzkümmel, 1 TL Paprikapulver, Salz, Pfeffer")
                        Zutaten(text: "🥄 1 TL Ahornsirup")
                        Zutaten(text: "🌶️ ½ TL Chili (optional)")

                    
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
    
1.  Salat, Paprika, Zwiebel und Tomaten klein schneiden.

2.  Bohnen und Mais abspülen.

3.  Alles in große Schüssel geben.

4.  Avocado würfeln und zugeben.

5.  Olivenöl, Limettensaft, Ahornsirup und Gewürze zugeben.

6.  Alles gut vermengen.

7.  Abschmecken und servieren.

💡 Tipp: Für noch mehr Protein kannst du gewürfelten Tofu oder gekochte Quinoa hinzufügen.

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
                TranslationCenterButton()
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showShareSheet) {
            RecipeShareSheet(activityItems: [shareText])
        }
    }
}





#Preview {
    TexMexSalatView()
}
    
