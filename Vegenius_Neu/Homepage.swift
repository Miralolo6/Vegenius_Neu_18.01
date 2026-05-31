//
//  Home_Filter_süß.swift
//  Vegenius_Neu
//
//  Created by ta633 on 18.01.26.
//

//Hallo

import SwiftUI
import Combine

final class RecipeStore: ObservableObject {
    @Published var recipes: [Recipe]

    
        init() {
            self.recipes = [
                Recipe(title: "Twisted Potatoes", imageName: "Twisted Potatoe", category: .herzhaft,filters: [.glutenFree, .nutFree], isFavorite: false),
                Recipe(title: "Mediterrane Reispfanne", imageName: "Mediterrane Reispfanne", category: .unter_zwanzig, filters: [.glutenFree, .nutFree], isFavorite: false),
                Recipe(title: "Soychicken mit Couscous", imageName: "Soychicken Couscous", category: .herzhaft,  filters: [.highProtein], isFavorite: false),
                Recipe(title: "Gemüsegratin mit Zucchini", imageName: "Gemüsegratin mit Zucchini", category: .herzhaft, filters: [.glutenFree, .nutFree], isFavorite: false),
                Recipe(title: "Bananenbrot", imageName: "Bananenbrot", category: .suess, filters: [.nutFree, .glutenFree], isFavorite: false),
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
        }
    
    func addGeneratedRecipe(
        title: String,
        recipeText: String
    ) {

        let newRecipe = Recipe(
            title: title,
            imageName: "",
            generatedText: recipeText,
            category: .alle,
            filters: [],
            isFavorite: false,
            isGenerated: true,
            isSaved: true
        )

        recipes.append(newRecipe)
    }

    func binding(for recipeID: UUID) -> Binding<Recipe>? {
        guard let index = recipes.firstIndex(where: { $0.id == recipeID }) else { return nil }
        return Binding(
            get: { self.recipes[index] },
            set: { self.recipes[index] = $0 }
        )
    }
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
    @EnvironmentObject var store: RecipeStore
    
    @State private var searchText = "" //Speichert den Text aus der Suchleiste., Oberfläche aktualisiert sich automatisch, wenn sich ein State ändert
    @State private var selectedCategory: Category = .alle//beim Start alle Rezepte angezeigt, Speichert, welche Kategorie ausgewählt ist.
    @State private var activeFilters: Set<FilterType> = [] //Speichert aktive Hashtags., anfangs keine Hashtags aktiv
    @FocusState private var searchFieldIsFocused: Bool//Variable zum öffnen der Tastatur
    
    
        
    

    
    
    
    
    
    
    
    var filteredRecipes: [Recipe] { //nur Rezepte, die zur Kategorie, zum Hashtag und deren Titel passt, werden angezeigt
        store.recipes.filter { recipe in
            
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
        NavigationStack {
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
                                .onChange(of: searchText) {
                                    if !searchText.contains("#") {
                                        activeFilters.removeAll()
                                    }
                                }
                            
                            
                            
                            Image(systemName: "mic.fill")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        
                        
                        NavigationLink(destination: EinstellungenView()) {
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
                                                       if let recipeBinding = store.binding(for: recipe.id) {
                                                           if recipe.title == "Bananenbrot" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       BananenbrotView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Chana Masala" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       ChanaMasalaView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Chocolate Chip Cookies" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       ChocolateChipCookiesView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Gemüse-Lasagne" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       GemueseLasagneView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Gemüsegratin mit Zucchini" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       GemüsegratinMitZucchiniView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Kimchi-Pancakes mit Gochujang-Dip" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       KimchiPancakesView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Miso-Ramen-Suppe" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       MisoRamenSuppeView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Pasta mit Pistazienpesto & Pilzen" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       PistazienPestoView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Quiche Lorraine" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       QuicheLorraineView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Mediterrane Reispfanne" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       RezeptDetailView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Soychicken mit Couscous" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       SoychickenMitCouscousView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Spaghetti Aglio e Olio" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       SpaghettiView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Süßkartoffel-Brownies" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       SuesskartorffelBrowniesView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Tex-Mex-Salat" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       TexMexSalatView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Tiramisu" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       TiramisuView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Twisted Potatoes" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       TwistedPotatoesView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Zimtschnecken" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       ZimtschneckenView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else if recipe.title == "Zitronen-Blaubeer-Torte" {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       ZitronenBlaubeerTorteView(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           } else {
                                                               NavigationLink {
                                                                   RecipeDetailWrapper(recipe: recipeBinding) {
                                                                       RecipeDetailHost(recipe: recipeBinding)
                                                                   }
                                                               } label: {
                                                                   RecipeCard(recipe: recipeBinding)
                                                               }
                                                               .buttonStyle(.plain)
                                                           }
                                                       }
                                                       
                                                   }
                                               }
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
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 140)
                        .clipped()
                        .cornerRadius(15)
                    
                    FavoriteButton(isSet: $recipe.isFavorite)
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
    
    struct RecipeDetailWrapper<Content: View>: View {
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
        .environmentObject(RecipeStore())
}
    

