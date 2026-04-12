//
//  Übersetzte_Rezepte_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 11.04.26.
//

import SwiftUI

struct VeganResultView2: View {
    let text: String

    @State private var people: Int = 10
    @State private var showIngredients = true
    @State private var showInstructions = false

    // MARK: - Parsed Data
    var ingredients: [String] {
        extractSection(title: "zutaten")
            .map { $0.replacingOccurrences(of: "- ", with: "") }
    }

    var steps: [String] {
        extractSection(title: "zubereitung")
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    Text("Vegan Edition")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(
                            Color(red: 231/255, green: 161/255, blue: 176/255)
                        )

                    // MARK: - Zutaten
                    DisclosureGroup(isExpanded: $showIngredients) {
                        ingredientsCard
                    } label: {
                        Text("Zutaten")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemTeal).opacity(0.35))
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                    // MARK: - Zubereitung
                    DisclosureGroup(isExpanded: $showInstructions) {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(steps, id: \.self) { step in
                                Text(step)
                            }
                        }
                        .padding(.top, 8)
                    } label: {
                        Text("Zubereitung")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemTeal).opacity(0.35))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding()
            }
        }
    }

    // MARK: - Zutaten Card
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

            ForEach(ingredients, id: \.self) { item in
                ingredientRow(item)
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    // MARK: - Ingredient Row (Pill Design)
    private func ingredientRow(_ text: String) -> some View {
        HStack {
            Text(text)
                .font(.subheadline)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.systemTeal).opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    // MARK: - Parser
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
