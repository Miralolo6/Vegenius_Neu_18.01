
import SwiftUI

struct SoychickenMitCouscousView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🌱 100 g Sojachunks (trocken)",
            "🌾 160–200 g Couscous",
            "🧅 1 Zwiebel",
            "🧄 1–2 Knoblauchzehen",
            "🫑 1 Paprika (optional)",
            "🫒 1 EL Olivenöl",
            "🥫 1 EL Tomatenmark oder 2 EL Sojasauce",
            "🧂 Salz, Pfeffer, Paprikapulver und optional Chili",
            "💧 Ca. 300 ml Gemüsebrühe für Sojachunks und Couscous"
        ],
        steps: [
            "Sojachunks mit heißer Brühe übergießen, 5–10 Minuten ziehen lassen und ausdrücken.",
            "Zwiebel, Knoblauch und optional Paprika klein schneiden.",
            "Öl erhitzen und das Gemüse 2–3 Minuten anbraten.",
            "Sojachunks zugeben und knusprig braten.",
            "Tomatenmark oder Sojasauce und Gewürze einrühren.",
            "Couscous mit heißer Brühe übergießen, 5 Minuten quellen lassen und mit einer Gabel auflockern.",
            "Couscous mit Soychicken servieren."
        ],
        servingSize: "Für 2 Personen"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    SoychickenMitCouscousView(
        recipe: .constant(
            Recipe(
                title: "Soychicken mit Couscous",
                imageName: "Soychicken Couscous",
                category: .herzhaft,
                filters: [.highProtein],
                isFavorite: false
            )
        )
    )
}

