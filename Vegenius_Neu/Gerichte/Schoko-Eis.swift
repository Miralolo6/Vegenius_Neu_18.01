
import SwiftUI

struct SchokoEisView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🥣 180 g Sojajoghurt Natur",
            "🍫 1 EL Backkakao",
            "🍁 1 EL Ahornsirup oder Agavendicksaft",
            "🍫 Optional: 10 g geschmolzene vegane Zartbitterschokolade"
        ],
        steps: [
            "Den Sojajoghurt mit dem Backkakao und Ahornsirup oder Agavendicksaft gründlich verrühren, bis eine glatte Masse entsteht.",
            "Optional die vegane Zartbitterschokolade schmelzen und unter die Joghurtmasse rühren.",
            "Die Schokomasse gleichmäßig auf 3 kleine Eisförmchen verteilen.",
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
    SchokoEisView(
        recipe: .constant(
            Recipe(
                title: "Schoko-Eis",
                imageName: "Eis_am_Stiel",
                category: .suess,
                filters: [],
                isFavorite: false
            )
        )
    )
}

