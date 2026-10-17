
import SwiftUI

struct GemüsegratinMitZucchiniView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🥒 2 kleine Zucchini",
            "🥕 1 Karotte",
            "🧅 1 Zwiebel",
            "🧄 1 Knoblauchzehe",
            "🍅 100 g passierte Tomaten",
            "🫒 1 EL Olivenöl",
            "🧂 Salz, Pfeffer, Paprikapulver und Kräuter nach Wahl",
            "🌾 50 g glutenfreie Haferflocken",
            "💧 50 ml ungesüßte Pflanzenmilch"
        ],
        steps: [
            "Zucchini, Karotte, Zwiebel und Knoblauch klein schneiden.",
            "Öl in einer Pfanne erhitzen und Zwiebel und Knoblauch 2–3 Minuten anbraten.",
            "Karotte und Zucchini hinzufügen und 3–4 Minuten mitbraten.",
            "Passierte Tomaten und Gewürze einrühren und 2–3 Minuten köcheln lassen.",
            "Haferflocken mit Pflanzenmilch mischen und als Topping auf das Gemüse geben.",
            "In eine Auflaufform füllen und bei 180 °C etwa 20–25 Minuten backen.",
            "Kurz abkühlen lassen und servieren."
        ],
        servingSize: "Für 2 Personen",
        tip: "Für extra Geschmack etwas Hefeflocken über das Topping streuen."
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    GemüsegratinMitZucchiniView(
        recipe: .constant(
            Recipe(
                title: "Gemüsegratin mit Zucchini",
                imageName: "Gemüsegratin mit Zucchini",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree],
                isFavorite: false
            )
        )
    )
}

