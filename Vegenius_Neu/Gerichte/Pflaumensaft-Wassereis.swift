
import SwiftUI

struct PflaumensaftWassereisView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🧃 180 ml Pflaumensaft",
            "💧 20 ml Wasser"
        ],
        steps: [
            "Den Pflaumensaft mit dem Wasser vermischen.",
            "Die Mischung gleichmäßig auf 3 kleine Eisförmchen verteilen.",
            "Die Eisstiele einsetzen und die Förmchen verschließen, falls möglich.",
            "Mindestens 6 Stunden einfrieren.",
            "Zum Herauslösen die Förmchen kurz von außen mit warmem Wasser anwärmen."
        ],
        servingSize: "Für 3 kleine Eis"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    PflaumensaftWassereisView(
        recipe: .constant(
            Recipe(
                title: "Pflaumensaft-Wassereis",
                imageName: "Eis_am_Stiel",
                category: .suess,
                filters: [],
                isFavorite: false
            )
        )
    )
}

