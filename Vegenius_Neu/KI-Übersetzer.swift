//
//  KI-Übersetzer.swift
//  Vegenius_Neu
//
//  Created by TA620 on 28.01.26.
//

import SwiftUI
import Foundation

// MARK: - Rezept-Kontext

enum RecipeContext {
    case baking
    case pancakes
    case breakfast
    case savory
    case dessert
    case unknown
}

// MARK: - Kontext-Erkennung

func detectRecipeContext(_ text: String) -> RecipeContext {
    let t = text.lowercased()

    if t.contains("brownie") || t.contains("cake") || t.contains("cookie") {
        return .baking
    }
    if t.contains("pancake") || t.contains("kaiserschmarrn") {
        return .pancakes
    }
    if t.contains("scramble") || t.contains("omelette") {
        return .breakfast
    }
    if t.contains("soup") || t.contains("stew") {
        return .savory
    }
    if t.contains("dessert") {
        return .dessert
    }

    return .unknown
}

// MARK: - Ei-Ersatz nach Kontext

let eggReplacements: [RecipeContext: String] = [
    .baking: "1 EL gemahlene Leinsamen mit 3 EL Wasser mischen und quellen lassen",
    .pancakes: "3 EL Aquafaba (Kichererbsenwasser)",
    .breakfast: "zerbröselter Tofu mit Kurkuma und Salz würzen",
    .dessert: "3 EL Aquafaba (Kichererbsenwasser)",
    .savory: "2 EL Kichererbsenmehl mit etwas Wasser verrühren",
    .unknown: "1 EL gemahlene Leinsamen mit 3 EL Wasser mischen"
]

// MARK: - Allgemeine Ersetzungen

let veganReplacements: [String: String] = [
    "Milch": "Soja-Milch",
    "Butter": "vegane Butter",
    "Sahne": "Hafer-Sahne",
    "Käse": "veganer Käse",
    "Honig": "Ahornsirup",
    "Joghurt": "Soja-Joghurt",
    "Hühnchen": "Sojawürfel oder gewürzter Tofu",
    "Rind": "Seitanstreifen",
    "Schwein": "Soja-Schreifen",
    "Fisch": "Tofu in Zitronensaft, Knoblauch und etwas Alge marinieren",
    "Gelatine": "Agar Agar"
]

// MARK: - Ei ersetzen

func replaceEggs(_ text: String) -> String {
    let context = detectRecipeContext(text)
    let replacement = eggReplacements[context] ?? "Leinsamen-Ei"

    return text.replacingOccurrences(
        of: "Ei",
        with: replacement,
        options: .caseInsensitive
    )
}

// MARK: - Hauptfunktion

func veganizeRecipe(_ text: String) -> String {
    var result = text

    result = replaceEggs(result)

    for (nonVegan, vegan) in veganReplacements {
        result = result.replacingOccurrences(
            of: nonVegan,
            with: vegan,
            options: .caseInsensitive
        )
    }

    return result
}

struct Translater_View: View {

    @State private var inputRecipe = ""
    @State private var outputRecipe = ""

    var body: some View {
        VStack(spacing: 20) {

            Text("Rezept veganisieren")
                .font(.largeTitle)
                .bold()

            TextEditor(text: $inputRecipe)
                .frame(height: 160)
                .border(Color.gray)

            Button("Übersetzen") {
                outputRecipe = veganizeRecipe(inputRecipe)
            }

            TextEditor(text: $outputRecipe)
                .frame(height: 160)
                .border(Color.gray)
        }
        .padding()
    }
}

#Preview {
    Translater_View()
}
