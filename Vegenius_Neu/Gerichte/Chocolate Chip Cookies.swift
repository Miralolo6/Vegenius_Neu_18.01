
import SwiftUI

struct ChocolateChipCookiesView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "150 g Mehl",
            "50 g Rohrzucker oder Kokosblütenzucker",
            "50 g brauner Zucker",
            "60 ml Pflanzenöl",
            "50 ml Hafer- oder Sojamilch",
            "1 Prise Salz",
            "1 TL Vanilleextrakt",
            "1 TL Backpulver",
            "50–70 g vegane, nussfreie Schokotropfen"
        ],
        steps: [
            "Zucker, Pflanzenöl, Pflanzenmilch und Vanilleextrakt verrühren.",
            "Mehl, Backpulver und Salz vermischen und kurz unter die feuchten Zutaten rühren.",
            "Die Schokotropfen unterheben.",
            "Den Teig portionsweise auf ein mit Backpapier ausgelegtes Backblech setzen und leicht flach drücken.",
            "Bei 180 °C Ober-/Unterhitze etwa 10–12 Minuten backen.",
            "Die Cookies kurz auf dem Blech abkühlen lassen und anschließend servieren."
        ],
        servingSize: "12–14 Cookies",
        tip: "Die Cookies nicht zu lange backen. Beim Abkühlen werden sie fester und bleiben innen weich."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    ChocolateChipCookiesView(
        recipe: .constant(
            Recipe(
                title: "Chocolate Chip Cookies",
                imageName: "Chocolate Chip Cookies",
                category: .suess,
                filters: [.nutFree]
            )
        )
    )
}

