//
//  Home_Filter_süß.swift
//  Vegenius_Neu
//
//  Created by ta633 on 18.01.26.
//

//Hallo

import SwiftUI //UI bauen
import Combine //Combine = Daten reagieren automatisch aktualisieren

final class RecipeStore: ObservableObject {
    //final class: fertiger Baukasten, versiegelt, Code bleibt stabil
    //class = Bauplan für Objekte
    //Typ, definiert der Rezepte verwalte
    //ObservableObject = SwiftUI kann Änderungen merken
    @Published var recipes: [Recipe] //Liste aller Rezepte @Published = UI aktualisiert sich automatisch bei Änderungen

    init(recipes: [Recipe] = []) {
        self.recipes = recipes //Startfunktion bekommt Rezepte oder leere Liste
    }

    func binding(for recipeID: UUID) -> Binding<Recipe>? { //findet ein Rezept und gibt Version vom Rezept zurück, die direkt mit der UI verbunden
        guard let index = recipes.firstIndex(where: { $0.id == recipeID }) else { return nil } //sucht Rezept in Liste, wenn nicht gefunden → nil
        return Binding(
            get: { self.recipes[index] },
            set: { self.recipes[index] = $0 }
        ) //verbindet UI direkt mit Rezept, Änderungen gehen direkt in die Liste zurück
    }
}

struct Recipe: Identifiable { //definiert wie Rezept aufgebaut
    let id = UUID() //edes Rezept eine eindeutige Kennung, damit SwiftUI jedes Element in der Liste sicher erkennen und verwalten kann
    let title: String //Name
    let imageName: String //Bild
    let category: Category //Kategorie (z.B. süß)
    let filters: Set<FilterType> //für Hashtags nur mit Werten von FilterType (von Hashtag)
    var isFavorite: Bool //gespeichert oder nicht
    
}

enum Category: String, CaseIterable { //Variable kann nur ein Element aus dieser Aufzählung haben; CaseIterable --> Programm alle Werte eines Enums durchgehen, feste Liste von Kategorien
    case alle = "Alle"
    case herzhaft = "Herzhaft"
    case suess = "Süß"
    case unter_zwanzig = "<20 min"
} //Filter-Buttons

enum FilterType: String, CaseIterable, Identifiable { //enum = Liste mit vorgegebenen Werten
    var id: String { rawValue } //SwiftUI braucht für Listen (ForEach) eine eindeutige ID pro Element

    case highProtein = "# highprotein" //Diese Auswahlmöglichkeiten sind fest
    case glutenFree = "# glutenfrei"
    case nutFree = "# nutfree"
    case lowCarb = "# lowcarb"
}

enum RecipeRoute {
    case brownies
    case tiramisu
    case chanaMasala
    case defaultRecipe
    case bananenbrot
    case RecipeDetailHost
    case mediterraneReispfanne
} //alte/optionale Navigation, für von Bookmark zu Rezepten

struct RecipeDetailHost: View { //zeigt Rezept
    @Binding var recipe: Recipe //live mit den echten Daten verbunden

    var body: some View {
        Text(recipe.title) //zeigt nur Titel
    }
}

struct HomeView: View { //komplette Startseite
    
    @State private var searchText = "" //Speichert den Text aus der Suchleiste., Oberfläche aktualisiert sich automatisch, wenn sich ein State ändert
    @State private var selectedCategory: Category = .alle//beim Start alle Rezepte angezeigt, Speichert, welche Kategorie ausgewählt ist.
    @State private var activeFilters: Set<FilterType> = [] //Speichert aktive Hashtags., anfangs keine Hashtags aktiv
    @FocusState private var searchFieldIsFocused: Bool//Variable zum öffnen der Tastatur
    
    
    @StateObject private var store = RecipeStore(recipes: [ //erstellt Rezept-Liste einmalig
        Recipe(
            title: "Twisted Potatoes",
            imageName: "Twisted Potatoe",
            category: .herzhaft,
            filters: [.glutenFree, .nutFree],
            isFavorite: false,
        ),
        Recipe(
            title: "Mediterrane Reispfanne",
            imageName: "Mediterrane Reispfanne",
            category: .unter_zwanzig, filters: [.glutenFree, .nutFree],
            isFavorite: true,
        ),
        Recipe(title: "Soychicken mit Couscous",
               imageName: "Soychicken Couscous",
               category: .herzhaft,
               filters: [.highProtein],
               isFavorite: false,
              ),
        Recipe(title: "Gemüsegratin mit Zucchini",
               imageName: "Gemüsegratin mit Zucchini",
               category: .herzhaft,
               filters: [.glutenFree, .nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Bananenbrot",
               imageName: "Bananenbrot",
               category: .suess,
               filters: [.nutFree, .glutenFree],
               isFavorite: false,
              ),
        Recipe(title: "Chocolate Chip Cookies",
               imageName: "Chocolate Chip Cookies",
               category: .suess,
               filters: [.nutFree],
               isFavorite: false,
               //route: .defaultRecipe
              ),
        Recipe(title: "Süßkartoffel-Brownies",
               imageName: "Süßkartoffel Brownies",
               category: .suess,
               filters: [.glutenFree, .lowCarb],
               isFavorite: true,
              ),
        Recipe(title: "Zimtschnecken",
               imageName: "Zimtschnecken",
               category: .suess,
               filters: [.nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Gemüse-Lasagne",
               imageName: "Gemüse-Lasagne",
               category: .herzhaft,
               filters: [.glutenFree, .nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Quiche Lorraine",
               imageName: "Quiche_Lorraine",
               category: .herzhaft,
               filters: [.highProtein],
               isFavorite: false,
              ),
        Recipe(title: "Chana Masala",
               imageName: "Chana_Masala",
               category: .herzhaft,
               filters: [.glutenFree, .nutFree, .highProtein],
               isFavorite: false,
              ),
        Recipe(title: "Tiramisu",
               imageName: "Tiramisu",
               category: .suess,
               filters: [.nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Zitronen-Blaubeer-Torte",
               imageName: "Zitronen-Blaubeer-Torte",
               category: .suess,
               filters: [.nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Kimchi-Pancakes mit Gochujang-Dip",
               imageName: "Kimchi-Pancakes",
               category: .unter_zwanzig,
               filters: [.nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Spaghetti Aglio e Olio",
               imageName: "Spaghetti",
               category: .unter_zwanzig,
               filters: [.nutFree],
               isFavorite: false,
              ),
        Recipe(title: "Miso-Ramen-Suppe",
               imageName: "Miso-Ramen-Suppe",
               category: .unter_zwanzig,
               filters: [.nutFree, .highProtein],
               isFavorite: false,
              ),
        Recipe(title: "Tex-Mex-Salat",
               imageName: "Tex-Mex-Salat",
               category: .unter_zwanzig,
               filters: [.nutFree, .highProtein, .glutenFree],
               isFavorite: false,
              ),
        Recipe(title: "Pasta mit Pistazienpesto & Pilzen", imageName: "Pistazienpesto",
               category: .unter_zwanzig,
               filters: [],
               isFavorite: false,
        )
        ])
    
    
    
    
    
    
    
    
    var filteredRecipes: [Recipe] { //nur Rezepte, die zur Kategorie, zum Hashtag und deren Titel passt, werden angezeigt
        store.recipes.filter { recipe in
            
            // 1. Kategorie (nur filtern, wenn NICHT "Alle")
            if selectedCategory != .alle { //nur filtern wenn nicht „Alle“
                guard recipe.category == selectedCategory else { return false } //falsche Kategorie → raus
            }
            
            // 2. Hashtag-Filter
            if !activeFilters.isEmpty { //nur wenn Filter aktiv
                guard activeFilters.isSubset(of: recipe.filters) else {
                    return false //Rezept muss alle Filter enthalten
                }
            }
            
            // 3. Textsuche
            if !searchText.isEmpty && !searchText.contains("#") { //nur normale Suche (kein Hashtag)
                return recipe.title
                    .lowercased()
                    .contains(searchText.lowercased()) //prüft ob Text im Titel vorkommt
            }
            
            return true
        }
    }
    
    
    
    
    var body: some View {
        NavigationStack { //Navigation System
            ZStack(alignment: .bottom) { //fixiert BottomBar am unteren Rand
                Color(red: 247/255, green: 253/255, blue: 252/255)
                    .ignoresSafeArea() //Hintergrundfarbe
                
                VStack(spacing: 20) {
                    
                    // MARK: - Suchleiste + Menü
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search", text: $searchText) //Eingabefeld
                                .focused($searchFieldIsFocused)//selbst entscheiden durch antippen, wann die Suchleiste aktiv ist
                                .onChange(of: searchText) { //reagiert bei Eingabe
                                    if !searchText.contains("#") {
                                        activeFilters.removeAll() //löscht Filter wenn normale Suche
                                    }
                                }
                            
                            
                            
                            Image(systemName: "mic.fill")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        
                        
                        NavigationLink(destination: EinstellungenView()) { //öffnet Einstellungen
                            VStack {
                                Image(systemName: "line.3.horizontal")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(Color(red: 82/255, green: 199/255, blue: 185/255))

                            }
                        }
                        .padding(8)
                        .contentShape(Rectangle())
                        
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Hashtag Filter
                    
                    if searchText.contains("#") { //zeigt Filter nur bei # Suche
                        VStack(spacing: 12) {
                            ForEach(FilterType.allCases) { filter in //alle Filter anzeigen
                                Button {
                                    if activeFilters.contains(filter) {
                                        activeFilters.remove(filter)
                                    } else {
                                        activeFilters.insert(filter)
                                    } //Filter aktivieren
                                    
                                    // Aktive Hashtags im Suchfeld anzeigen
                                    searchText = activeFilters
                                        .map { $0.rawValue }
                                        .sorted()
                                        .joined(separator: " ")
                                    
                                } label: {
                                    HStack {
                                        Text(filter.rawValue)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        if activeFilters.contains(filter) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .padding()
                                    .background(
                                        activeFilters.contains(filter)
                                        ? Color(red: 160/255, green: 220/255, blue: 215/255)
                                        : Color(red: 200/255, green: 240/255, blue: 235/255)
                                    )
                                    .cornerRadius(25)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    
                    // MARK: - Kategorien
                    HStack(spacing: 12) {
                        ForEach(Category.allCases, id: \.self) { category in //alle Kategorien
                            Button {  //Kategorie-Buttons optische Eigenschaften
                                selectedCategory = category //klick = neue Kategorie
                            } label: {
                                Text(category.rawValue)//rawValue gibt String an zu der Kategorie (zeigt also Herzhaft etc. auf den Buttons
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedCategory == category ? .white : .black)//if-else-Struktur
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(
                                                selectedCategory == category
                                                ? Color(red: 80/255, green: 196/255, blue: 182/255)
                                                : Color.white
                                            )
                                        
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(
                                                        selectedCategory == category
                                                        ? Color.clear
                                                        : Color.gray.opacity(0.35),
                                                        lineWidth: 1.5
                                                    )
                                            )
                                        
                                    )
                                
                                    .cornerRadius(25)
                                    .offset(y: selectedCategory == category ? -2 : 0)
                                
                            } //So gibt es Buttons mit den Kategorien die man auswählen kann.
                            
                        }
                    }
                    
                    
                    // MARK: - Überschrift
                    Text("Diese veganen Rezepte könnten Dir gefallen:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    
                    
                    // MARK: - Rezept Grid
                    
                    ScrollView {
                        if filteredRecipes.isEmpty {
                            Text("0 Ergebnisse zu „\(searchText)“")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            LazyVGrid(columns: [ //Rezepte in 2 Spalten angezeigt, da 2*GridItem
                                GridItem(.flexible()),
                                GridItem(.flexible()) //2 Spalten Layout
                                               ], spacing: 16) {
                                                   
                                                   ForEach(filteredRecipes) { recipe in //zeigt gefilterte Rezepte
                                                       if let recipeBinding = store.binding(for: recipe.id) {

                                                           NavigationLink {
                                                               RecipeDetailWrapper(recipe: recipeBinding) {
                                                                   RecipeDestination(recipe: recipeBinding)
                                                               }
                                                           } label: {
                                                               RecipeCard(recipe: recipeBinding)
                                                           } //öffnet Detailseite
                                                           .buttonStyle(.plain)
                                                       }
                                                   }                                               }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                
                
                    
                ZStack(alignment: .bottom) {
                    BottomBarView()
                    NavigationLink {
                        MakeItVeganView2()
                            .navigationBarBackButtonHidden(true)
                            .toolbar(.hidden, for: .navigationBar)
                    } label: {
                        TranslationCenterButton()
                    }
                    .buttonStyle(.plain)
                    
                }

            }
        }
        
    }
    
    struct FavoriteButton: View {
        @Binding var isSet: Bool
        var body: some View {
            Button {
                isSet.toggle()
            } label: {
                Image(systemName: isSet ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(red: 82/255, green: 199/255, blue: 185/255))
                    .padding(12)
                    .background(Color(red: 247/255,    green: 253/255,  blue: 252/255))
                    .clipShape(Circle())
                    .contentShape(Circle())
            }
        }
    }
    
    struct RecipeCard: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                
                ZStack(alignment: .topTrailing) {
                    Image(recipe.imageName) //Bild anzeigen
                        .resizable()
                        .scaledToFill()
                        .frame(height: 140)
                        .clipped()
                        .cornerRadius(15)
                    
                    FavoriteButton(isSet: $recipe.isFavorite) //Bookmark Button
                        .padding(10)
                }
                
                Text(recipe.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .frame(height: 40, alignment: .top)//alle Rezeptelemente auf gleichen Höhe
            }
        }
    }
    
    struct RecipeDetailHost: View {
        @Binding var recipe: Recipe

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .clipped()
                        .cornerRadius(16)
                    Text(recipe.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    // Placeholder for future detail content
                    Text("Weitere Details zum Rezept …")
                        .foregroundStyle(.secondary)
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .navigationTitle(recipe.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(red: 247/255, green: 253/255, blue: 252/255).ignoresSafeArea())
        }
    }
    
    struct RecipeDetailWrapper<Content: View>: View { //versteckt Navigation Bar
        //zeigt Content
        @Binding var recipe: Recipe
        @ViewBuilder var content: () -> Content

        var body: some View {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .navigationBarBackButtonHidden(true)
                .toolbar(.hidden, for: .navigationBar)
                .background(Color(red: 247/255, green: 253/255, blue: 252/255).ignoresSafeArea())
        }
    }
    

    
     
}
    
    
#Preview {
    HomeView()
}
    

