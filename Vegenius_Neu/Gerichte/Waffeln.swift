
import SwiftUI

struct VeganeBananenwaffelnView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🌾 250 g Weizenmehl (Typ 405)",
            "🥄 1 TL Backpulver",
            "🧂 1/5 TL Salz",
            "🍌 1 Banane",
            "🌱 80 g vegane Butter",
            "🍚 60 g Zucker",
            "🌼 1 Päckchen Vanillezucker",
            "🥛 225 ml Sojamilch",
            "🍓 Toppings nach Wahl, z. B. frisches Obst, Puderzucker oder Nussmus"
        ],
        steps: [
            "Mehl, Backpulver und Salz in einer Schüssel miteinander vermischen.",
            "Die vegane Butter mit dem Zucker cremig rühren.",
            "Die Banane mit einer Gabel zerdrücken und unter die Butter-Zucker-Mischung rühren.",
            "Die Mehlmischung, den Vanillezucker und die Sojamilch hinzufügen.",
            "Alle Zutaten zu einem glatten Teig verrühren.",
            "Das Waffeleisen vorheizen und bei Bedarf leicht einfetten.",
            "Den Teig portionsweise in das Waffeleisen geben und die Waffeln goldbraun backen.",
            "Die fertigen Waffeln mit Toppings nach Wahl servieren und genießen."
        ],
        servingSize: "Je nach Größe ca. 6–8 Waffeln"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    VeganeBananenwaffelnView(
        recipe: .constant(
            Recipe(
                title: "Vegane Bananenwaffeln",
                imageName: "Waffeln",
                category: .suess,
                filters: [],
                isFavorite: false
            )
        )
    )
}

