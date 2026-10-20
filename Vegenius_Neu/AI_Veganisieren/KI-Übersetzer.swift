import Foundation
import Combine

class VeganViewModel: ObservableObject {
    
    @Published var inputText = ""
    @Published var resultText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = OpenAIService()
    
    
    func veganize(completion: (() -> Void)? = nil) {
        let recipe = inputText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !recipe.isEmpty, !isLoading else {
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let result = try await service.veganize(
                    recipe: recipe
                )

                await MainActor.run {
                    self.resultText = self.cleanResult(result)
                    self.isLoading = false
                    completion?()
                }

            } catch {
                await MainActor.run {
                    self.isLoading = false
                    self.errorMessage =
                        "Das Rezept konnte nicht verarbeitet werden. "
                        + error.localizedDescription
                }
            }
        }
    }

    func reprocessWithAlternative(baseRecipe: String, ingredients: [Ingredient]) {
        
        let modifiedIngredients = ingredients.map { ing in
            ing.selectedAlternative ?? ing.name
        }

        let prompt = """
        Überarbeite dieses vegane Rezept basierend auf folgenden Zutaten:
        
        \(modifiedIngredients.joined(separator: ", "))
        
        Original Rezept:
        \(baseRecipe)
        """

        Task {
            let result = try? await service.veganize(recipe: prompt)

            await MainActor.run {
                self.resultText = result ?? self.resultText
            }
        }
    }
    
    private func cleanResult(_ text: String) -> String {
        text
            .components(separatedBy: .newlines)
            .map { line in
                line.replacingOccurrences(
                    of: #"^\s*>\s*"#,
                    with: "",
                    options: .regularExpression
                )
            }
            .joined(separator: "\n")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }

}
