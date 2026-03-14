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
    
    var body: some View {
        NavigationStack {
           
            ScrollView {
                
                VStack(spacing: 24) {
                    
                    
                    
                    // Titel
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
                    }
                    .padding()
                    .background(Color(.systemTeal).opacity(0.35))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    Color(
                        red: 126/255,
                        green: 222/255,
                        blue: 211/255
                    )
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
                .navigationTitle("Vegan Edition")
                .font(.title3.bold())
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Vegan Edition")
                            .foregroundColor(
                                Color(red: 224/255, green: 158/255, blue: 180/255)
                            )
                            .font(.headline)
                    }
                }
                
            
                
                .navigationBarTitleDisplayMode(.inline)
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
                
                Stepper("", value: $people, in: 1...20)
                    .labelsHidden()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.systemTeal).opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Zutaten – hier kannst du einfach deine eigenen Werte eintragen
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
