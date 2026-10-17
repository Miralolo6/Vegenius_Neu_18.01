
import SwiftUI

struct PistazienPestoView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍝 200 g Pasta",
            "🍄 200 g Champignons",
            "🧄 1 Knoblauchzehe",
            "🌿 30 g Basilikum",
            "🟢 40 g Pistazien",
            "🫒 3 EL Olivenöl",
            "🍋 1 TL Zitronensaft",
            "🧂 Salz und Pfeffer",
            "💧 2–3 EL Nudelwasser"
        ],
        steps: [
            "Pasta in Salzwasser 8–10 Minuten kochen.",
            "Pistazien, Basilikum, Knoblauch, Olivenöl und Zitronensaft zu Pesto mixen.",
            "Champignons in Scheiben schneiden.",
            "Pilze in einer Pfanne 4–5 Minuten anbraten.",
            "Gekochte Pasta und etwas Nudelwasser zu den Pilzen geben.",
            "Pesto unterrühren und alles gut vermengen.",
            "Mit Salz und Pfeffer abschmecken.",
            "Servieren."
        ],
        servingSize: "Für 2 Personen",
        tip: "Etwas Zitronenabrieb im Pesto macht das Gericht frischer."
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    PistazienPestoView(
        recipe: .constant(
            Recipe(
                title: "Pasta mit Pistazienpesto & Pilzen",
                imageName: "Pistazienpesto",
                category: .unter_zwanzig,
                filters: [],
                isFavorite: false
            )
        )
    )
}

