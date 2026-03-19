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
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("TitelRosa"))]
    appearance.titleTextAttributes = [.foregroundColor: UIColor(Color("TitelRosa"))]
    appearance.backgroundColor = UIColor(Color("BackgroundMint"))
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
                .fontWeight(.medium)
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

            Text("Neues Passwort")
                .fontWeight(.medium)
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

            Button {
                print("Passwort geändert")
            } label: {
                Text("Passwort ändern")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
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
    @State private var fehler = ""

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
                    print("Anmelden tapped")
                }
            } label: {
                Text("Anmelden")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
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
    @State private var fehler = ""

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
                } else {
                    fehler = ""
                    print("Registrieren tapped")
                }
            } label: {
                Text("Registrieren")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
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

// MARK: - Sicherheit
struct SicherheitView: View {
    var body: some View {
        Text("Datenschutz- und Sicherheitsbestimmungen")
            .navigationTitle("Sicherheit & Privatsphäre")
            .background(Color("BackgroundMint").ignoresSafeArea())
            .onAppear { setTitelFarbe() }
    }
}

// MARK: - Support
struct SupportView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            Text("Hilfe/FAQ")
            Text("Kontakt/Support")
            NavigationLink(destination: ProblemMeldenView()) {
                Text("Problem melden")
                    .foregroundColor(.primary)
            }
            Text("App Version")
            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationTitle("Support")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Problem Melden
struct ProblemMeldenView: View {
    @State private var nachricht = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("Hast Du ein Problem in der App gefunden? Bitte beschreibe das Problem, dass Du siehst.")
                .foregroundColor(.secondary)

            TextEditor(text: $nachricht)
                .frame(height: 200)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(12)

            Button {
                print("Nachricht: \\(nachricht)")
            } label: {
                Text("Absenden")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationTitle("Problem melden")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Tutorial
struct TutorialView: View {
    var body: some View {
        Text("Tutorial Video")
            .navigationTitle("Tutorial")
            .background(Color("BackgroundMint").ignoresSafeArea())
            .onAppear { setTitelFarbe() }
    }
}

// MARK: - Einstellungen (Hauptseite)
struct EinstellungenView: View {

    @State private var notificationsOn = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {

                Color("BackgroundMint")
                    .ignoresSafeArea()

                VStack(spacing: 30) {

                    HStack {
                        Button("x") {
                            print("Close tapped")
                        }
                        .font(.title)
                        .foregroundColor(.black)

                        Spacer()

                        Text("Einstellungen")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TitelRosa"))

                        Spacer()

                        Button("⚙︎") {
                            print("Settings tapped")
                        }
                        .font(.title)
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 35) {

                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Text("Account")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }

                        HStack {
                            Text("Benachrichtigungen")
                                .font(.body)
                                .fontWeight(.medium)
                            Spacer()
                            Toggle("", isOn: $notificationsOn)
                                .labelsHidden()
                                .tint(.green)
                        }

                        NavigationLink(destination: SicherheitView()) {
                            HStack {
                                Text("Sicherheit & Privatsphäre")
                                    .font(.body)
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
                                    .font(.body)
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
                                    .font(.body)
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
        .onAppear { setTitelFarbe() }
    }
}

#Preview {
    EinstellungenView()
}
