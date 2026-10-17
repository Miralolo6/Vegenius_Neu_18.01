
import SwiftUI

struct MisoRamenSuppeView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍜 200 g Ramen- oder Weizennudeln",
            "🥣 800 ml Gemüsebrühe",
            "🥄 2 EL Miso-Paste",
            "🥓 150 g Räuchertofu",
            "🥬 100 g Pak Choi oder Spinat",
            "🧅 2 Frühlingszwiebeln",
            "🧄 1 Knoblauchzehe",
            "🫚 1 TL geriebener Ingwer",
            "🫒 1 TL Sesam- oder Pflanzenöl",
            "🧂 1 EL Sojasauce"
        ],
        steps: [
            "Knoblauch, Ingwer und Frühlingszwiebeln klein schneiden.",
            "Öl im Topf erhitzen und Knoblauch und Ingwer 1–2 Minuten anbraten.",
            "Gemüsebrühe zugeben und aufkochen lassen.",
            "Nudeln hinzufügen und 4–5 Minuten kochen.",
            "Räuchertofu würfeln und in die Suppe geben.",
            "Pak Choi oder Spinat zugeben und 2–3 Minuten mitköcheln.",
            "Miso-Paste mit etwas Brühe verrühren und einrühren.",
            "Mit Sojasauce abschmecken.",
            "In Schüsseln füllen und servieren."
        ],
        servingSize: "Für 2 Personen"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    MisoRamenSuppeView(
        recipe: .constant(
            Recipe(
                title: "Miso-Ramen-Suppe",
                imageName: "Miso-Ramen-Suppe",
                category: .unter_zwanzig,
                filters: [.glutenFree],
                isFavorite: false
            )
        )
    )
}

