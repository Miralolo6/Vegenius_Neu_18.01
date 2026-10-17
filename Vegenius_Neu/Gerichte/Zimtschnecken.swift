
import SwiftUI

struct ZimtschneckenView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "250 g Mehl",
            "40 g weißer Zucker",
            "40 g brauner Zucker",
            "1 Prise Salz",
            "1 Päckchen Trockenhefe (7 g)",
            "150 ml Pflanzenmilch",
            "60 ml Pflanzenöl",
            "1–2 TL Zimt"
        ],
        steps: [
            "Pflanzenmilch leicht erwärmen.",
            "Mehl, weißen Zucker, Salz und Hefe in einer Schüssel vermischen.",
            "Pflanzenmilch und 40 ml Öl hinzugeben und 5–8 Minuten zu einem Teig kneten.",
            "Den Teig abdecken und 30–45 Minuten gehen lassen.",
            "Den Teig rechteckig ausrollen.",
            "Mit dem restlichen Öl bestreichen und braunen Zucker sowie Zimt darauf verteilen.",
            "Den Teig aufrollen und in Stücke schneiden.",
            "Die Schnecken in eine Auflaufform legen und weitere 10–15 Minuten ruhen lassen.",
            "Bei 180 °C etwa 20–25 Minuten backen."
        ],
        servingSize: "Ca. 8 Stück",
        tip: "Noch warm mit etwas Puderzucker oder einfachem Zuckerguss servieren."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    ZimtschneckenView(
        recipe: .constant(
            Recipe(
                title: "Zimtschnecken",
                imageName: "Zimtschnecken",
                category: .suess,
                filters: [.nutFree]
            )
        )
    )
}

