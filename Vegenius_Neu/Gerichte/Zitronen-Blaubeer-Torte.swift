
import SwiftUI

struct ZitronenBlaubeerTorteView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🌾 250 g Mehl",
            "🥄 120 g Zucker",
            "🧂 1 Prise Salz",
            "🧂 1 Päckchen Backpulver (15 g)",
            "🍋 1 Zitrone (Saft und Abrieb)",
            "💧 200 ml Pflanzenmilch",
            "🫒 80 ml Pflanzenöl",
            "🫐 150 g Blaubeeren",
            "🧂 1 EL Puderzucker (optional zum Bestäuben)"
        ],
        steps: [
            "Backofen auf 180 °C vorheizen.",
            "Mehl, Zucker, Salz und Backpulver in einer Schüssel mischen.",
            "Pflanzenmilch, Öl, Zitronensaft und Zitronenabrieb dazugeben und kurz verrühren.",
            "Blaubeeren vorsichtig unterheben.",
            "Teig in eine gefettete oder mit Backpapier ausgelegte Form füllen.",
            "Bei 180 °C 35–40 Minuten backen.",
            "Abkühlen lassen und optional mit Puderzucker bestäuben.",
            "In Stücke schneiden und servieren."
        ],
        servingSize: "für 8 Stücke"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    ZitronenBlaubeerTorteView(
        recipe: .constant(
            Recipe(
                title: "Zitronen-Blaubeer-Torte",
                imageName: "Zitronen-Blaubeer-Torte",
                category: .suess,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}

