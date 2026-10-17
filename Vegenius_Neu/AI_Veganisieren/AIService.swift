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
        
        ENTSCHEIDE ZUERST, WAS DER NUTZER EINGEGEBEN HAT:

        1. Wenn der Nutzer nur einen einzelnen Begriff oder eine einzelne Zutat eingibt,
           zum Beispiel "Milch", "Ei", "Butter" oder "Tofu":
           - Gib nur die passende vegane Alternative aus.
           - Erstelle KEIN vollständiges Rezept.
           - Verwende KEINE Überschriften wie "Zutaten" oder "Zubereitung".
           - Verwende KEINE Markdown-Formatierung.
           - Verwende KEINE Zeichen wie ">", "#", "*" oder Aufzählungszeichen.
           - Gib nur den Namen der veganen Alternative aus.
           - Wenn sinnvoll, nenne mehrere Alternativen, getrennt durch Kommas.

        
        2. Entscheide anhand der Nutzereingabe:

           - Wenn der Nutzer nur eine einzelne Zutat nennt,
             zum Beispiel "Butter", "Milch", "Ei" oder "Tofu":
             Gib nur passende vegane Alternativen aus.
             Erstelle kein Rezept.

           - Wenn der Nutzer einen Gerichtsnamen oder ein Rezept nennt,
             zum Beispiel "Baumstriezel-Rezept", "Pancakes"
             oder "Rezept für Schokoladenkuchen":
             Erstelle ein vollständiges veganes Rezept
             mit Zutaten und Zubereitung.
             Gib niemals nur den Namen des Gerichts zurück.

           - Wenn der Nutzer mehrere Zutaten eingibt:
             Ersetze nicht-vegane Zutaten durch vegane Alternativen.
             Wenn die Eingabe kein Gericht bezeichnet, gib eine
             übersichtliche Zutatenliste mit den Alternativen aus.


        FORMATREGELN FÜR REZEPTE:
        - Gib den Namen des veganen Gerichts aus.
        - Gib die Zutaten für ... Personen aus, falls bekannt.
        - Verwende die Überschriften "Zutaten" und "Zubereitung".
        - Schreibe jede Zutat im Format: [Menge] [Einheit] [Zutat]
        - Keine doppelten Angaben.
        - Keine vollständigen Sätze in der Zutatenliste.
        - Alternative nur nach " | Alternative:".
        - Keine Markdown-Zeichen wie "#", ">" oder "*".
        - Gib keine zusätzlichen Erklärungen aus.
        
        
        WICHTIG FÜR ZUTATEN UND ALTERNATIVEN:
        - Gib jede Zutat in einer eigenen Zeile aus.
        - Für jede Zutat, bei der sinnvolle vegane Alternativen existieren,
          gib Alternativen im folgenden Format aus:
          60 g vegane Butter | Alternative: vegane Margarine, Rapsöl
        - Verwende das Format " | Alternative:" exakt so.
        - Nenne mindestens eine sinnvolle Alternative, wenn eine verfügbar ist.
        - Gib keine Alternative an, wenn sie für die Zutat nicht sinnvoll ist.
        - Die ursprüngliche Zutat steht vor "| Alternative:".
        - Schreibe Alternativen durch Kommas getrennt.
        - Erfinde keine unnötigen Alternativen.


        Nutzereingabe:
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
