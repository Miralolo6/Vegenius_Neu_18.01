import Foundation
import Combine

class VeganViewModel: ObservableObject {
    
    @Published var inputText = ""
    @Published var resultText = ""
    @Published var isLoading = false
    
    private let service = OpenAIService()
    
    func veganize(completion: (() -> Void)? = nil) {
        isLoading = true

        Task {
            do {
                let result = try await service.veganize(recipe: inputText)

                await MainActor.run {
                    self.resultText = result
                    self.isLoading = false
                    completion?()
                }

            } catch {
                await MainActor.run {
                    self.isLoading = false
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
}
