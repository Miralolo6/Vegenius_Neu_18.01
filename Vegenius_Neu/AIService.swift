//
//  AIService.swift
//  Vegenius_Neu
//
//  Created by TA620 on 25.03.26.
//

import Foundation

class OpenAIService {
    
    private let apiKey = "OPENAI_API_KEY_REMOVED" // ohne Zeilenumbrüche!
    
    func veganize(recipe: String) async throws -> String {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        // Prompt für die AI
        let prompt = """
        Du bist ein Experte für vegane Ernährung.
        Ersetze alle nicht-veganen Zutaten durch passende vegane Alternativen.
        Behalte den Kontext des Rezeptes (Backen, Kochen, Grillen etc.).
        Gib das Ergebnis so aus:

        Original -> Vegan (kurze Erklärung)

        Rezept:
        \(recipe)
        """
        
        // Request-Body
        let body: [String: Any] = [
            "model": "gpt-4o-mini", // Modell aus deiner Key-Ausgabe
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.5
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
        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
            let choices = json["choices"] as? [[String: Any]],
            let message = choices.first?["message"] as? [String: Any],
            let content = message["content"] as? String
        else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Ungültige API-Antwort"])
        }
        
        return content
    }
}
