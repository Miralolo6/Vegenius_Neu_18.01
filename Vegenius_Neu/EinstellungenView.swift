//  EinstellungenView.swift
//  Vegenius_Neu
//
//  Created by TA604 on 18.01.26.
//

import SwiftUI

// MARK: - Hilfsfunktion für Titel Farbe
import UserNotifications

func setTitelFarbe() {
    let appearance = UINavigationBarAppearance()
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color("TitelRosa"))]
    appearance.titleTextAttributes = [.foregroundColor: UIColor(Color("TitelRosa"))]
    appearance.backgroundColor = UIColor(Color("BackgroundMint"))
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
}

func askNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        print("Notifications erlaubt: \(granted)")
    }
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
                                    .background(Color(red: 126/255, green: 222/255, blue: 211/255))
                                    .cornerRadius(12)
                            }
                            .padding(.top, 10)

                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 30)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("Passwort ändern")
                                    .foregroundColor(Color("TitelRosa"))
                            }
                        }
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
                                .background(Color(red: 126/255, green: 222/255, blue: 211/255))
                                .cornerRadius(12)
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 30)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("Anmeldung")
                                .foregroundColor(Color("TitelRosa"))
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
    @State private var passwortWiederholen = ""
    @State private var fehler = ""
    @State private var zeigeAlert = false

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
                             } else if passwort != passwortWiederholen {
                                 fehler = "Passwörter stimmen nicht überein."
                             } else {
                                 fehler = ""
                                 zeigeAlert = true
                             }
                         } label: {
                             Text("Registrieren")
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
                      .navigationBarTitleDisplayMode(.inline)
                      .toolbar {
                          ToolbarItem(placement: .principal) {
                              Text("Registrieren")
                                  .foregroundColor(Color("TitelRosa"))
                          }
                      }
                      .background(Color("BackgroundMint").ignoresSafeArea())
                      .onAppear { setTitelFarbe() }

                      .alert("Erfolgreich!", isPresented: $zeigeAlert) {
                          Button("OK") {
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
    @State private var istAngemeldet = false

    var body: some View {
        VStack {

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

            Spacer()

            if istAngemeldet {
                Button("Abmelden") {
                    istAngemeldet = false
                }

                Button("Account Löschen") {
                    print("Account Löschen tapped")
                }
                .foregroundColor(.red)
            }
        }
        .padding(.bottom, 40)
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Account")
                    .foregroundColor(Color("TitelRosa"))
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "person.circle")
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Sicherheit
struct SicherheitView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {

                Text("Datenschutz & Sicherheit")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Diese App speichert nur notwendige Daten wie E-Mail und Passwort, um die Nutzung zu ermöglichen.")

                Text("Deine Daten werden vertraulich behandelt und nicht an Dritte weitergegeben.")

                Text("Benachrichtigungen werden nur verwendet, um dich über wichtige Funktionen oder Updates zu informieren.")


                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Sicherheit & Privatsphäre")
                    .foregroundColor(Color("TitelRosa"))
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}

// MARK: - Support
struct SupportView: View {
    var body: some View {
        VStack(spacing: 25) {

            NavigationLink(destination: Text("Hilfe/FAQ Seite")) {
                HStack {
                    Text("Hilfe/FAQ")
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink(destination: Text("Kontakt Seite")) {
                HStack {
                    Text("Kontakt/Support")
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink(destination: ProblemMeldenView()) {
                HStack {
                    Text("Problem melden")
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
            }
            .buttonStyle(PlainButtonStyle())

            HStack {
                Text("App Version")
                    .foregroundColor(.black)

                Spacer()

                Text("1.0")
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 25)
        .padding(.top, 30)

        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Support")
                    .foregroundColor(Color("TitelRosa"))
            }
        }

        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}
// MARK: - Problem Melden
struct ProblemMeldenView: View {
    @State private var nachricht = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("Problem beschreiben")

            TextEditor(text: $nachricht)
                .frame(height: 200)

            Button {
                print(nachricht)
            } label: {
                Text("Absenden")
            }

            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Problem melden")
                    .foregroundColor(Color("TitelRosa"))
            }
        }
        .background(Color("BackgroundMint").ignoresSafeArea())
        .onAppear { setTitelFarbe() }
    }
}


// MARK: - Tutorial
struct TutorialView: View {
    var body: some View {
        Text("Tutorial Video")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Anmeldung")
                        .foregroundColor(Color("TitelRosa"))
                }
            }
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
                    Spacer().frame(height: 10)

                    ZStack {
                        Text("Einstellungen")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("TitelRosa"))

                        HStack {
                            // X links
                            Button {
                                print("Close tapped")
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .font(.title2)
                            }

                            Spacer()

                            
                            Image(systemName: "gearshape")
                                .foregroundColor(.black)
                                .font(.title)
                                .frame(width: 55, height: 55)
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 35) {

                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Text("Account")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }

                        
                        HStack {
                            Text("Benachrichtigungen")
                                .foregroundColor(.black)

                            Spacer()

                            Toggle("", isOn: $notificationsOn)
                                .labelsHidden()
                                .tint(.green)
                                .onChange(of: notificationsOn) {
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
#Preview {
    EinstellungenView()
}
