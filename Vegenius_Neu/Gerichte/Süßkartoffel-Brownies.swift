
import SwiftUI

struct SuesskartorffelBrowniesView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍠 250 g Süßkartoffeln (gekocht oder gedämpft)",
            "🌾 50 g Lupinenmehl",
            "🥄 50 g Ahornsirup oder Agavendicksaft",
            "🫒 30 ml Pflanzenöl",
            "💧 30 ml Pflanzenmilch",
            "🍫 50 g vegane, nussfreie Schokotropfen",
            "🧂 1 Prise Salz",
            "🥄 1 TL Vanilleextrakt",
            "🥄 1 TL Backpulver (optional)",
            "🥄 2 EL Kakaopulver"
        ],
        steps: [
            "Süßkartoffeln weich kochen und pürieren.",
            "Öl, Pflanzenmilch, Ahornsirup und Vanilleextrakt verrühren und zum Süßkartoffelpüree geben.",
            "Mehl, Kakaopulver, Backpulver und Salz mischen und unter die feuchten Zutaten rühren.",
            "Schokotropfen unterheben.",
            "Teig in eine gefettete oder mit Backpapier ausgelegte Form füllen.",
            "Bei 180 °C 20–25 Minuten backen.",
            "Abkühlen lassen, in Stücke schneiden und servieren."
        ],
        servingSize: "für 12 Stücke",
        tip: "Für extra saftige Brownies nicht zu lange backen – der Kern darf noch leicht feucht sein."
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    SuesskartorffelBrowniesView(
        recipe: .constant(
            Recipe(
                title: "Süßkartoffel-Brownies",
                imageName: "Süßkartoffel Brownies",
                category: .suess,
                filters: [.glutenFree, .lowCarb],
                isFavorite: false
            )
        )
    )
}

