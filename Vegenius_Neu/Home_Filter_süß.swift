//
//  Home_Filter_süß.swift
//  Vegenius_Neu
//
//  Created by ta633 on 18.01.26.
//

//Hallo

import SwiftUI

struct Recipe: Identifiable { //definiert wie Rezept aufgebaut
    let id = UUID() //edes Rezept eine eindeutige Kennung, damit SwiftUI jedes Element in der Liste sicher erkennen und verwalten kann
    let title: String
    let imageName: String
    let category: Category
    let filters: Set<FilterType> //für Hashtags nur mit Werten von FilterType (von Hashtag)
    var isFavorite: Bool //gespeichert oder nicht
}

enum Category: String, CaseIterable { //Variable kann nur ein Element aus dieser Aufzählung haben; CaseIterable --> Programm alle Werte eines Enums durchgehen
    case alle = "Alle"
    case herzhaft = "Herzhaft"
    case suess = "Süß"
    case unter_zwanzig = "<20 min"
}

enum FilterType: String, CaseIterable, Identifiable { //enum = Liste mit vorgegebenen Werten
    var id: String { rawValue } //SwiftUI braucht für Listen (ForEach) eine eindeutige ID pro Element

    case highProtein = "# highprotein" //Diese Auswahlmöglichkeiten sind fest
    case glutenFree = "# glutenfrei"
    case nutFree = "# nutfree"
    case lowCarb = "# lowcarb"
}





struct HomeView: View {
    
    @State private var searchText = "" //Speichert den Text aus der Suchleiste., Oberfläche aktualisiert sich automatisch, wenn sich ein State ändert
    @State private var selectedCategory: Category = .alle//beim Start alle Rezepte angezeigt, Speichert, welche Kategorie ausgewählt ist.
    @State private var activeFilters: Set<FilterType> = [] //Speichert aktive Hashtags., anfangs keine Hashtags aktiv
    @FocusState private var searchFieldIsFocused: Bool//Variable zum öffnen der Tastatur
    
    
    @State private var recipes: [Recipe] = [ //Liste von Rezepten
        Recipe(title: "Twisted Potatoes", imageName: "Twisted Potatoe", category: .herzhaft,filters: [.glutenFree, .nutFree], isFavorite: false),
        Recipe(title: "Mediterrane Reispfanne", imageName: "Mediterrane Reispfanne", category: .unter_zwanzig, filters: [.glutenFree, .nutFree], isFavorite: false),
        Recipe(title: "Soychicken mit Couscous", imageName: "Soychicken Couscous", category: .herzhaft,  filters: [.highProtein], isFavorite: false),
        Recipe(title: "Gemüsegratin mit Zucchini", imageName: "Gemüsegratin mit Zucchini", category: .herzhaft, filters: [.glutenFree, .nutFree], isFavorite: false),
        Recipe(title: "Bananenbrot", imageName: "Bananenbrot", category: .suess, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Chocolate Chip Cookies", imageName: "Chocolate Chip Cookies", category: .suess, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Süßkartoffel-Brownies", imageName: "Süßkartoffel Brownies", category: .suess, filters: [.glutenFree, .lowCarb], isFavorite: false),
        Recipe(title: "Zimtschnecken", imageName: "Zimtschnecken", category: .suess, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Gemüse-Lasagne", imageName: "Gemüse-Lasagne", category: .herzhaft, filters: [.glutenFree, .nutFree], isFavorite: false),
        Recipe(title: "Quiche Lorraine", imageName: "Quiche_Lorraine", category: .herzhaft, filters: [.highProtein], isFavorite: false),
        Recipe(title: "Chana Masala", imageName: "Chana_Masala", category: .herzhaft, filters: [.glutenFree, .nutFree, .highProtein], isFavorite: false),
        Recipe(title: "Tiramisu", imageName: "Tiramisu", category: .suess, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Zitronen-Blaubeer-Torte", imageName: "Zitronen-Blaubeer-Torte", category: .suess, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Kimchi-Pancakes mit Gochujang-Dip", imageName: "Kimchi-Pancakes", category: .unter_zwanzig, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Spaghetti Aglio e Olio", imageName: "Spaghetti", category: .unter_zwanzig, filters: [.nutFree], isFavorite: false),
        Recipe(title: "Miso-Ramen-Suppe", imageName: "Miso-Ramen-Suppe", category: .unter_zwanzig, filters: [.nutFree, .highProtein], isFavorite: false),
        Recipe(title: "Tex-Mex-Salat", imageName: "Tex-Mex-Salat", category: .unter_zwanzig, filters: [.nutFree, .highProtein, .glutenFree], isFavorite: false),
        Recipe(title: "Pasta mit Pistazienpesto & Pilzen", imageName: "Pistazienpesto", category: .unter_zwanzig, filters: [], isFavorite: false)
    ]
    
    
    
    
    
    
    
    var filteredRecipes: [Recipe] { //nur Rezepte, die zur Kategorie, zum Hashtag und deren Titel passt, werden angezeigt
        recipes.filter { recipe in
            
            // 1. Kategorie (nur filtern, wenn NICHT "Alle")
            if selectedCategory != .alle {
                guard recipe.category == selectedCategory else { return false }
            }
            
            // 2. Hashtag-Filter
            if !activeFilters.isEmpty {
                guard activeFilters.isSubset(of: recipe.filters) else {
                    return false
                }
            }
            
            // 3. Textsuche
            if !searchText.isEmpty && !searchText.contains("#") {
                return recipe.title
                    .lowercased()
                    .contains(searchText.lowercased())
            }
            
            return true
        }
    }
    
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) { //fixiert BottomBar am unteren Rand
            //Color(hex: "#F7FDFC")
            //Color.init(red: 247, green: 253, blue: 252)
            Color(red: 247/255, green: 253/255, blue: 252/255)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: - Suchleiste + Menü
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchText)
                            .focused($searchFieldIsFocused)//selbst entscheiden durch antippen, wann die Suchleiste aktiv ist
                        
                            .onChange(of: searchText) { newValue in
                                if !newValue.contains("#") {
                                    activeFilters.removeAll()
                                }
                            }
                        
                        
                        
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    
                    
                    
                    Button {
                        print("Menü geöffnet")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color(red: 82/255, green: 199/255, blue: 185/255))
                    }
                    .padding(8)
                    .contentShape(Rectangle())
                }
                .padding(.horizontal)
                
                // MARK: - Hashtag Filter
                
                if searchText.contains("#") {
                    VStack(spacing: 12) {
                        ForEach(FilterType.allCases) { filter in
                            Button {
                                if activeFilters.contains(filter) {
                                    activeFilters.remove(filter)
                                } else {
                                    activeFilters.insert(filter)
                                }
                                
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
                    ForEach(Category.allCases, id: \.self) { category in
                        Button {  //Kategorie-Buttons optische Eigenschaften
                            selectedCategory = category
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
                            GridItem(.flexible())
                                           ], spacing: 16) {
                                               
                                               ForEach(filteredRecipes) { recipe in
                                                   if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
                                                       RecipeCard(recipe: $recipes[index])
                                                   }
                                               }
                                           }
                    }
                }
                .padding(.horizontal)
                
            }
            
            ZStack(alignment: .bottom) {
                
                VStack {
                    // dein ganzer Inhalt (Search, Kategorien, Rezepte)
                }
                
                ZStack(alignment: .bottom) {
                    BottomBarView()
                    TranslationCenterButton()
                    
                }
                
                
                
            }
            
        }
        
    }
    
    struct RecipeCard: View {
        @Binding var recipe: Recipe
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                
                ZStack(alignment: .topTrailing) {
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 140)
                        .clipped()
                        .cornerRadius(15)
                    
                    Button {
                        recipe.isFavorite.toggle() //man kann zwischen gefülltem und leerem Lesezeichen wechseln als Speicherung
                    } label: {
                        Image(systemName: recipe.isFavorite ? "bookmark.fill" : "bookmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(red: 82/255, green: 199/255, blue: 185/255))
                            .padding(12)
                            .background(Color(red: 247/255,    green: 253/255,  blue: 252/255))//)(0.45))
                            .clipShape(Circle())
                            .contentShape(Circle())
                    }
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
    

    
     
}
    
    
#Preview {
    HomeView()
}
    
    
    
    

