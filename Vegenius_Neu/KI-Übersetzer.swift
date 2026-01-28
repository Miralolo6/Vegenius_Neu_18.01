//
//  KI-Übersetzer.swift
//  Vegenius_Neu
//
//  Created by TA620 on 28.01.26.
//

import SwiftUI


let apiKey = "sk-abc123xyz"


struct Translater_View: View {

    @State private var inputRecipe = ""
    @State private var outputRecipe = ""

    var body: some View {
        VStack(spacing: 20) {

            Text("Rezept veganisieren")
                .font(.largeTitle)
                .bold()

            TextEditor(text: $inputRecipe)
                .frame(height: 150)
                .border(Color.gray)

            Button("Übersetzen") {
                let tag = detectContext(inputRecipe)
                outputRecipe = "\(tag)\n\(inputRecipe)"
            }

            TextEditor(text: $outputRecipe)
                .frame(height: 150)
                .border(Color.gray)
        }
        .padding()
    }
}

func detectContext(_ text: String) -> String {
    let lower = text.lowercased()

    if lower.contains("whisk") || lower.contains("beat") {
        return "[WHIPPING]"
    }
    if lower.contains("bake") || lower.contains("oven") {
        return "[BAKING]"
    }
    if lower.contains("fry") || lower.contains("scramble") {
        return "[FRYING]"
    }
    return "[GENERAL]"
}






#Preview {
    Translater_View()
}
