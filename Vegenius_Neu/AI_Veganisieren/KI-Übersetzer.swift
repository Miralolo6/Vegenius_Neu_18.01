import Foundation
import Combine

class VeganViewModel: ObservableObject {
    
    @Published var inputText = ""
    @Published var resultText = ""
    @Published var isLoading = false
    
    private let service = OpenAIService()
    
    func veganize() {
        // 1. Leeren Input prüfen
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            self.resultText = "Bitte gib ein Rezept ein."
            return
        }

        Task {
            await MainActor.run { self.isLoading = true }

            defer {
                Task { @MainActor in self.isLoading = false }
            }

            do {
                // 2. API-Aufruf
                let result = try await service.veganize(recipe: trimmed)
                
                // 3. Ergebnis sicher in UI anzeigen
                await MainActor.run {
                    self.resultText = result
                }
            } catch {
                await MainActor.run {
                    self.resultText = "Fehler beim Veganisieren: \(error.localizedDescription)"
                }
            }
        }
    }
}
