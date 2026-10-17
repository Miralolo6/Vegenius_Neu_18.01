
import SwiftUI

struct GruenerBorschtschView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🫒 2 EL Olivenöl",
            "🧅 1 mittelgroße Zwiebel",
            "🥕 1 große Möhre",
            "🫑 1/2 Paprika",
            "🥔 3–4 mittelgroße Kartoffeln",
            "💧 1,5 l Wasser",
            "🌿 450 g TK-Spinat",
            "🧂 Salz nach Geschmack",
            "🍋 Ca. 3 EL Zitronensäure-Extrakt, nach Geschmack",
            "🥒 Gurke zum Servieren",
            "🧅 Lauchzwiebeln zum Servieren",
            "🌿 Frischer Dill zum Servieren",
            "🥛 Pflanzliche Milch, vegane Sahne oder veganer Sauerrahm zum Servieren"
        ],
        steps: [
            "Zwiebel, Möhre, Paprika und Kartoffeln schälen beziehungsweise waschen und klein schneiden.",
            "Das Olivenöl in einem großen Topf erhitzen und die Zwiebel darin glasig anbraten.",
            "Möhre und Paprika hinzufügen und 2–3 Minuten mitbraten.",
            "Wasser und Kartoffeln dazugeben und etwa 10 Minuten köcheln lassen, bis die Kartoffeln fast gar sind.",
            "Den gefrorenen Spinat einrühren und weitere 3–5 Minuten kochen, bis das Gemüse gar ist. Mit Salz abschmecken.",
            "Den Herd ausschalten und den Zitronensäure-Extrakt nach Geschmack unterrühren.",
            "Die Suppe abkühlen lassen und anschließend abgedeckt für mehrere Stunden in den Kühlschrank stellen.",
            "Zum Servieren Gurke, Lauchzwiebeln und Dill fein schneiden.",
            "Die kalte Suppe mit Gurke, Lauchzwiebeln, Dill und etwas pflanzlicher Milch, veganer Sahne oder veganem Sauerrahm servieren.",
            "Reste gut verschlossen im Kühlschrank aufbewahren und innerhalb von 3–4 Tagen verbrauchen."
        ],
        servingSize: "Für ca. 4–5 Portionen (ca. 2 Liter)"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    GruenerBorschtschView(
        recipe: .constant(
            Recipe(
                title: "Grüner Borschtsch",
                imageName: "Gruener_Borschtsch",
                category: .herzhaft,
                filters: [],
                isFavorite: false
            )
        )
    )
}

