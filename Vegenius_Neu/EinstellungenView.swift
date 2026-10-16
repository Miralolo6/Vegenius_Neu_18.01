//
//  EinstellungenView.swift
//  Vegenius_Neu
//
//  Created by TA604 on 18.01.26.
//

import SwiftUI

// MARK: - Hilfsfunktion für Titel Farbe

func setTitelFarbe() {
    let appearance = UINavigationBarAppearance()

    appearance.largeTitleTextAttributes = [
        .foregroundColor: UIColor(Color("TitelRosa")),
        .font: UIFont.systemFont(ofSize: 28, weight: .semibold)
    ]

    appearance.titleTextAttributes = [
        .foregroundColor: UIColor(Color("TitelRosa")),
        .font: UIFont.systemFont(ofSize: 28, weight: .semibold)
    ]

    appearance.backgroundColor = UIColor(Color("BackgroundMint"))

    UINavigationBar.appearance().prefersLargeTitles = false
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}


// MARK: - Passwort Ändern
struct PasswortAendernView: View {
    @State private var altesPasswort = ""
    @State private var neuesPasswort = ""
    @State private var altesAnzeigen = false
    @State private var neuesAnzeigen = false

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("Altes Passwort")
                .font(.system(size: 20, weight: .medium))
            if altesAnzeigen {
                TextField("", text: $altesPasswort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("", text: $altesPasswort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button("Passwort anzeigen") {
                altesAnzeigen.toggle()
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.top, -8)

            Text("Neues Passwort")
                .font(.system(size: 20, weight: .medium))
            if neuesAnzeigen {
                TextField("", text: $neuesPasswort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("", text: $neuesPasswort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Button("Passwort anzeigen") {
                neuesAnzeigen.toggle()
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.top, -8)

            Button {
                print("Passwort geändert")
            } label: {
                Text("Passwort ändern")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 126/255, green: 222/255, blue: 211/255))
                    .cornerRadius(12)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationTitle("Passwort ändern")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Anmeldung
struct AnmeldungView: View {
    @State private var email = ""
    @State private var passwort = ""
    @State private var passwortAnzeigen = false
    @State private var fehler = ""

    func emailGueltig() -> Bool {
        return email.contains("@") && email.contains(".")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("E-Mail")
                .font(.system(size: 20, weight: .medium))
            TextField("", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            
            Text("Passwort")
                .font(.system(size: 20, weight: .medium))

            if passwortAnzeigen {
                TextField("", text: $passwort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("", text: $passwort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button("Passwort anzeigen") {
                passwortAnzeigen.toggle()
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.top, -8)

            

            Button {
                if !emailGueltig() {
                    fehler = "Bitte eine gültige E-Mail eingeben."
                } else {
                    fehler = ""
                    print("Anmelden tapped")
                }
            } label: {
                Text("Anmelden")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 126/255, green: 222/255, blue: 211/255))
                    .cornerRadius(12)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationTitle("Anmeldung")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Registrieren
struct RegistrierenView: View {
    @State private var email = ""
    @State private var passwort = ""
    @State private var passwortWiederholen = ""
    @State private var passwortAnzeigen = false
    @State private var passwortWiederholenAnzeigen = false
    @State private var fehler = ""

    func emailGueltig() -> Bool {
        return email.contains("@") && email.contains(".")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("E-Mail")
                .font(.system(size: 20, weight: .medium))
            TextField("", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            
            Text("Passwort")
                .font(.system(size: 20, weight: .medium))

            if passwortAnzeigen {
                TextField("", text: $passwort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("", text: $passwort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button("Passwort anzeigen") {
                passwortAnzeigen.toggle()
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.top, -8)

            Text("Passwort wiederholen")
                .font(.system(size: 20, weight: .medium))

            if passwortWiederholenAnzeigen {
                TextField("", text: $passwortWiederholen)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("", text: $passwortWiederholen)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button("Passwort anzeigen") {
                passwortWiederholenAnzeigen.toggle()
            }
            .foregroundColor(.secondary)
            .font(.footnote)
            .padding(.top, -8)


            if !fehler.isEmpty {
                Text(fehler)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                if !emailGueltig() {
                    fehler = "Bitte eine gültige E-Mail eingeben."
                } else {
                    fehler = ""
                    print("Registrieren tapped")
                }
            } label: {
                Text("Registrieren")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 126/255, green: 222/255, blue: 211/255))
                    .cornerRadius(12)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationTitle("Registrieren")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Account
struct AccountView: View {
    @State private var istAngemeldet = false

    var body: some View {
        VStack {

            NavigationLink(destination: PasswortAendernView()) {
                HStack {
                    Text("Passwort ändern")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
            }

            if !istAngemeldet {
                NavigationLink(destination: AnmeldungView()) {
                    HStack {
                        Text("Anmelden")
                            .foregroundColor(.primary)
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }

                NavigationLink(destination: RegistrierenView()) {
                    HStack {
                        Text("Registrieren")
                            .foregroundColor(.primary)
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }

            Spacer()

            if istAngemeldet {
                Button("Abmelden") {
                    istAngemeldet = false
                }

                Button("Account Löschen") {
                    print("Account Löschen tapped")
                }
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 40)
        .navigationTitle("Account")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "person.circle")
            }
        }
    }
}


// MARK: - Sicherheit & Privatsphäre
struct SicherheitView: View {

   private let titelFarbe = Color("TitelRosa")
   private let hintergrundFarbe = Color("BackgroundMint")

   var body: some View {
       ScrollView(showsIndicators: false) {
           VStack(alignment: .leading, spacing: 24) {

               // Kopfbereich
               VStack(alignment: .leading, spacing: 10) {


                   Text("Deine Privatsphäre zählt")
                       .font(.system(size: 27, weight: .bold))
                       .foregroundColor(.black)

                   Text("""
                   Bei Vegenius legen wir Wert auf einen \
                   verantwortungsvollen Umgang mit deinen \
                   persönlichen Daten und deiner Privatsphäre.
                   """)
                   .font(.system(size: 16))
                   .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                   .fixedSize(horizontal: false, vertical: true)
               }
               .padding(.top, 20)

               // Datenschutzbereiche
               VStack(spacing: 14) {

                   datenschutzKarte(
                       symbol: "person.crop.circle",
                       titel: "Persönliche Daten",
                       text: """
                       Informiere dich darüber, welche persönlichen \
                       Daten bei der Nutzung von Vegenius verarbeitet \
                       werden und zu welchen Zwecken dies geschieht.
                       """
                   )

                   datenschutzKarte(
                       symbol: "lock.shield",
                       titel: "Account & Passwort",
                       text: """
                       Verwende ein sicheres Passwort und teile es \
                       nicht mit anderen. Schütze deine Zugangsdaten \
                       vor unbefugtem Zugriff.
                       """
                   )

                   datenschutzKarte(
                       symbol: "sparkles",
                       titel: "KI-Funktionen",
                       text: """
                       Bei KI-gestützten Funktionen können eingegebene \
                       Inhalte an externe Dienste übermittelt werden. \
                       Gib keine sensiblen persönlichen Informationen \
                       ein, bevor du die geltenden Datenschutzhinweise \
                       geprüft hast.
                       """
                   )

                   datenschutzKarte(
                       symbol: "doc.text",
                       titel: "Deine Datenschutzrechte",
                       text: """
                       Du kannst im Rahmen der geltenden Gesetze \
                       Rechte auf Auskunft, Berichtigung und Löschung \
                       deiner personenbezogenen Daten haben.
                       """
                   )
               }

               // Abschlusshinweis
               HStack(alignment: .top, spacing: 12) {
                   Image(systemName: "info.circle.fill")
                       .font(.system(size: 20))
                       .foregroundColor(titelFarbe)

                   VStack(alignment: .leading, spacing: 5) {
                       Text("Fragen zum Datenschutz?")
                           .font(.system(size: 16, weight: .semibold))
                           .foregroundColor(.primary)

                       Text("""
                       Wende dich bei Fragen zur Verarbeitung deiner \
                       Daten an den zuständigen Ansprechpartner.
                       """)
                       .font(.system(size: 14))
                       .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                       .fixedSize(horizontal: false, vertical: true)
                   }
               }
               .padding(16)
               .frame(maxWidth: .infinity, alignment: .leading)
               .background(Color.white)
               .clipShape(RoundedRectangle(cornerRadius: 16))
               .overlay {
                   RoundedRectangle(cornerRadius: 16)
                       .stroke(titelFarbe.opacity(0.12), lineWidth: 1)
               }
               .padding(.top, 4)
               .padding(.bottom, 24)
           }
           .padding(.horizontal, 22)
       }
       .background(hintergrundFarbe.ignoresSafeArea())
       .navigationTitle("Sicherheit & Privatsphäre")
       .navigationBarTitleDisplayMode(.inline)
       .toolbar {
           ToolbarItem(placement: .principal) {
               Text("Sicherheit & Privatsphäre")
                   .font(.system(size: 21, weight: .semibold))
                   .foregroundColor(titelFarbe)
                   .lineLimit(1)
                   .minimumScaleFactor(0.7)
           }
       }
       .onAppear {
           setTitelFarbe()
       }
   }

   // MARK: - Datenschutzkarte
   private func datenschutzKarte(
       symbol: String,
       titel: String,
       text: String
   ) -> some View {
       HStack(alignment: .top, spacing: 15) {

           Image(systemName: symbol)
               .font(.system(size: 23, weight: .medium))
               .foregroundColor(titelFarbe)
               .frame(width: 46, height: 46)
               .background(titelFarbe.opacity(0.10))
               .clipShape(RoundedRectangle(cornerRadius: 13))

           VStack(alignment: .leading, spacing: 8) {
               Text(titel)
                   .font(.system(size: 18, weight: .semibold))
                   .foregroundColor(.black)

               Text(text)
                   .font(.system(size: 15))
                   .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                   .lineSpacing(4)
                   .fixedSize(horizontal: false, vertical: true)
           }

           Spacer(minLength: 0)
       }
       .padding(18)
       .frame(maxWidth: .infinity, alignment: .leading)
       .background(Color.white)
       .clipShape(RoundedRectangle(cornerRadius: 18))
       .overlay {
           RoundedRectangle(cornerRadius: 18)
               .stroke(Color.black.opacity(0.035), lineWidth: 1)
       }
   }
}



// MARK: - Support
struct SupportView: View {

   private let titelFarbe = Color("TitelRosa")
   private let hintergrundFarbe = Color("BackgroundMint")

   var body: some View {
       ScrollView(showsIndicators: false) {
           VStack(alignment: .leading, spacing: 24) {

               // Kopfbereich
               VStack(alignment: .leading, spacing: 10) {
                   Text("Wie können wir dir helfen?")
                       .font(.system(size: 27, weight: .bold))
                       .foregroundColor(.black)

                   Text("Hier findest du Hilfe und Möglichkeiten, uns zu kontaktieren.")
                       .font(.system(size: 16))
                       .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                       .fixedSize(horizontal: false, vertical: true)
               }
               .padding(.top, 20)

               // Hilfe und FAQ
               supportKarte(
                   symbol: "questionmark.circle",
                   titel: "Hilfe & FAQ",
                   beschreibung: "Antworten auf häufige Fragen zur Nutzung von Vegenius."
               ) {
                   
               }

               // Kontakt
               VStack(alignment: .leading, spacing: 14) {
                   Text("Kontakt")
                       .font(.system(size: 21, weight: .semibold))
                       .foregroundColor(.black)

                   HStack(alignment: .top, spacing: 14) {
                       Image(systemName: "envelope")
                           .font(.system(size: 23))
                           .foregroundColor(titelFarbe)
                           .frame(width: 46, height: 46)
                           .background(titelFarbe.opacity(0.10))
                           .clipShape(RoundedRectangle(cornerRadius: 13))

                       VStack(alignment: .leading, spacing: 6) {
                           Text("Kontakt & Support")
                               .font(.system(size: 18, weight: .semibold))
                               .foregroundColor(.black)

                           Text("Du hast eine Frage oder benötigst Unterstützung? Sende uns eine Nachricht über „Problem melden“.")
                               .font(.system(size: 15))
                               .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                               .fixedSize(horizontal: false, vertical: true)

                           NavigationLink(destination: ProblemMeldenView()) {
                               HStack {
                                   Text("Problem melden")
                                   Image(systemName: "arrow.right")
                               }
                               .font(.system(size: 16, weight: .semibold))
                               .foregroundColor(.black)
                               .padding(.top, 8)
                           }
                       }

                       Spacer(minLength: 0)
                   }
                   .padding(18)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .background(Color.white)
                   .clipShape(RoundedRectangle(cornerRadius: 18))
               }

               // App-Version
               HStack(spacing: 14) {
                   Image(systemName: "iphone")
                       .font(.system(size: 23))
                       .foregroundColor(titelFarbe)
                       .frame(width: 46, height: 46)
                       .background(titelFarbe.opacity(0.10))
                       .clipShape(RoundedRectangle(cornerRadius: 13))

                   VStack(alignment: .leading, spacing: 5) {
                       Text("Vegenius")
                           .font(.system(size: 18, weight: .semibold))
                           .foregroundColor(.black)

                       Text("App-Version")
                           .font(.system(size: 14))
                           .foregroundColor(.secondary)
                   }

                   Spacer()

                   Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Nicht verfügbar")
                       .font(.system(size: 15, weight: .medium))
                       .foregroundColor(.black)
               }
               .padding(18)
               .frame(maxWidth: .infinity, alignment: .leading)
               .background(Color.white)
               .clipShape(RoundedRectangle(cornerRadius: 18))
               .padding(.bottom, 24)
           }
           .padding(.horizontal, 22)
       }
       .background(hintergrundFarbe.ignoresSafeArea())
       .navigationTitle("Support")
       .navigationBarTitleDisplayMode(.inline)
       .toolbar {
           ToolbarItem(placement: .principal) {
               Text("Support")
                   .font(.system(size: 22, weight: .semibold))
                   .foregroundColor(titelFarbe)
           }
       }
       .onAppear {
           setTitelFarbe()
       }
   }

   // MARK: - Support-Karte
   private func supportKarte<Inhalt: View>(
       symbol: String,
       titel: String,
       beschreibung: String,
       @ViewBuilder inhalt: () -> Inhalt
   ) -> some View {
       VStack(alignment: .leading, spacing: 12) {
           HStack(alignment: .top, spacing: 14) {
               Image(systemName: symbol)
                   .font(.system(size: 23))
                   .foregroundColor(titelFarbe)
                   .frame(width: 46, height: 46)
                   .background(titelFarbe.opacity(0.10))
                   .clipShape(RoundedRectangle(cornerRadius: 13))

               VStack(alignment: .leading, spacing: 6) {
                   Text(titel)
                       .font(.system(size: 18, weight: .semibold))
                       .foregroundColor(.black)

                   Text(beschreibung)
                       .font(.system(size: 15))
                       .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))
                       .fixedSize(horizontal: false, vertical: true)
               }
               Spacer(minLength: 0)
           }

           inhalt()
       }
       .padding(18)
       .frame(maxWidth: .infinity, alignment: .leading)
       .background(Color.white)
       .clipShape(RoundedRectangle(cornerRadius: 18))
   }
}



// MARK: - Problem melden
struct ProblemMeldenView: View {

    @State private var betreff = "Technisches Problem"
    @State private var nachricht = ""
    @State private var rueckmeldung = ""
    @State private var wirdGesendet = false

   private let titelFarbe = Color("TitelRosa")

   var body: some View {
       ScrollView {
           VStack(alignment: .leading, spacing: 22) {

               Text("Wir helfen dir gerne")
                   .font(.system(size: 27, weight: .bold))
                   .foregroundColor(.black)

               Text("Beschreibe möglichst genau, wobei du Unterstützung benötigst.")
                   .font(.system(size: 16))
                   .foregroundColor(Color(red: 0.20, green: 0.20, blue: 0.20))

               VStack(alignment: .leading, spacing: 9) {
                   Text("Thema")
                       .font(.system(size: 17, weight: .semibold))
                       .foregroundColor(.black)

                   Picker("Thema", selection: $betreff) {
                       Text("Technisches Problem").tag("Technisches Problem")
                       Text("Rezept oder KI-Funktion").tag("Rezept oder KI-Funktion")
                       Text("Account").tag("Account")
                       Text("Feedback und Verbesserung").tag("Feedback und Verbesserung")
                       Text("Sonstiges").tag("Sonstiges")
                   }
                   .pickerStyle(.menu)
                   .tint(.black)
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding(10)
                   .background(Color.white)
                   .clipShape(RoundedRectangle(cornerRadius: 12))
               }

               VStack(alignment: .leading, spacing: 9) {
                   Text("Deine Nachricht")
                       .font(.system(size: 17, weight: .semibold))
                       .foregroundColor(.black)

                   ZStack(alignment: .topLeading) {
                       if nachricht.isEmpty {
                           Text("Beschreibe hier dein Anliegen ...")
                               .foregroundColor(.gray)
                               .padding(.horizontal, 13)
                               .padding(.vertical, 17)
                       }

                       TextEditor(text: $nachricht)
                           .frame(minHeight: 180)
                           .padding(6)
                           .scrollContentBackground(.hidden)
                           .background(Color.clear)
                   }
                   .background(Color.white)
                   .clipShape(RoundedRectangle(cornerRadius: 14))
                   .overlay {
                       RoundedRectangle(cornerRadius: 14)
                           .stroke(Color.black.opacity(0.10), lineWidth: 1)
                   }
               }

               if !rueckmeldung.isEmpty {
                   Text(rueckmeldung)
                       .font(.system(size: 14, weight: .medium))
                       .foregroundColor(.black)
               }

               
               Button {
                   Task {
                       await supportNachrichtSenden()
                   }
               } label: {
                   HStack {
                       if wirdGesendet {
                           ProgressView()
                               .tint(.white)
                       } else {
                           Image(systemName: "paperplane.fill")
                       }

                       Text(wirdGesendet ? "Wird gesendet ..." : "Nachricht absenden")
                   }
                   .font(.headline)
                   .foregroundColor(.white)
                   .frame(maxWidth: .infinity)
                   .padding()
                   .background(Color("TitelRosa"))
                   .cornerRadius(12)
               }
               .disabled(wirdGesendet)


               Text("Gib bitte keine Passwörter oder anderen sensiblen persönlichen Daten ein.")
                   .font(.system(size: 13))
                   .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                   .fixedSize(horizontal: false, vertical: true)
           }
           .padding(22)
       }
       .background(Color("BackgroundMint").ignoresSafeArea())
       .navigationTitle("Problem melden")
       .navigationBarTitleDisplayMode(.inline)
       .toolbar {
           ToolbarItem(placement: .principal) {
               Text("Problem melden")
                   .font(.system(size: 22, weight: .semibold))
                   .foregroundColor(titelFarbe)
           }
       }
       .onAppear {
           setTitelFarbe()
       }
   }
    
    private func supportNachrichtSenden() async {
        let text = nachricht.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !text.isEmpty else {
            rueckmeldung = "Bitte beschreibe zuerst dein Anliegen."
            return
        }

        // HIER die echte HTTPS-Adresse deines Servers eintragen.
        guard let url = URL(
            string: "https://dvpcxahnwmaxyguymtaa.supabase.co/functions/v1/support"
        ) else {
            rueckmeldung = "Die Server-Adresse ist ungültig."
            return
        }

        wirdGesendet = true
        rueckmeldung = ""

        defer {
            wirdGesendet = false
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue(
                "application/json",
                forHTTPHeaderField: "Content-Type"
            )

            
            let daten: [String: String] = [
                "betreff": betreff,
                "nachricht": text
            ]

            request.httpBody = try JSONSerialization.data(
                withJSONObject: daten
            )

            
            let (responseData, response) = try await URLSession.shared.data(
                for: request
            )

            guard let httpResponse = response as? HTTPURLResponse else {
                rueckmeldung = "Ungültige Serverantwort."
                return
            }

            print("Support HTTP-Status: \(httpResponse.statusCode)")

            let serverText = String(
                data: responseData,
                encoding: .utf8
            ) ?? "(Keine Antwortdetails)"

            print("Support Serverantwort: \(serverText)")

            guard (200...299).contains(httpResponse.statusCode) else {
                rueckmeldung = "Versand fehlgeschlagen (HTTP \(httpResponse.statusCode))."
                return
            }


            nachricht = ""
            rueckmeldung = "Deine Nachricht wurde erfolgreich übermittelt."

        } catch {
            let fehler = error as NSError

            rueckmeldung = "Verbindungsfehler: \(fehler.localizedDescription)"

            print("Support-Fehler Domain: \(fehler.domain)")
            print("Support-Fehler Code: \(fehler.code)")
            print("Support-Fehler Beschreibung: \(fehler.localizedDescription)")
        }
    }

}



import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(
        context: Context
    ) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true

        // Native Steuerelemente bleiben sichtbar.
        // Das native Lautsprecher-Symbol lässt sich
        // nicht separat über AVPlayerViewController ausblenden.

        return controller
    }

    func updateUIViewController(
        _ controller: AVPlayerViewController,
        context: Context
    ) {
        if controller.player !== player {
            controller.player = player
        }
    }
}


// MARK: - Tutorial
import SwiftUI
import AVKit

struct TutorialView: View {

   private let titelFarbe = Color("TitelRosa")
   private let hintergrundFarbe = Color("BackgroundMint")

    private var videoURL: URL? {
        Bundle.main.url(
            forResource: "Vegenius_App_Tutorial",
            withExtension: "mp4"
        )
    }

    @State private var player: AVPlayer?
    @State private var videoLoadError = false
    @State private var videoImVollbild = false
    @State private var istStumm = false

   var body: some View {
       ScrollView(showsIndicators: false) {
           VStack(alignment: .leading, spacing: 22) {

               Text("Willkommen bei Vegenius!")
                   .font(.system(size: 27, weight: .bold))
                   .foregroundColor(.black)

               Text("""
               In diesem Tutorial erfährst du, wie du Vegenius
               verwendest und vegane Rezepte entdecken kannst.
               """)
               .font(.system(size: 16))
               .foregroundColor(.black.opacity(0.75))
               .fixedSize(horizontal: false, vertical: true)

               // Videokarte
               VStack(alignment: .leading, spacing: 14) {

                   Label("Tutorial-Video", systemImage: "play.circle.fill")
                       .font(.system(size: 20, weight: .semibold))
                       .foregroundColor(titelFarbe)

                   
                   if let player = player {
                       CustomVideoPlayer(player: player)
                           .aspectRatio(16.0 / 9.0, contentMode: .fit)
                           .clipShape(RoundedRectangle(cornerRadius: 14))
                           .fullScreenCover(isPresented: $videoImVollbild) {
                               ZStack(alignment: .topLeading) {
                                   Color.black
                                       .ignoresSafeArea()

                                   CustomVideoPlayer(player: player)
                                       .ignoresSafeArea()

                                   Button {
                                       videoImVollbild = false
                                   } label: {
                                       Image(systemName: "xmark.circle.fill")
                                           .font(.system(size: 32))
                                           .foregroundColor(.white)
                                           .padding()
                                   }
                               }
                               .statusBarHidden()
                           }
                   }

                   Text("Sieh dir das Video an, um die wichtigsten Funktionen kennenzulernen.")
                       .font(.system(size: 15))
                       .foregroundColor(.black.opacity(0.75))
                       .fixedSize(horizontal: false, vertical: true)
               }
               .padding(18)
               .frame(maxWidth: .infinity, alignment: .leading)
               .background(Color.white)
               .clipShape(RoundedRectangle(cornerRadius: 18))

               // Kurze Anleitung
               VStack(alignment: .leading, spacing: 16) {

                   Text("Das kannst du in Vegenius machen")
                       .font(.system(size: 20, weight: .semibold))
                       .foregroundColor(.black)

                   tutorialPunkt(
                       symbol: "magnifyingglass",
                       titel: "Rezepte entdecken",
                       text: "Finde vegane Rezepte passend zu deinen Vorlieben."
                   )

                   tutorialPunkt(
                       symbol: "camera",
                       titel: "Gerichte veganisieren",
                       text: "Lerne die Funktionen kennen, mit denen du Gerichte vegan gestalten kannst."
                   )

                   tutorialPunkt(
                       symbol: "bookmark",
                       titel: "Rezepte speichern",
                       text: "Speichere interessante Rezepte, damit du sie später wiederfindest."
                   )
               }
               .padding(18)
               .frame(maxWidth: .infinity, alignment: .leading)
               .background(Color.white)
               .clipShape(RoundedRectangle(cornerRadius: 18))

           }
           .padding(.horizontal, 22)
           .padding(.vertical, 20)
       }
       .background(hintergrundFarbe.ignoresSafeArea())
       .navigationTitle("Tutorial")
       .navigationBarTitleDisplayMode(.inline)
       .toolbar {
           ToolbarItem(placement: .principal) {
               Text("Tutorial")
                   .font(.system(size: 22, weight: .semibold))
                   .foregroundColor(titelFarbe)
           }
       }
       .onAppear {
           setTitelFarbe()

           if let url = videoURL {
               let neuerPlayer = AVPlayer(url: url)
               neuerPlayer.isMuted = false

               player = neuerPlayer
               istStumm = false
               videoLoadError = false
           } else {
               videoLoadError = true
               print("Fehler: Vegenius_App_Tutorial.mp4 wurde nicht gefunden.")
           }
       }
       .onDisappear {
           player?.pause()
           player = nil
       }
   }

   private func tutorialPunkt(
       symbol: String,
       titel: String,
       text: String
   ) -> some View {
       HStack(alignment: .top, spacing: 13) {

           Image(systemName: symbol)
               .font(.system(size: 22))
               .foregroundColor(titelFarbe)
               .frame(width: 42, height: 42)
               .background(titelFarbe.opacity(0.10))
               .clipShape(RoundedRectangle(cornerRadius: 12))

           VStack(alignment: .leading, spacing: 5) {
               Text(titel)
                   .font(.system(size: 17, weight: .semibold))
                   .foregroundColor(.black)

               Text(text)
                   .font(.system(size: 15))
                   .foregroundColor(.black.opacity(0.75))
                   .fixedSize(horizontal: false, vertical: true)
           }
       }
   }
    private func tonUmschalten() {
        istStumm.toggle()
        player?.isMuted = istStumm
    }
}


// MARK: - Einstellungen (Hauptseite)
struct EinstellungenView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var notificationsOn = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                Color("BackgroundMint")
                    .ignoresSafeArea()

                VStack(spacing: 30) {

                    HStack {
                        /*Button("x") {
                            print("Close tapped")
                        }
                        .font(.title)
                        .foregroundColor(.black)*/
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.title)
                                .frame(width: 50, height: 50)
                        }

                        Spacer()

                        Text("Einstellungen")
                            .font(.system(size: 28, weight: .semibold))
                            .foregroundColor(Color("TitelRosa"))

                        Spacer()

                        /*Button("⚙︎") {
                            print("Settings tapped")
                        }
                        .font(.title)
                        .foregroundColor(.black)*/
                        
                        Button {
                            print("Settings tapped")
                        } label: {
                            VStack {
                                Image(systemName: "gearshape")
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .scaledToFit()
                                    .frame(width: 55, height: 55)
                            }
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 35) {

                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Text("Account")
                                    .font(.system(size: 20, weight: .medium))
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }

                        HStack {
                            Text("Benachrichtigungen")
                                .font(.system(size: 20, weight: .medium))
                                .fontWeight(.medium)
                            Spacer()
                            Toggle("", isOn: $notificationsOn)
                                .labelsHidden()
                                .tint(.green)
                        }

                        NavigationLink(destination: SicherheitView()) {
                            HStack {
                                Text("Sicherheit & Privatsphäre")
                                    .font(.system(size: 20, weight: .medium))
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }

                        NavigationLink(destination: SupportView()) {
                            HStack {
                                Text("Support")
                                    .font(.system(size: 20, weight: .medium))
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }

                        NavigationLink(destination: TutorialView()) {
                            HStack {
                                Text("Tutorial")
                                    .font(.system(size: 20, weight: .medium))
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.horizontal, 25)

                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear { setTitelFarbe() }
    }
}

#Preview {
    EinstellungenView()
}
