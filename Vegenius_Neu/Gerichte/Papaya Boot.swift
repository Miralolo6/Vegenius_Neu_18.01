
import SwiftUI

struct PapayaBooteView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🍈 1/2 Papaya oder 1 kleine Papaya",
            "🥣 150–200 g pflanzlicher Joghurt nach Wahl",
            "🌱 Optional: 1 Scoop veganes Vanille-Proteinpulver",
            "🥛 Optional: etwas Pflanzenmilch zum Verrühren",
            "🍓 Erdbeeren oder anderes Obst als Topping",
            "🥣 Veganes Crunchy-Müsli als Topping",
            "🥜 Erdnussmus als Topping",
            "🤎 Etwas Zimt"
        ],
        steps: [
            "Die Papaya halbieren und die Kerne mit einem Löffel entfernen.",
            "Den pflanzlichen Joghurt in einer Schüssel glatt rühren. Optional das vegane Vanille-Proteinpulver hinzufügen und bei Bedarf etwas Pflanzenmilch unterrühren.",
            "Den Joghurt direkt in die Papayahälften füllen.",
            "Erdbeeren oder anderes Obst klein schneiden und auf dem Joghurt verteilen.",
            "Mit veganem Crunchy-Müsli, Erdnussmus und etwas Zimt nach Belieben toppen.",
            "Sofort genießen."
        ],
        servingSize: "Für 1 Portion"
    )

    var body: some View {
        RecipeDetailView(recipe: $recipe, content: content)
    }
}

#Preview {
    PapayaBooteView(
        recipe: .constant(
            Recipe(
                title: "Papaya Boote",
                imageName: "Papaya_Boot",
                category: .suess,
                filters: [.highProtein],
                isFavorite: false
            )
        )
    )
}

