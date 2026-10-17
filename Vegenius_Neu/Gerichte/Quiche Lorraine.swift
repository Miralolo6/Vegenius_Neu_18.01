
import SwiftUI

struct QuicheLorraineView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🌾 200 g Mehl",
            "🫒 60 ml Olivenöl",
            "💧 80 ml Wasser",
            "🧂 1 Prise Salz",
            "🧅 1 Zwiebel",
            "🧄 1 Knoblauchzehe",
            "🥓 120 g Räuchertofu",
            "🥣 200 g Seidentofu",
            "🌾 40 g Kichererbsenmehl",
            "💧 80 ml Pflanzenmilch",
            "🧂 Salz, Pfeffer und Muskat",
            "🌿 Schnittlauch oder Petersilie (optional)"
        ],
        steps: [
            "Mehl, Salz, Öl und Wasser zu einem Teig kneten.",
            "Teig in eine Quiche- oder Springform drücken.",
            "Zwiebel, Knoblauch und Räuchertofu klein schneiden.",
            "Alles in einer Pfanne 3–4 Minuten anbraten.",
            "Seidentofu, Kichererbsenmehl, Pflanzenmilch und Gewürze glatt mixen.",
            "Die Tofu-Zwiebel-Mischung auf dem Teig verteilen.",
            "Tofu-Creme darüber gießen.",
            "Bei 180 °C etwa 35–40 Minuten backen.",
            "Kurz abkühlen lassen, anschneiden und servieren."
        ],
        servingSize: "Für 4 Personen"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    QuicheLorraineView(
        recipe: .constant(
            Recipe(
                title: "Quiche Lorraine",
                imageName: "Quiche_Lorraine",
                category: .unter_zwanzig,
                filters: [],
                isFavorite: false
            )
        )
    )
}

