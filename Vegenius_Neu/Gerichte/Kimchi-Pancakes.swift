
import SwiftUI

struct KimchiPancakesView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🌾 150 g Mehl",
            "💧 200 ml Wasser",
            "🧂 1 Prise Salz",
            "🥬 120 g veganes Kimchi",
            "🧅 2 Frühlingszwiebeln",
            "🫒 1 EL Pflanzenöl zum Braten",
            "🌶️ 1 EL Gochujang",
            "🥄 1 TL Ahornsirup oder Zucker",
            "💧 1–2 TL Wasser",
            "🧂 1 TL Sojasauce"
        ],
        steps: [
            "Mehl, Wasser und Salz zu einem glatten Teig verrühren.",
            "Kimchi und Frühlingszwiebeln klein schneiden.",
            "Beides in den Teig rühren.",
            "Öl in einer Pfanne erhitzen.",
            "Teig portionsweise hineingeben, flach drücken und 3–4 Minuten pro Seite braten.",
            "Gochujang, Sojasauce, Ahornsirup und Wasser zu einem Dip verrühren.",
            "Pancakes mit dem Dip servieren."
        ],
        servingSize: "Für 2–3 Personen",
        tip: "Der Teig sollte relativ dick sein, damit die Pancakes schön knusprig werden."
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    KimchiPancakesView(
        recipe: .constant(
            Recipe(
                title: "Kimchi-Pancakes\nmit Gochujang-Dip",
                imageName: "Kimchi-Pancakes",
                category: .unter_zwanzig,
                filters: [.nutFree, .highProtein],
                isFavorite: false
            )
        )
    )
}

