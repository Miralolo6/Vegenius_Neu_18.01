
import SwiftUI

struct ZitronenmuffinsView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "250 g Mehl",
            "120 g Zucker",
            "1 Päckchen Vanillezucker",
            "2 TL Backpulver",
            "1 Prise Salz",
            "Abrieb von 1 Bio-Zitrone",
            "200 ml Pflanzenmilch",
            "80 ml neutrales Pflanzenöl",
            "2 EL Zitronensaft"
        ],
        steps: [
            "Backofen auf 180 °C Ober-/Unterhitze vorheizen.",
            "Mehl, Zucker, Vanillezucker, Backpulver, Salz und Zitronenabrieb vermischen.",
            "Pflanzenmilch, Öl und Zitronensaft hinzufügen.",
            "Alle Zutaten kurz zu einem glatten Teig verrühren.",
            "Den Teig gleichmäßig auf 12 Muffinförmchen verteilen.",
            "20–25 Minuten backen. Mit der Holzstäbchenprobe prüfen, ob die Muffins fertig sind.",
            "Die Muffins abkühlen lassen."
        ],
        servingSize: "12 Muffins",
        tip: "Für einen Zitronenguss 100 g Puderzucker mit 1–2 EL Zitronensaft verrühren und auf die abgekühlten Muffins geben."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    ZitronenmuffinsView(
        recipe: .constant(
            Recipe(
                title: "Zitronenmuffins",
                imageName: "Zitronenmuffins",
                category: .suess,
                filters: [.nutFree]
            )
        )
    )
}

