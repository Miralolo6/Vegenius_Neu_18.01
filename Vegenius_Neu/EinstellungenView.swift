//  EinstellungenView.swift
//  Vegenius_Neu
//
//  Created by TA604 on 18.01.26.
//

import SwiftUI
// Lädt das Werkzeug für Benachrichtigungen von Apple
import UserNotifications

// MARK: - Hilfsfunktion für Titel Farbe
// Diese Funktion sorgt dafür dass die Navigationsleiste oben
// den richtigen Mint-Hintergrund und die rosa Schrift bekommt
func setTitelFarbe() {
    let appearance = UINavigationBarAppearance()
    // Setzt die Farbe für große Titel
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("TitelRosa"))]
    // Setzt die Farbe für kleine Titel
    appearance.titleTextAttributes = [.foregroundColor: UIColor(Color("TitelRosa"))]
    // Setzt den Hintergrund der Navigationsleiste
    appearance.backgroundColor = UIColor(Color("BackgroundMint"))
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}

// Diese Funktion fragt den Nutzer ob er Benachrichtigungen erlauben möchte
// Sie wird aufgerufen wenn man den Benachrichtigungs-Toggle einschaltet
func askNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        print("Notifications erlaubt: \(granted)")
    }
}

// MARK: - Passwort Ändern
struct PasswortAendernView: View {
    // @State bedeutet: diese Variable kann sich ändern
    // und der Bildschirm aktualisiert sich automatisch
    @State private var altesPasswort = ""   // speichert das alte Passwort
    @State private var neuesPasswort = ""   // speichert das neue Passwort
    @State private var altesAnzeigen = false  // steuert ob altes Passwort sichtbar ist
    @State private var neuesAnzeigen = false  // steuert ob neues Passwort sichtbar ist

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            // Großer rosa Titel zentriert oben
            Text("Passwort ändern")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("TitelRosa"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)

            Text("Altes Passwort")
                .fontWeight(.medium)

            // Wenn altesAnzeigen true ist, zeigen wir normalen Text
            // Sonst SecureField das den Text mit Punkten versteckt
            if altesAnzeigen {
                TextField("", text: $altesPasswort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("", text: $altesPasswort)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // .toggle() wechselt zwischen true und false
            // also zwischen sichtbar und versteckt
            Button("Passwort anzeigen") {
                altesAnzeigen.toggle()
            }
            .foregroundColor(.secondary)
            .font(.footnote)

            Text("Neues Passwort")
                .fontWeight(.medium)

            // Gleiches Prinzip für das neue Passwort
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

            // Button zum Speichern des neuen Passworts
            Button {
                print("Passwort geändert")
            } label: {
                Text("Passwort ändern")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.teal)
                    .cornerRadius(12)
            }
            .padding(.top, 10)

            Spacer() // schiebt alles nach oben
        }
        .padding(.horizontal, 25)
        .padding(.top, 20)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("") // leerer Titel damit der Zurück-Pfeil bleibt
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() } // wird aufgerufen wenn der Bildschirm erscheint
    }
}

// MARK: - Anmeldung
struct AnmeldungView: View {
    @State private var email = ""     // speichert die eingegebene E-Mail
    @State private var passwort = ""  // speichert das eingegebene Passwort
    @State private var fehler = ""    // speichert eine Fehlermeldung wenn nötig

    // Diese Funktion prüft ob die E-Mail ein @ und einen . enthält
    // Wenn ja gibt sie true zurück - also gültig
    func emailGueltig() -> Bool {
        return email.contains("@") && email.contains(".")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("E-Mail")
                .fontWeight(.medium)

            // Textfeld für die E-Mail Eingabe
            // .keyboardType(.emailAddress) zeigt die E-Mail Tastatur
            TextField("", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            Text("Passwort")
                .fontWeight(.medium)

            // SecureField versteckt den Text mit Punkten
            SecureField("", text: $passwort)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            // Fehlermeldung wird nur angezeigt wenn fehler nicht leer ist
            if !fehler.isEmpty {
                Text(fehler)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                // ! bedeutet "nicht" - wenn die E-Mail NICHT gültig ist
                if !emailGueltig() {
                    fehler = "Bitte eine gültige E-Mail eingeben."
                } else {
                    fehler = "" // Fehler leeren wenn alles ok ist
                    print("Anmelden tapped")
                }
            } label: {
                Text("Anmelden")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.teal)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                // Großer rosa Titel in der Toolbar
                Text("Anmelden")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TitelRosa"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Registrieren
struct RegistrierenView: View {
    @State private var email = ""
    @State private var passwort = ""
    @State private var passwortWiederholen = "" // zweites Passwortfeld zur Bestätigung
    @State private var fehler = ""
    @State private var zeigeAlert = false // steuert ob das Erfolgs-Popup erscheint

    func emailGueltig() -> Bool {
        return email.contains("@") && email.contains(".")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("E-Mail")
                .fontWeight(.medium)

            TextField("", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            Text("Passwort")
                .fontWeight(.medium)

            SecureField("", text: $passwort)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Text("Passwort wiederholen")
                .fontWeight(.medium)

            SecureField("", text: $passwortWiederholen)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !fehler.isEmpty {
                Text(fehler)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            Button {
                if !emailGueltig() {
                    fehler = "Bitte eine gültige E-Mail eingeben."
                // != bedeutet "ist nicht gleich"
                // wenn die zwei Passwörter verschieden sind, Fehler anzeigen
                } else if passwort != passwortWiederholen {
                    fehler = "Passwörter stimmen nicht überein."
                } else {
                    fehler = ""
                    zeigeAlert = true // Erfolgs-Popup anzeigen
                }
            } label: {
                Text("Registrieren")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.teal)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Registrieren")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TitelRosa"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
        // Alert ist ein Popup-Fenster
        // es erscheint wenn zeigeAlert auf true gesetzt wird
        .alert("Erfolgreich!", isPresented: $zeigeAlert) {
            Button("OK") {
                // Felder leeren nach erfolgreicher Registrierung
                email = ""
                passwort = ""
                passwortWiederholen = ""
            }
        } message: {
            Text("Du hast Dich registriert.")
        }
    }
}

// MARK: - Account
struct AccountView: View {
    // speichert ob der Nutzer angemeldet ist oder nicht
    @State private var istAngemeldet = false

    var body: some View {
        ZStack {
            Color("BackgroundMint").ignoresSafeArea()

            VStack(spacing: 25) {

                // Großer rosa Titel
                Text("Account")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TitelRosa"))
                    .frame(maxWidth: .infinity, alignment: .center)

                VStack(spacing: 15) {

                    // Passwort ändern wird NUR angezeigt wenn der Nutzer angemeldet ist
                    if istAngemeldet {
                        NavigationLink(destination: PasswortAendernView()) {
                            HStack {
                                Text("Passwort ändern")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }

                    // Anmelden und Registrieren werden NUR angezeigt
                    // wenn der Nutzer NICHT angemeldet ist
                    if !istAngemeldet {
                        NavigationLink(destination: AnmeldungView()) {
                            HStack {
                                Text("Anmelden")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }

                        NavigationLink(destination: RegistrierenView()) {
                            HStack {
                                Text("Registrieren")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }
                }

                Spacer()

                // Abmelden und Account löschen werden NUR angezeigt
                // wenn der Nutzer angemeldet ist
                if istAngemeldet {
                    VStack(spacing: 15) {
                        // Abmelden setzt istAngemeldet auf false
                        Button {
                            istAngemeldet = false
                        } label: {
                            Text("Abmelden")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.teal)
                                .cornerRadius(12)
                        }

                        // Account löschen Button in rot als Warnung
                        Button {
                            print("Account Löschen tapped")
                        } label: {
                            Text("Account löschen")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .padding()
        }
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Sicherheit
struct SicherheitView: View {
    var body: some View {
        ZStack {
            Color("BackgroundMint")
                .ignoresSafeArea()

            // ScrollView erlaubt dem Nutzer zu scrollen
            // falls der Inhalt länger als der Bildschirm ist
            ScrollView {
                VStack(spacing: 25) {

                    // Großer rosa Titel
                    Text("Sicherheit & Privatsphäre")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("TitelRosa"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 10)

                    // Text-Block mit leicht weißem Hintergrund
                    // opacity(0.3) bedeutet 30% Deckkraft - also fast durchsichtig
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Diese App speichert nur notwendige Daten wie E-Mail und Passwort, um die Nutzung zu ermöglichen.")
                        Text("Deine Daten werden vertraulich behandelt und nicht an Dritte weitergegeben.")
                        Text("Benachrichtigungen werden nur verwendet, um Dich über wichtige Funktionen oder Updates zu informieren.")
                    }
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(15) // abgerundete Ecken

                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Hilfe/FAQ
struct HilfeFAQView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Großer rosa Titel
                Text("Hilfe/FAQ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TitelRosa"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)

                // Group fasst mehrere Views zusammen
                // Hier immer eine fette Frage und darunter die Antwort
                Group {
                    Text("Was ist Vegenius?")
                        .fontWeight(.bold)
                    Text("Vegenius ist eine App, die nicht Vegane Rezepte schnell und einfach ins Vegane übersetzt.")
                }
                Group {
                    Text("Wie registriere ich mich?")
                        .fontWeight(.bold)
                    Text("Gehe zu Einstellungen → Account → Registrieren und gib deine E-Mail und ein Passwort ein.")
                }
                Group {
                    Text("Wie ändere ich mein Passwort?")
                        .fontWeight(.bold)
                    Text("Gehe zu Einstellungen → Account → Passwort ändern.")
                }
                Group {
                    Text("Wie melde ich ein Problem?")
                        .fontWeight(.bold)
                    Text("Gehe zu Einstellungen → Support → Problem melden.")
                }
                Group {
                    Text("Sind meine Daten sicher?")
                        .fontWeight(.bold)
                    Text("Ja! Wir speichern nur deine E-Mail und dein Passwort. Deine Daten werden nicht weitergegeben.")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("") // leer damit der Zurück-Pfeil bleibt
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Kontakt
struct KontaktView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Großer rosa Titel
                Text("Kontakt/Support")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TitelRosa"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)

                // Jede Group enthält eine fette Überschrift und einen Text darunter
                Group {
                    Text("Du hast Fragen oder Probleme?")
                        .fontWeight(.bold)
                    Text("Wir helfen dir gerne weiter!")
                }
                Group {
                    Text("E-Mail")
                        .fontWeight(.bold)
                    Text("support@vegenius.de")
                }
                Group {
                    Text("Entwickelt von")
                        .fontWeight(.bold)
                    Text("Vegenius Team – START CODING 2025/26")
                }
                Group {
                    Text("Probleme melden")
                        .fontWeight(.bold)
                    Text("Gehe zu Einstellungen → Support → Problem melden.")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Support
struct SupportView: View {
    var body: some View {
        ZStack {
            Color("BackgroundMint")
                .ignoresSafeArea()

            VStack(spacing: 30) {

                // Großer rosa Titel
                Text("Support")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TitelRosa"))
                    .multilineTextAlignment(.center)

                VStack(spacing: 25) {

                    // NavigationLink ist ein klickbarer Button
                    // der zu einem anderen Bildschirm navigiert
                    NavigationLink(destination: HilfeFAQView()) {
                        HStack {
                            Text("Hilfe/FAQ")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }

                    NavigationLink(destination: KontaktView()) {
                        HStack {
                            Text("Kontakt/Support")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }

                    NavigationLink(destination: ProblemMeldenView()) {
                        HStack {
                            Text("Problem melden")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }

                    // Kein NavigationLink - nur Text als Info
                    HStack {
                        Text("App Version")
                            .foregroundColor(.black)
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 25)

                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Problem Melden
struct ProblemMeldenView: View {
    @State private var nachricht = ""       // speichert den eingegebenen Text
    @State private var zeigeAlert = false   // steuert ob das Bestätigungs-Popup erscheint

    var body: some View {
        VStack(spacing: 20) {

            // Großer rosa Titel
            Text("Problem melden")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("TitelRosa"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 0)

            Text("Hast du ein Problem in der App gefunden?\nBitte beschreibe das Problem, das du siehst.")
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)

            // TextEditor ist ein mehrzeiliges Textfeld
            // wo der Nutzer einen längeren Text eingeben kann
            TextEditor(text: $nachricht)
                .frame(height: 150)
                .padding(8)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)

            Spacer()

            VStack(spacing: 30) {
                // Abbrechen Button - macht aktuell noch nichts
                Button {
                } label: {
                    Text("Abbrechen")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.teal)
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

                // Problem melden Button - zeigt das Bestätigungs-Popup
                Button {
                    zeigeAlert = true
                } label: {
                    Text("Problem melden")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.teal)
                        .cornerRadius(20)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal)
            .padding(.bottom, 200)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
        // Popup erscheint wenn zeigeAlert true wird
        .alert("Danke für dein Feedback!", isPresented: $zeigeAlert) {
            Button("OK") {
                nachricht = "" // Textfeld leeren nach dem Absenden
            }
        } message: {
            Text("Dein Problem wurde erfolgreich gemeldet. Wir kümmern uns darum!")
        }
    }
}

// MARK: - Tutorial
struct TutorialView: View {
    var body: some View {
        // ZStack stapelt Views übereinander
        // alignment: .top richtet alles oben aus
        ZStack(alignment: .top) {
            Color("BackgroundMint")
                .ignoresSafeArea()

            VStack {
                // Titel ganz oben
                Text("Tutorial")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TitelRosa"))
                    .padding(.top, 0)

                Spacer()

                Text("Tutorial Video")

                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Einstellungen (Hauptseite)
struct EinstellungenView: View {

    @State private var notificationsOn = false // speichert ob Benachrichtigungen an sind

    var body: some View {
        // NavigationStack ermöglicht die Navigation zwischen Bildschirmen
        // er muss nur einmal ganz außen sein
        NavigationStack {
            ZStack(alignment: .bottom) {

                Color("BackgroundMint")
                    .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer().frame(height: 10)

                    // ZStack + HStack Trick:
                    // Titel liegt zentriert, darüber liegt ein HStack
                    // mit X links und Zahnrad rechts
                    ZStack {
                        Text("Einstellungen")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TitelRosa"))

                        HStack {
                            // X Button zum Schließen links
                            Button {
                                print("Close tapped")
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }

                            Spacer()

                            // Zahnrad Symbol rechts
                            Image(systemName: "gearshape")
                                .foregroundColor(.black)
                                .font(.title)
                                .frame(width: 55, height: 55)
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 35) {

                        // Jeder NavigationLink öffnet einen anderen Bildschirm
                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Text("Account")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }

                        // Toggle ist ein Ein/Aus-Schalter
                        // onChange wird aufgerufen wenn der Toggle geändert wird
                        HStack {
                            Text("Benachrichtigungen")
                                .foregroundColor(.black)
                            Spacer()
                            Toggle("", isOn: $notificationsOn)
                                .labelsHidden()
                                .tint(.green)
                                .onChange(of: notificationsOn) {
                                    // wenn eingeschaltet, nach Erlaubnis fragen
                                    if notificationsOn {
                                        askNotificationPermission()
                                    }
                                }
                        }

                        NavigationLink(destination: SicherheitView()) {
                            HStack {
                                Text("Sicherheit & Privatsphäre")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }

                        NavigationLink(destination: SupportView()) {
                            HStack {
                                Text("Support")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }

                        NavigationLink(destination: TutorialView()) {
                            HStack {
                                Text("Tutorial")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.horizontal, 25)

                    Spacer()
                }
                .padding(.top, 10)
            }
        }
        .onAppear { setTitelFarbe() }
    }
}

// Zeigt eine Vorschau in Xcode ohne den Simulator zu starten
#Preview {
    EinstellungenView()
}
