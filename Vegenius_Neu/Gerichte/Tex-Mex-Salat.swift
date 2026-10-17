
import SwiftUI

struct TexMexSalatView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "🥬 150 g Blattsalat (z. B. Römersalat)",
            "🧆 200 g schwarze Bohnen (Dose, abgespült)",
            "🌽 150 g Mais",
            "🍅 150 g Cherrytomaten",
            "🫑 1 Paprika",
            "🧅 1 kleine rote Zwiebel",
            "🥑 1 Avocado",
            "🫒 2 EL Olivenöl",
            "🍋 2 EL Limetten- oder Zitronensaft",
            "🧂 1 TL Kreuzkümmel, 1 TL Paprikapulver, Salz und Pfeffer",
            "🥄 1 TL Ahornsirup",
            "🌶️ ½ TL Chili (optional)"
        ],
        steps: [
            "Salat, Paprika, Zwiebel und Tomaten klein schneiden.",
            "Bohnen und Mais abspülen.",
            "Alles in eine große Schüssel geben.",
            "Avocado würfeln und hinzufügen.",
            "Olivenöl, Limettensaft, Ahornsirup und Gewürze dazugeben.",
            "Alles gut vermengen.",
            "Abschmecken und servieren."
        ],
        servingSize: "für 3 Personen",
        tip: "Für noch mehr Protein kannst du gewürfelten Tofu oder gekochte Quinoa hinzufügen."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content)
    }
}

#Preview {
    TexMexSalatView(
        recipe: .constant(
            Recipe(
                title: "Tex-Mex-Salat",
                imageName: "Tex-Mex-Salat",
                category: .unter_zwanzig,
                filters: [.nutFree, .highProtein, .glutenFree],
                isFavorite: false
            )
        )
    )
}

