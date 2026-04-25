//
//  Bookmark_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 21.04.26.
//

import SwiftUI
//import Combine

struct Recipe5: Identifiable, Equatable { //Struktur definiert
    let id = UUID() //Rezeptkarte bekommt eine eindeutige ID
    let title: String
    let description: String
    let imageName: String
    //→ Titel, Beschreibung und Bildname des Rezepts
}

struct RezepteView2: View { //Bildschirm (View)
    
    @Environment(\.dismiss) var dismiss //Screen schließen (zurückgehen) möglich
    
    let startRecipes: [Recipe5] = [
        Recipe5(title: "Brownies",
                description: "Süßkartoffel Brownies, saftig und lecker",
                imageName: "Süßkartoffel Brownies"),
        
        Recipe5(title: "Mediterrane Reispfanne",
                description: "Tomaten-Paprika-Basis",
                imageName: "Mediterrane Reispfanne")
    ] //2 feste Beispiel-Rezepte
    
    @State private var recipes: [Recipe5] = [] //Liste der aktuell angezeigten Rezepte
    @State private var showDeleteAlert = false //Steuert, ob das Lösch-Popup angezeigt
    @State private var recipeToDelete: Recipe5? //Speichert das Rezept, das gelöscht werden soll
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ] //2 Spalten für das Grid
    
    @ViewBuilder
    private func destination(for recipe: Recipe5) -> some View { //Entscheidet, welche Detailseite geöffnet

        if recipe.title == "Brownies" { //Wenn Brownies gewählt
            SuesskartorffelBrowniesView( //Öffnet passende Detailseite
                recipe: .constant(
                    Recipe(
                        title: "Süßkartoffel-Brownies",
                        imageName: "Süßkartoffel Brownies",
                        category: .suess,
                        filters: [.glutenFree, .lowCarb],
                        isFavorite: false
                    )
                )
            )

        } else if recipe.title == "Mediterrane Reispfanne" { //Andere Rezepte bekommen andere Seiten
            RezeptDetailView(
                recipe: .constant(
                    Recipe(
                        title: "Mediterrane Reispfanne",
                        imageName: "Mediterrane Reispfanne",
                        category: .unter_zwanzig,
                        filters: [.glutenFree, .nutFree],
                        isFavorite: false
                    )
                )
            )

        } else {
            Text("Keine Detailseite vorhanden")
        } //Falls nichts passt
    }
    
    
    
    var body: some View { //alles angezeigt
        VStack(spacing: 6) {
            ZStack {
                
                // Mittig (unabhängig von Buttons)
                Text("Gespeichert") //Überschrift
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 231/255, green: 161/255, blue: 176/255))
                
                // Leiste mit Buttons
                HStack {
                    Button {
                        dismiss() //Zurück-Button
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button {
                        print("gespeichert_ohne_Bearbeitung")
                    } label: {
                        Image(systemName: "bookmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(red: 35/255, green: 170/255, blue: 150/255))
                    }
                }
            }
            .padding(.top, 12)
            
            Button("Gelöschte Rezepte wiederherstellen") {
                recipes = startRecipes //Originaldaten neu
            } //Setzt Rezepte zurück
            .font(.caption)
            .foregroundColor(Color(red: 35/255, green: 170/255, blue: 150/255))
            .frame(maxWidth: .infinity, alignment: .center)
            

            
            ScrollView { //Scrollbarer Bereich
                LazyVGrid(columns: columns, spacing: 20) { //Rezepte in 2 Spalten
                    ForEach(recipes) { recipe in //alle Rezepte durchgehen
                        NavigationLink {
                            destination(for: recipe) //Tippen öffnet sich Detailseite
                        } label: {
                            VStack(alignment: .leading, spacing: 6) { //Karte pro Rezept

                                ZStack(alignment: .topTrailing) {
                                    Image(recipe.imageName) //Rezeptbild
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 140)
                                        .frame(maxWidth: .infinity)
                                        .clipped()
                                        .cornerRadius(12)

                                    Button {
                                        recipeToDelete = recipe
                                        showDeleteAlert = true
                                        //Markiert Rezept zum Löschen + zeigt Popup.
                                    } label: {
                                        Image(systemName: "bookmark.fill")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(Color(red: 35/255, green: 170/255, blue: 150/255))
                                            .padding(8)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .shadow(radius: 2)
                                    }
                                    .padding(6)
                                }

                                Text(recipe.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .lineLimit(2)

                                Text(recipe.description)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                                //Textinfos
                            }
                            .padding(8)                         // 👈 wichtig für „weißen Rand“
                            .background(Color.white)            // 👈 das ist die Karte
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2) // 👈 sanfte Umrandung
                        }
                    }
                }
                .padding(.horizontal, 1)
                .padding(.vertical, 10)
            }//Ende of ScrollView
        }
        .padding(.horizontal)
        .background(
            Color(red: 247/255, green: 253/255, blue: 252/255)
                .ignoresSafeArea() //Hintergrunddesign
        )
        .onAppear {
            recipes = startRecipes
        } //Daten beim Start geladen
        .alert("Willst du das Rezept aus deiner Sammlung entfernen?", isPresented: $showDeleteAlert) { //Popup beim Löschen
            Button("Nein", role: .cancel) { }
            Button("Ja", role: .destructive) {
                if let recipeToDelete {
                    recipes.removeAll { $0.id == recipeToDelete.id } //Rezept aus Liste
                }
            }
        }
        .navigationBarBackButtonHidden(true) //Standard-Back-Button wird versteckt (weil schon ein arrow zurück
    }
}

#Preview {
    NavigationStack {
            RezepteView2()
    }
}
