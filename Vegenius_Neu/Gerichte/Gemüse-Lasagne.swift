
import SwiftUI

struct GemueseLasagneView: View {
    @Binding var recipe: Recipe

    private let content = RecipeContent(
        ingredients: [
            "200 g glutenfreie Lasagneplatten",
            "1 Zucchini",
            "1 Karotte",
            "1 Paprika",
            "1 Zwiebel",
            "1 Knoblauchzehe",
            "400 g gehackte Tomaten aus der Dose",
            "1 EL Olivenöl",
            "150 ml Pflanzenmilch",
            "1 EL Maisstärke",
            "Salz und Pfeffer",
            "Oregano oder Basilikum"
        ],
        steps: [
            "Zucchini, Karotte, Paprika, Zwiebel und Knoblauch klein schneiden.",
            "Öl in einer Pfanne erhitzen und Zwiebel sowie Knoblauch 2–3 Minuten anbraten.",
            "Das restliche Gemüse hinzufügen und 4–5 Minuten mitbraten.",
            "Gehackte Tomaten und Gewürze einrühren und etwa 5 Minuten köcheln lassen.",
            "Pflanzenmilch und Maisstärke glatt verrühren und in einem kleinen Topf unter Rühren 2–3 Minuten erhitzen, bis die Sauce eindickt.",
            "Gemüsesauce und Lasagneplatten abwechselnd in eine Auflaufform schichten.",
            "Die weiße Sauce gleichmäßig darüber verteilen.",
            "Bei 180 °C Ober-/Unterhitze etwa 30–35 Minuten backen. Die Garzeit gegebenenfalls an die Lasagneplatten anpassen.",
            "Vor dem Servieren kurz abkühlen lassen."
        ],
        servingSize: "3 Personen",
        tip: "Vor dem Servieren mit frischem Basilikum garnieren."
    )

    var body: some View {
        RecipeDetailView(
            recipe: $recipe,
            content: content
        )
    }
}

#Preview {
    GemueseLasagneView(
        recipe: .constant(
            Recipe(
                title: "Gemüse-Lasagne",
                imageName: "Gemüse-Lasagne",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree]
            )
        )
    )
}

