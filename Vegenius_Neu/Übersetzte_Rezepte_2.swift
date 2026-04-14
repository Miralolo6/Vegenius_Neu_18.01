//
//  Übersetzte_Rezepte_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 11.04.26.
//

import SwiftUI

// MARK: - MODEL
struct Ingredient: Identifiable {
    let id = UUID()
    let baseAmount: Double?
    let unit: String
    let name: String
    let alternatives: [String]
}

// MARK: - VIEW
struct VeganResultView2: View {
    
    let text: String
    
    @State private var people: Int = 2
    @State private var basePeople: Int = 2 // 👈 wichtig für Umrechnung
    
    @State private var showIngredients = true
    @State private var showInstructions = true
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - PARSED INGREDIENTS
    
    var parsedIngredients: [Ingredient] {
        extractSection(title: "zutaten").map { line in
            
            let cleaned = line.replacingOccurrences(of: "- ", with: "")
            
            let lower = cleaned.lowercased()

            var mainPart = cleaned
            var alternatives: [String] = []

            if lower.contains("alternative") {
                let split = cleaned.components(separatedBy: "Alternative:")
                
                if split.count < 2 {
                    // fallback für "Alternativen:"
                    let splitAlt = cleaned.components(separatedBy: "Alternativen:")
                    if splitAlt.count >= 2 {
                        mainPart = splitAlt[0]
                        alternatives = splitAlt[1]
                            .components(separatedBy: ",")
                            .map { $0.trimmingCharacters(in: .whitespaces) }
                    }
                } else {
                    mainPart = split[0]
                    alternatives = split[1]
                        .components(separatedBy: ",")
                        .map { $0.trimmingCharacters(in: .whitespaces) }
                }
            }

            alternatives = alternatives.filter { !$0.isEmpty }
            
            // Extract amount
            let components = mainPart.components(separatedBy: " ")
            
            if let amount = Double(components.first?.replacingOccurrences(of: ",", with: ".") ?? "") {
                let unit = components.count > 1 ? components[1] : ""
                let name = components.dropFirst(2).joined(separator: " ")
                
                return Ingredient(
                    baseAmount: amount,
                    unit: unit,
                    name: name,
                    alternatives: alternatives
                )
            } else {
                return Ingredient(
                    baseAmount: nil,
                    unit: "",
                    name: mainPart,
                    alternatives: alternatives
                )
            }
        }
    }
    
    // MARK: - STEPS
    
    var steps: [String] {
        extractSection(title: "zubereitung").map { step in
            step.replacingOccurrences(
                of: #"^\d+[\.\)]\s*"#, //keine doppelte Nummerierung
                with: "",
                options: .regularExpression
            )
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Vegan Edition") 
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(
                                Color(red: 231/255, green: 161/255, blue: 176/255)
                            )
                        
                        Spacer()
                        
                        // damit Titel mittig bleibt
                        Color.clear.frame(width: 24)
                    }
                    .padding(.horizontal)
                    
                    
                    // MARK: Zutaten
                    DisclosureGroup(isExpanded: $showIngredients) {
                        ingredientsCard
                    } label: {
                        header("Zutaten")
                    }
                    .cardStyle()
                    
                    // MARK: Zubereitung
                    DisclosureGroup(isExpanded: $showInstructions) {
                        stepsCard
                    } label: {
                        header("Zubereitung")
                    }
                    .cardStyle()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - HEADER
    
    private func header(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color(red: 231/255, green: 161/255, blue: 176/255))
    }
    
    // MARK: - INGREDIENTS CARD
    
    private var ingredientsCard: some View {
        VStack(spacing: 12) {
            
            HStack {
                Text("Für \(people) Person(en)")
                Spacer()
                Stepper("", value: $people, in: 1...24)
                    .labelsHidden()
            }
            .padding()
            .background(Color(.systemTeal).opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            ForEach(parsedIngredients) { ingredient in
                IngredientRow(
                    ingredient: ingredient,
                    multiplier: Double(people) / Double(basePeople)
                )
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    // MARK: - STEPS CARD
    
    private var stepsCard: some View {
        VStack(spacing: 12) {
            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                stepRow(index: index + 1, text: step)
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    // MARK: - STEP ROW (wie Screenshot)
    
    private func stepRow(index: Int, text: String) -> some View {
        HStack(alignment: .top) {
            Text("\(index).")
                .bold()
            
            Text(text)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemTeal).opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    // MARK: - PARSER
    
    private func extractSection(title: String) -> [String] {
        let lines = text.components(separatedBy: "\n")
        
        var capture = false
        var result: [String] = []
        
        for line in lines {
            let lower = line.lowercased()
            
            if lower.contains(title) {
                capture = true
                continue
            }
            
            if capture && (lower.contains("zutaten") || lower.contains("zubereitung")) {
                break
            }
            
            if capture && !line.trimmingCharacters(in: .whitespaces).isEmpty {
                result.append(line)
            }
        }
        
        return result
    }
}

// MARK: - INGREDIENT ROW

struct IngredientRow: View {
    
    let ingredient: Ingredient
    let multiplier: Double
    
    @State private var expanded = false
    
    var scaledAmount: String {
        guard let base = ingredient.baseAmount else {
            return ingredient.name
        }
        
        let newAmount = base * multiplier
        return String(format: "%.1f", newAmount)
            + " " + ingredient.unit + " " + ingredient.name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            Button {
                if !ingredient.alternatives.isEmpty {
                    withAnimation {
                        expanded.toggle()
                    }
                }
            } label: {
                HStack {
                    Text(scaledAmount)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if !ingredient.alternatives.isEmpty {
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(expanded ? 180 : 0))
                    }
                }
                .padding()
                .background(Color(.systemTeal).opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            
            if expanded {
                VStack {
                    ForEach(ingredient.alternatives, id: \.self) { alt in
                        Text(alt)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemTeal).opacity(0.2))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 4)
            }
        }
    }
}

// MARK: - STYLE EXTENSION

extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.systemTeal).opacity(0.35))
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
