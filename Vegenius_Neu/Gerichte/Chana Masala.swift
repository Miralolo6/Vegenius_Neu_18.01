
import SwiftUI

struct ChanaMasalaView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "400 g Kichererbsen aus der Dose, abgespült",
            "400 g gehackte Tomaten aus der Dose",
            "1 Zwiebel",
            "2 Knoblauchzehen",
            "1 TL geriebener Ingwer",
            "1 EL Olivenöl",
            "100 g rote Linsen",
            "200 ml Wasser oder Gemüsebrühe",
            "1 TL Garam Masala",
            "1 TL Kreuzkümmel",
            "1 TL Paprikapulver",
            "Salz und Pfeffer",
            "Frischer Koriander oder Petersilie (optional)"
        ],
        steps: [
            "Zwiebel, Knoblauch und Ingwer fein schneiden.",
            "Öl in einem Topf erhitzen und die Zwiebel 2–3 Minuten anbraten.",
            "Knoblauch, Ingwer und Gewürze hinzufügen und etwa 1 Minute rösten.",
            "Tomaten, Linsen und Wasser oder Gemüsebrühe einrühren.",
            "10–12 Minuten köcheln lassen, bis die Linsen weich sind. Bei Bedarf etwas Flüssigkeit ergänzen.",
            "Kichererbsen hinzufügen und weitere 5–8 Minuten köcheln lassen.",
            "Mit Salz und Pfeffer abschmecken und nach Wunsch frische Kräuter hinzufügen.",
            "Warm servieren."
        ],
        servingSize: "3 Personen",
        tip: "Mit frischem Koriander und Reis servieren."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    ChanaMasalaView(
        recipe: .constant(
            Recipe(
                title: "Chana Masala",
                imageName: "Chana_Masala",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree, .highProtein]
            )
        )
    )
}

