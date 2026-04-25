import Foundation //Foundation→ Grundfunktionen

import Combine //für Daten, die sich ändern (z. B. UI)

class VeganViewModel: ObservableObject { //ObservableObject = UI merkt, wenn sich etwas ändert
    
    @Published var inputText = "" //Text vom Nutzer (Rezept), wenn sich das ändert → UI wird aktualisiert
    @Published var resultText = "" //Ergebnis von der KI (veganes Rezept)
    @Published var isLoading = false //Zeigt an: true → lädt gerade, false → fertig
    
    private let service = OpenAIService() //Verbindung zur API
    
    func veganize(completion: (() -> Void)? = nil) { //Funktion starten
        isLoading = true //UI weiß gerade lädt

        Task { //Startet etwas im Hintergrund (async)
            do {
                let result = try await service.veganize(recipe: inputText) //Schickt Rezept an die KI --> wartet auf Antwort

                await MainActor.run { //Wechsel zum Haupt-Thread: Hintergrund-Thread = Küche (arbeitet), Haupt-Thread = Tisch (zeigt Ergebnis)
                    self.resultText = result //Speichert das Ergebnis
                    self.isLoading = false //Laden fertig
                    completion?() //Was soll am Ende noch passieren?, extra Code, der dazukommt wird angegeben
                }

            } catch { //Fehler passiert
                await MainActor.run {
                    self.isLoading = false //Stoppt Laden trotzdem
                }
            }
        }
    }
    func reprocessWithAlternative(baseRecipe: String, ingredients: [Ingredient]) { //Neue Version vom Rezept erstellen --> mit anderen Zutaten
        
        let modifiedIngredients = ingredients.map { ing in
            ing.selectedAlternative ?? ing.name
        } //wenn Alternative gewählt → nimm die, sonst → normale Zutat

        let prompt = """
        Überarbeite dieses vegane Rezept basierend auf folgenden Zutaten:
        
        \(modifiedIngredients.joined(separator: ", "))
        
        Original Rezept:
        \(baseRecipe)
        """ //Baut neuen Text für die KI; mit: neuen Zutaten, original Rezept

        Task { //Startet wieder im Hintergrund
            let result = try? await service.veganize(recipe: prompt) //Schickt neuen Prompt an KI, try? = bei Fehler → einfach nil

            await MainActor.run { //Wieder zurück zur UI
                self.resultText = result ?? self.resultText //Wenn Ergebnis da: benutze es, sonst: behalte das alte
            }
        }
    }
}
