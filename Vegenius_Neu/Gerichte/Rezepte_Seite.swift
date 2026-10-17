
import SwiftUI

struct MediterraneReispfanneView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🧅 1 große rote Zwiebel",
            "🧄 2 Knoblauchzehen",
            "🫑 1 gelbe Paprika",
            "🥒 1 kleine Zucchini",
            "🍅 3 mittelgroße Tomaten",
            "🍚 150 g Langkornreis",
            "🛢️ 2 EL Rapsöl",
            "🥫 2 EL Tomatenmark",
            "🌿 1 Zweig Rosmarin",
            "🌿 2 Stiele Thymian",
            "🌿 Einige Blätter frisches Basilikum",
            "🧂 Salz und Pfeffer nach Geschmack",
            "🍋 Optional: etwas Zitronensaft"
        ],
        steps: [
            "Zwiebel und Knoblauch fein würfeln. Paprika und Zucchini klein schneiden, Tomaten grob hacken.",
            "Rapsöl in einer großen Pfanne erhitzen. Zwiebeln glasig anschwitzen, dann Knoblauch kurz mitbraten.",
            "Paprika und Zucchini hinzufügen und 3–4 Minuten anbraten.",
            "Tomatenmark einrühren und 1 Minute rösten.",
            "Reis hinzufügen und gut vermengen.",
            "300 ml Wasser oder Gemüsebrühe angießen, Rosmarin und Thymian hinzufügen. Aufkochen und zugedeckt 15–18 Minuten köcheln lassen.",
            "Tomaten und Basilikum unterrühren und mit Salz, Pfeffer und optional Zitronensaft abschmecken.",
            "5 Minuten abgedeckt ziehen lassen und mit frischem Basilikum servieren."
        ],
        servingSize: "Für 2–4 Personen",
        tip: "Wer es scharf mag, kann Chiliflocken hinzufügen."
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    MediterraneReispfanneView(
        recipe: .constant(
            Recipe(
                title: "Mediterrane Reispfanne – Tomaten\nPaprika Basis",
                imageName: "Mediterrane Reispfanne",
                category: .unter_zwanzig,
                filters: [.glutenFree, .nutFree],
                isFavorite: false
            )
        )
    )
}

