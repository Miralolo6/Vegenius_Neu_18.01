
import SwiftUI

struct BananenbrotView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "3 reife Bananen",
            "200 g glutenfreies Mehl",
            "50 g Ahornsirup oder Agavendicksaft",
            "50 ml Pflanzenöl",
            "50 ml ungesüßte Pflanzenmilch",
            "1 TL Backpulver",
            "1 Prise Salz",
            "1 TL Zimt (optional)",
            "1 TL Leinsamen + 3 TL Wasser"
        ],
        steps: [
            "Bananen mit einer Gabel zerdrücken.",
            "Leinsamen mit Wasser mischen und 5 Minuten quellen lassen.",
            "Öl, Pflanzenmilch und Ahornsirup zu den Bananen geben und gut verrühren.",
            "Mehl, Backpulver, Salz und optional Zimt hinzufügen. Alles kurz zu einem Teig verrühren.",
            "Den Teig in eine gefettete oder mit Backpapier ausgelegte Kastenform füllen.",
            "Bei 180 °C Ober-/Unterhitze etwa 40–45 Minuten backen. Mit der Holzstäbchenprobe prüfen, ob das Brot fertig ist.",
            "Abkühlen lassen und in Scheiben schneiden."
        ],
        servingSize: "Ca. 8 Scheiben",
        tip: "Für besonders saftiges Bananenbrot leicht überreife Bananen verwenden und den Teig nicht zu lange rühren."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    BananenbrotView(
        recipe: .constant(
            Recipe(
                title: "Bananenbrot",
                imageName: "Bananenbrot",
                category: .suess,
                filters: [.nutFree, .glutenFree]
            )
        )
    )
}

