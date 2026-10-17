
import SwiftUI

struct TiramisuView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍪 200 g vegane Löffelbiskuits (nussfrei)",
            "☕ 200 ml starker Kaffee (abgekühlt)",
            "🥣 400 g veganer Skyr oder Sojajoghurt",
            "🥄 40 g Zucker",
            "🥄 1 TL Vanilleextrakt",
            "🧂 1–2 EL Kakaopulver"
        ],
        steps: [
            "Kaffee zubereiten und abkühlen lassen.",
            "Skyr oder Sojajoghurt mit Zucker und Vanilleextrakt glatt rühren.",
            "Löffelbiskuits kurz in Kaffee tauchen.",
            "Biskuits in eine Auflaufform legen.",
            "Creme darüber verteilen.",
            "Eine weitere Schicht getränkter Biskuits darauflegen.",
            "Die restliche Creme darauf verstreichen.",
            "Mit Kakaopulver bestäuben.",
            "Mindestens 2 Stunden kalt stellen und anschließend servieren."
        ],
        servingSize: "für 4 Portionen",
        tip: "Für intensiveren Geschmack etwas Kaffeepulver in die Creme rühren."
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    TiramisuView(
        recipe: .constant(
            Recipe(
                title: "Tiramisu",
                imageName: "Tiramisu",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}

