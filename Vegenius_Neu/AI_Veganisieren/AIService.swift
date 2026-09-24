//
//  AIService.swift
//  Vegenius_Neu
//
//  Created by TA620 on 25.03.26.
//

import Foundation

class OpenAIService {
    
    private let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY fehlt")
        }
        print("🔑 API_KEY geladen: \(key.prefix(10))...")  // ← Diese Zeile hinzufügen
        return key
    }()
    
    func veganize(recipe: String) async throws -> String {
        let url = URL(string: "https://api.openai.com/v1/responses")!
        
        // Prompt für die AI
        let prompt = """
        Du bist ein Experte für vegane Ernährung.
        Ersetze alle nicht-veganen Zutaten durch passende vegane Alternativen.
        Behalte den Kontext des Rezeptes (Backen, Kochen, Grillen etc.) Wenn z. B. Ei ersetzt wird, dann achte besonders auf die Funktion des Eis z. B. beim Brownie als Bindemittel und beim Kaiserschmarrn für die Fluffigkeit. Die Funktion muss nicht im veganen Rezept stehen. Es soll alles sehr übersichtlich. Die einzelnen Zutaten sollen in einzelnen Boxen untereinander stehen. Für alle veganen Zutaten, die du ersetzt hast, sollst du auch Alternativen angeben in diesem Format Tofu | Alternative: Tempeh, Seitan
        Gib das Ergebnis exakt so aus:

        Name des veganen Gerichts

        Zutaten für ... Personen

        Zutaten

        ...

        Zubereitung

        ...
        
        Gib nur das vegane Rezept ohne Erklärungen an. Wenn es mehrere Alternativen für eine Zutat gibt, dann schreibe die hin. Es sollen keine 2 Zutaten in einer Zeile stehen.
        WICHTIG:
        - Schreibe jede Zutat IMMER im Format:
          [Menge] [Einheit] [Zutat]
        - Keine doppelten Angaben
        - Keine vollständigen Sätze in Zutaten
        - Alternative nur nach " | Alternative:"

        
        \(recipe)
        """
        
        // Request-Body
        let body: [String: Any] = [
            "model": "gpt-5.6-terra",
            "input": prompt
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Statuscode prüfen
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
        }
        
        // Antwort parsen
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NSError(
                domain: "OpenAI",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Ungültige API-Antwort"
                ]
            )
        }

        // Responses API liefert den fertigen Text über output_text
        // Antwort aus der Responses API auslesen
        guard let output = json["output"] as? [[String: Any]] else {
            print("❌ Kein output in der API-Antwort gefunden:")
            print(String(data: data, encoding: .utf8) ?? "")
            throw NSError(
                domain: "OpenAI",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Kein output in der API-Antwort gefunden"
                ]
            )
        }

        for item in output {
            guard let content = item["content"] as? [[String: Any]] else {
                continue
            }

            for part in content {
                if let text = part["text"] as? String {
                    return text
                }
            }
        }

        print("❌ Kein Rezepttext gefunden:")
        print(String(data: data, encoding: .utf8) ?? "")

        throw NSError(
            domain: "OpenAI",
            code: -1,
            userInfo: [
                NSLocalizedDescriptionKey: "Kein Rezepttext in der API-Antwort gefunden"
            ]
        )
    }
}
