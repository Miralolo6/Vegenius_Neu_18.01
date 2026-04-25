//
//  Destination.swift
//  Vegenius_Neu
//
//  Created by TA620 on 25.04.26.
//

import SwiftUI


struct RecipeDestination: View {
    @Binding var recipe: Recipe

    var body: some View {
        switch recipe.title {

        case "Bananenbrot":
            BananenbrotView(recipe: $recipe)

        case "Süßkartoffel-Brownies":
            SuesskartorffelBrowniesView(recipe: $recipe)

        case "Tiramisu":
            TiramisuView(recipe: $recipe)

        case "Chana Masala":
            ChanaMasalaView(recipe: $recipe)

        case "Mediterrane Reispfanne":
            RezeptDetailView(recipe: $recipe)

        default:
            RecipeDetailHost(recipe: $recipe)
        }
    }
}
