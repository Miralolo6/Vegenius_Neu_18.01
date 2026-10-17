
import SwiftUI

struct TwistedPotatoesView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🥔 4 große Kartoffeln (festkochend)",
            "🫒 2–3 EL Olivenöl",
            "🧂 1 TL Salz",
            "🌶️ 1 TL Paprikapulver (edelsüß oder geräuchert)",
            "🧄 ½ TL Knoblauchpulver",
            "🧅 ½ TL Zwiebelpulver",
            "🌿 ½ TL getrocknete Kräuter (z. B. Oregano oder Thymian)",
            "🌶️ Optional: etwas Chili oder Cayennepfeffer"
        ],
        steps: [
            "Kartoffeln waschen.",
            "Einen Holzspieß längs durch jede Kartoffel stecken.",
            "Die Kartoffel spiralförmig einschneiden.",
            "Die Spirale vorsichtig auseinanderziehen.",
            "Mit Olivenöl einreiben.",
            "Mit den Gewürzen bestreuen.",
            "Im Backofen bei 200 °C 30–40 Minuten backen oder im Airfryer bei 180 °C 20–25 Minuten garen."
        ],
        servingSize: "für 1–2 Personen"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    TwistedPotatoesView(
        recipe: .constant(
            Recipe(
                title: "Twisted Potatoes",
                imageName: "Twisted Potatoe",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree],
                isFavorite: false
            )
        )
    )
}

