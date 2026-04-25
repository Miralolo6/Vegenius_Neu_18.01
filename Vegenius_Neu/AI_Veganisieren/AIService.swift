//
//  AIService.swift
//  Vegenius_Neu
//
//  Created by TA620 on 25.03.26.
//

import Foundation //Importiert das Foundation-Framework, das grundlegende Funktionen für Networking, Datenverarbeitung, URLs usw. bereitstellt.




class OpenAIService { //OpenAIService, die für die Kommunikation mit der OpenAI-API zuständig
    
    private let apiKey: String = { //Deklariert eine private Konstante (apiKey)
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY fehlt")
        }//guard let prüft:
        //Existiert der Wert?
        //Ist er ein String?
        print("🔑 API_KEY geladen: \(key.prefix(10))...")  //Debug-Ausgabe: Zeigt die ersten 10 Zeichen des API-Keys in der Konsole, Hilfreich zum Prüfen, ob der Key geladen
        return key //Gibt den geladenen API-Key zurück
    }()
    
    func veganize(recipe: String) async throws -> String {//Definiert eine Funktion: `recipe`: Eingabe (Text eines Rezepts), async: läuft nebenläufig (für Netzwerkanfragen), throws: kann Fehler werfen, Rückgabe: `String` (das vegane Rezept)
        let url = URL(string: "https://api.openai.com/v1/chat/completions")! //Wohin die Anfrage geschickt
        
        // Prompt für die AI
        let prompt = """
        Du bist ein Experte für vegane Ernährung.
        Ersetze alle nicht-veganen Zutaten durch passende vegane Alternativen.
        Behalte den Kontext des Rezeptes (Backen, Kochen, Grillen etc.) Wenn z. B. Ei ersetzt wird, dann achte besonders auf die Funktion des Eis z. B. beim Brownie als Bindemittel und beim Kaiserschmarrn für die Fluffigkeit. Die Funktion muss nicht im veganen Rezept stehen. Es soll alles sehr übersichtlich. Die einzelnen Zutaten sollen in einzelnen Boxen untereinander stehen. Für alle veganen Zutaten, die du ersetzt hast, sollst du auch Alternativen angeben in diesem Format Tofu | Alternative: Tempeh, Seitan
        Gib das Ergebnis so aus:

        Zutaten für ... Personen (verstellbar)
        Zutaten
        Zubereitung
        
        Gib nur das vegane Rezept ohne Erklärungen an. Wenn es mehrere Alternativen für eine Zutat gibt, dann schreibe die hin. Es sollen keine 2 Zutaten in einer Zeile stehen.
        WICHTIG:
        - Schreibe jede Zutat IMMER im Format:
          [Menge] [Einheit] [Zutat]
        - Keine doppelten Angaben
        - Keine vollständigen Sätze in Zutaten
        - Alternative nur nach " | Alternative:"

        
        \(recipe)
        """ //genaue Anweisungen für die KI, Formatvorgaben für Zutaten & Ausgabe, das originale Rezept (\(recipe) wird eingesetzt)
        
        // Request-Body
        let body: [String: Any] = [
            "model": "gpt-4o-mini", // Welches KI-Modell soll antworten
            "messages": [
                ["role": "user", "content": prompt] //Nutzer schickt diesen Text an die KI
            ],
            "temperature": 0.5 //normal kreativ antworten, 0 → sehr genau, langweilig, 1 → kreativ, manchmal verrückt
        ]
        
        var request = URLRequest(url: url) //Anfrage, um etwas an diese Internet-Adresse schicken
        request.httpMethod = "POST" //Daten hingeschickt
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization") //API-Key wird mitgeschickt --> bin berechtigt
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") //Daten sind im JSON-Format --> strukturierte Art, Daten aufzuschreiben
        request.httpBody = try JSONSerialization.data(withJSONObject: body) //Wandelt deine Daten in **JSON** um → So kann der Server sie verstehen

        
        let (data, response) = try await URLSession.shared.data(for: request) //Anfrage wird abgeschickt --> Antwort kommt zurück
        
        // Statuscode prüfen
        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) { //Prüft: → Hat alles funktioniert?
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
        }
        
        // Antwort parsen
        guard
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], //Antwort wird gelesen (JSON → verständlich machen)
            let choices = json["choices"] as? [[String: Any]], //Antwort-Liste von der KI
            let message = choices.first?["message"] as? [String: Any], //Text der KI
            let content = message["content"] as? String //Holt den Text der KI
        else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Ungültige API-Antwort"]) //Das passiert, wenn etwas schiefgeht, Die Antwort von der API passt nicht, Daten fehlen oder sind falsch --> Dann: → wird ein Fehler ausgelöst
        }
        
        return content //Gibt das Ergebnis zurück → dein veganes Rezept
    }
}
