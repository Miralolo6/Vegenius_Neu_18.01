
import SwiftUI

struct SpaghettiView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍝 200 g Spaghetti",
            "🧄 3 Knoblauchzehen",
            "🫒 3 EL Olivenöl",
            "🌶️ ½ TL Chiliflocken (optional)",
            "🧂 Salz und Pfeffer",
            "🌿 1 EL Petersilie (optional)",
            "💧 2–3 EL Nudelwasser"
        ],
        steps: [
            "Spaghetti in Salzwasser 8–10 Minuten kochen.",
            "Knoblauch in dünne Scheiben schneiden.",
            "Olivenöl in einer Pfanne erhitzen und den Knoblauch 1–2 Minuten sanft anbraten.",
            "Optional die Chiliflocken zugeben.",
            "Gekochte Spaghetti und etwas Nudelwasser in die Pfanne geben.",
            "Alles gut vermengen und 1–2 Minuten schwenken.",
            "Mit Salz, Pfeffer und Petersilie abschmecken.",
            "Servieren."
        ],
        servingSize: "Für 2 Personen",
        tip: "Knoblauch nur leicht goldbraun braten – wird er zu dunkel, schmeckt das Öl bitter."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    SpaghettiView(
        recipe: .constant(
            Recipe(
                title: "Spaghetti Aglio e Olio",
                imageName: "Spaghetti",
                category: .unter_zwanzig,
                filters: [.nutFree],
                isFavorite: false
            )
        )
    )
}

