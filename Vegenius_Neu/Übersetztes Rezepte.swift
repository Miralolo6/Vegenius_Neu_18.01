//
//  Übersetztes Rezepte.swift
//  Vegenius_Neu
//
//  Created by TA617 on 09.02.26.
//
import SwiftUI

struct VeganResultView: View {
    @State private var people: Int = 10
    @State private var showIngredients = true
    @State private var showInstructions = false
    @State private var isSaved = false
    @State private var showAltImage = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing)
            {

                ScrollView {
                    VStack(spacing: 24) {
                        
                        HStack {
                            Button(action: {
                                // Back action
                            }) {
                                Image(systemName: "arrow.left")
                                    .padding(.top, -32)
                                    .font(.title3)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing)
                                {
                                    
                                    Button {
                                        showAltImage.toggle()
                                        
                                        
                                    } label: {
                                        Image(showAltImage ? "gH" : "sH")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 22, height: 22)
                                        // Aktion
                                      }
                                }
                            }
                        }
                    }
                
                    
                        Text("Vegan Edition")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(
                                Color(red: 231/255, green: 161/255, blue: 176/255)
                            )
                       //Spacer()
                        
                        Text("Vegane Brownies - saftig und einfach")
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)

                        // ZUTATEN – CARD
                        DisclosureGroup(isExpanded: $showIngredients) {
                            ingredientsCard
                                .padding(.top, 8)
                        } label: {
                            Text("Zutaten")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(
                                    Color(red: 231/255, green: 161/255, blue: 176/255)
                                )
                        }
                        .padding()
                        .background(Color(.systemTeal).opacity(0.35))
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                        // ZUBEREITUNG – CARD
                        DisclosureGroup(isExpanded: $showInstructions) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("1. Backofen auf 180° C Ober-/Unterhitze vorheizen.")
                                Text("2. Schokolade schmelzen, mit Zucker, Öl und Pflanzenmilch verrühren.")
                                Text("3. Trockene Zutaten mischen und unterheben.")
                                Text("4. In gefettete Form geben und ca. 25–30 Min. backen.")
                            }
                            .font(.subheadline)
                            .padding(.top, 8)
                        } label: {
                            Text("Zubereitung")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(
                                    Color(red: 231/255, green: 161/255, blue: 176/255))
                        }
                        .padding()
                        .background(Color(.systemTeal).opacity(0.35))
                        
                        .clipShape(RoundedRectangle(cornerRadius: 14))

                        

                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 20)
                   
                    .navigationBarTitleDisplayMode(.inline)
                }
                

                // Overlay oben rechts: Tappbares Asset-Bild (toggle zwischen sH und gH)
              
            }
        }
        
    }

    // MARK: - Zutaten‑Card
    private var ingredientsCard: some View {
        VStack(spacing: 12) {
            // Personen‑Zeile mit + / –
            HStack {
                Text("Für \(people) Person(en)")
                    .font(.subheadline)

                Spacer()

                Stepper("", value: $people, in: 1...24)
                    .labelsHidden()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.systemTeal).opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Zutaten
            ingredientRow("250 g Zartbitterschokolade")
            ingredientRow("250 g brauner Zucker")
            ingredientRow("200 g Mehl")
            ingredientRow("150 ml Pflanzenmilch", hasArrow: true)
            ingredientRow("100 g Sonnenblumenöl")
            ingredientRow("50 g Backkakao")
            ingredientRow("5 EL Apfelmus", hasArrow: true)
            ingredientRow("1 Päckchen Vanillezucker")
            ingredientRow("1 Prise Salz")
            ingredientRow("Sonnenblumenöl für die Form", hasArrow: true)
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    // einzelne Zutaten‑Zeile im „Pill“-Look
    private func ingredientRow(_ text: String, hasArrow: Bool = false) -> some View {
        HStack {
            Text(text)
                .font(.subheadline)
            Spacer()
            if hasArrow {
                Image(systemName: "chevron.down")
                    .font(.caption)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.systemTeal).opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    VeganResultView()
}
