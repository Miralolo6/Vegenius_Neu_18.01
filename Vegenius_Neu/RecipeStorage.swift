import Foundation

struct RecipeStorage {

    private static let key = "savedRecipes"

    // MARK: - Prüfen, ob es dasselbe Rezept ist
    private static func isSameRecipe(_ first: Recipe, _ second: Recipe) -> Bool {
        
        // AI-generierte Rezepte haben eine feste UUID
        if first.isGenerated || second.isGenerated {
            return first.id == second.id
        }
        
        // Normale Rezepte erkennen wir über Titel + Bild
        return first.title == second.title &&
               first.imageName == second.imageName
    }

    // MARK: - Alle Rezepte speichern

    static func saveRecipes(_ recipes: [Recipe]) {
        do {
            let data = try JSONEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Fehler beim Speichern der Rezepte: \(error)")
        }
    }
    


    // MARK: - Alle Rezepte laden

    static func loadRecipes() -> [Recipe] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }

        do {
            return try JSONDecoder().decode(
                [Recipe].self,
                from: data
            )
        } catch {
            print("Fehler beim Laden der Rezepte: \(error)")
            return []
        }
    }

    // MARK: - Rezept hinzufügen

    static func addRecipe(_ recipe: Recipe) {
        var recipes = loadRecipes()

        if !recipes.contains(where: {
            isSameRecipe($0, recipe)
        }) {
            recipes.append(recipe)
            saveRecipes(recipes)
        }
    }

    // MARK: - Rezept entfernen

    static func removeRecipe(_ recipe: Recipe) {
        var recipes = loadRecipes()

        recipes.removeAll {
            isSameRecipe($0, recipe)
        }

        saveRecipes(recipes)
    }

    // MARK: - Prüfen, ob gespeichert

    static func isSaved(_ recipe: Recipe) -> Bool {
        let recipes = loadRecipes()

        return recipes.contains {
            isSameRecipe($0, recipe)
        }
    }
}
