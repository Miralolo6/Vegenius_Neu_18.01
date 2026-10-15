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

// MARK: - Sicherheit
struct SicherheitView: View {
    var body: some View {
        Text("Datenschutz- und Sicherheitsbestimmungen")
            .font(.system(size: 14, weight: .regular))
            .navigationTitle("Sicherheit & Privatsphäre")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("BackgroundMint").ignoresSafeArea())
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Sicherheit & Privatsphäre")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color("TitelRosa"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            }
                        }
                        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Support
struct SupportView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            
            Color("BackgroundMint")
                .ignoresSafeArea()
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
                    .background(Color(red: 126/255, green: 222/255, blue: 211/255))
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
        ZStack(alignment: .bottom) {
            
            Color("BackgroundMint")
                .ignoresSafeArea()
            Text("Tutorial Video")
                .navigationTitle("Tutorial")
                .background(Color("BackgroundMint").ignoresSafeArea())
                .onAppear { setTitelFarbe() }
        }
        .padding(.horizontal, 25)
        .padding(.top, 30)
        .navigationTitle("Support")
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
        ZStack(alignment: .bottom) {
            
            Color("BackgroundMint")
                .ignoresSafeArea()
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
        }
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
                        /*Button("x") {
                            print("Close tapped")
                        }
                        .font(.title)
                        .foregroundColor(.black)*/
                        
                        Button {
                            print("Close tapped")
                        } label: {
                            VStack {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .font(.title)
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
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
        .onAppear { setTitelFarbe() }
    }
}

#Preview {
    EinstellungenView()
}
