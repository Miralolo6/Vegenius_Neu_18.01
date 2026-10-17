
import SwiftUI

struct SnickersOvernightOatsView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🌾 40 g Haferflocken",
            "🌱 1 TL Chiasamen",
            "🥜 1 EL Erdnussmus",
            "🥣 120 g veganer Joghurt",
            "🥛 120 ml Pflanzenmilch",
            "🍁 1–2 TL Ahornsirup",
            "🧂 1 Prise Salz",
            "🍫 2–3 Stücke dunkle Schokolade",
            "🥥 1 TL Kokosöl",
            "🥛 1–2 TL Pflanzenmilch für die Schokoschicht",
            "🥜 Erdnussmus als Topping",
            "🥜 Erdnüsse als Topping",
            "🍌 Banane als Topping"
        ],
        steps: [
            "Haferflocken, Chiasamen, Erdnussmus, veganen Joghurt, Pflanzenmilch, Ahornsirup und eine Prise Salz in einem Glas oder einer Schüssel gut verrühren.",
            "Die Mischung abdecken und über Nacht im Kühlschrank quellen lassen.",
            "Dunkle Schokolade und Kokosöl vorsichtig zusammen schmelzen.",
            "1–2 TL Pflanzenmilch unterrühren, bis eine geschmeidige Schokoschicht entsteht.",
            "Die geschmolzene Schokolade gleichmäßig auf den Overnight Oats verteilen.",
            "Das Glas erneut kalt stellen, bis die Schokolade knackig, aber nicht zu hart ist.",
            "Vor dem Servieren mit Erdnussmus, Erdnüssen und Bananenscheiben toppen."
        ],
        servingSize: "Für 1 Person"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    SnickersOvernightOatsView(
        recipe: .constant(
            Recipe(
                title: "Snickers Overnight Oats",
                imageName: "Snickers_overnight_oats",
                category: .suess,
                filters: [],
                isFavorite: false
            )
        )
    )
}

