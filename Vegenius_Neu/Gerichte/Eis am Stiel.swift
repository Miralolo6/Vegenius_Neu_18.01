
import SwiftUI

struct StracciatellaEisView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🥣 180 g Vly Stracciatella-Joghurt",
            "🌱 Alternativ: 180 g neutraler pflanzlicher Joghurt",
            "🍁 1 TL Ahornsirup oder Agavendicksaft",
            "🍫 Optional: vegane Schokodrops oder gehackte Zartbitterschokolade",
            "🌰 Optional: 1 TL Mandelmus"
        ],
        steps: [
            "Den Stracciatella-Joghurt oder neutralen pflanzlichen Joghurt mit Ahornsirup oder Agavendicksaft verrühren.",
            "Optional Mandelmus und vegane Schokodrops oder gehackte Zartbitterschokolade unterheben.",
            "Die Masse gleichmäßig auf 3 kleine Eisförmchen verteilen.",
            "Die Eisstiele einsetzen und die Förmchen verschließen, falls möglich.",
            "Mindestens 6 Stunden, am besten über Nacht, einfrieren.",
            "Zum Herauslösen die Förmchen kurz von außen mit warmem Wasser anwärmen."
        ],
        servingSize: "Für 3 kleine Eis"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    StracciatellaEisView(
        recipe: .constant(
            Recipe(
                title: "Stracciatella-Eis",
                imageName: "Eis_am_Stiel",
                category: .suess,
                filters: [],
                isFavorite: false
            )
        )
    )
}

