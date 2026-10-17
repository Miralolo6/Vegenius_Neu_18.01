
import SwiftUI

struct ZweiZutatenMousseAuChocolatView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍫 400 g Seidentofu",
            "🍫 3 Tafeln Zartbitterschokolade",
            "🍁 Optional: 1–2 EL Ahornsirup für eine cremigere Konsistenz"
        ],
        steps: [
            "Die Zartbitterschokolade in Stücke brechen und vorsichtig im Wasserbad schmelzen.",
            "Den Seidentofu zur geschmolzenen Schokolade geben.",
            "Seidentofu und Schokolade gründlich mixen, bis eine glatte und homogene Masse entsteht.",
            "Optional 1–2 EL Ahornsirup hinzufügen und nochmals gut mixen.",
            "Die Mousse auf sechs Dessertgläser verteilen.",
            "Für mindestens 3 Stunden im Kühlschrank kalt stellen.",
            "Gut gekühlt servieren und genießen."
        ],
        servingSize: "Für ca. 6 Portionen"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    ZweiZutatenMousseAuChocolatView(
        recipe: .constant(
            Recipe(
                title: "Mousse au Chocolat",
                imageName: "Mousse_au_chocolat",
                category: .suess,
                filters: [],
                isFavorite: false
            )
        )
    )
}

