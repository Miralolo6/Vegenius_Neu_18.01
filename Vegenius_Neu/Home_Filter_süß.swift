//
//  Home_Filter_süß.swift
//  Vegenius_Neu
//
//  Created by ta633 on 18.01.26.
//

//Hallo

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let category: Category
    let filters: Set<FilterType> //für Hashtags nur mit Werten von FilterType (von Hashtag)
    var isFavorite: Bool
}

enum Category: String, CaseIterable { //Variable kann nur ein Element aus dieser Aufzählung haben
    case alle = "Alle"
    case herzhaft = "Herzhaft"
    case suess = "Süß"
    case unter_zwanzig = "<20 min"
}

enum FilterType: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case highProtein = "# highprotein"
    case glutenFree = "# glutenfrei"
    case nutFree = "# nutfree"
    case lowCarb = "# lowcarb"
}


import SwiftUI

struct HalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false
        )
        return path
    }
}


struct CurvedBottomBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let curveHeight: CGFloat = 35
        let curveWidth: CGFloat = 90
        let centerX = rect.midX

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerX - curveWidth, y: 0))

        path.addQuadCurve(
            to: CGPoint(x: centerX, y: -curveHeight),
            control: CGPoint(x: centerX - curveWidth / 2, y: 0)
        )

        path.addQuadCurve(
            to: CGPoint(x: centerX + curveWidth, y: 0),
            control: CGPoint(x: centerX + curveWidth / 2, y: 0)
        )

        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}//kurvige Bottom Bar

struct HalfEllipse: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addEllipse(
            in: CGRect(
                x: 0,
                y: rect.height / 2,
                width: rect.width,
                height: rect.height
            )
        )

        return path
    }
}


struct HomeView: View {
    
    @State private var searchText = ""
    //@State private var selectedCategory: Category = .herzhaft
    @State private var selectedCategory: Category = .alle//beim Start alle Rezepte angezeigt
    //@State private var activeFilter: FilterType? = nil
    @State private var activeFilters: Set<FilterType> = []
    @FocusState private var searchFieldIsFocused: Bool//Variable zum öffnen der Tastatur
    
    
    @State private var recipes: [Recipe] = [
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
    
    //var filteredRecipes: [Recipe] {//Suchfunktion
    
    //  recipes.filter { recipe in
    // Prüfen, ob Rezept zur gewählten Kategorie passt
    //let matchesCategory = recipe.category == selectedCategory
    //    guard recipe.category == selectedCategory else { return false }
    
    //if let filter = activeFilter {
    //return recipe.filters.contains(filter)
    //}
    //  if searchText.contains("#") {
    // Hashtag-Suche: Filter prüfen
    //    return FilterType.allCases.first { $0.rawValue == searchText }
    //      .map { recipe.filters.contains($0) } ?? false
    //} else if !searchText.isEmpty {
    // Normale Textsuche
    //  return recipe.title.lowercased().contains(searchText.lowercased())
    //}
    
    // Keine Suche → alles zeigen
    // return true
    //}
    //}
    
    // Prüfen, ob Rezept zum Suchtext passt
    //let matchesSearch: Bool
    //if searchText.isEmpty {
    //matchesSearch = true
    //} else if searchText.contains("#") {
    // Wenn Hashtag, prüfen ob Filter aktiv ist
    //matchesSearch = activeFilter?.rawValue == searchText
    //} else {
    // Normale Suche nach Rezepttitel (case-insensitive)
    //matchesSearch = recipe.title.lowercased().contains(searchText.lowercased())
    //}
    
    //return recipe.title.lowercased().contains(searchText.lowercased())        }
    //}
    //var filteredRecipes: [Recipe] {
    //recipes.filter { recipe in
        
        // 1. Kategorie muss passen
        //      guard recipe.category == selectedCategory else { return false }
        
        // 2. Hashtag-Filter aktiv?
        //    if let filter = activeFilter {
        //      return recipe.filters.contains(filter)
        //}
        
        // 3. Normale Textsuche
        //if !searchText.isEmpty {
        //  return recipe.title
        //    .lowercased()
        //  .contains(searchText.lowercased())
        //}
        
        // 4. Keine Suche → anzeigen
        //return true
        //}
        //}
        /*var filteredRecipes: [Recipe] {
            recipes.filter { recipe in
                
                // 1. Kategorie
                guard recipe.category == selectedCategory else { return false }
                
                // 2. Mehrere aktive Hashtags
                if !activeFilters.isEmpty {
                    // Rezept muss ALLE aktiven Filter enthalten
                    guard activeFilters.isSubset(of: recipe.filters) else {
                        return false
                    }
                }
                
                // 3. Normale Textsuche (ohne Hashtags)
                if !searchText.isEmpty && !searchText.contains("#") {
                    return recipe.title
                        .lowercased()
                        .contains(searchText.lowercased())
                }
                
                return true
            }
        }*/
        var filteredRecipes: [Recipe] {
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
                            //.onChange(of: searchText) { newValue in
                            //  if !newValue.contains("#") {
                            //    activeFilter = nil
                            //}
                            //}
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
                    /* if searchText.contains("#") {
                     VStack(spacing: 12) {
                     ForEach(FilterType.allCases) { filter in
                     Button {
                     activeFilter = filter
                     searchText = filter.rawValue
                     } label: {
                     HStack {
                     Text(filter.rawValue)
                     .font(.headline)
                     .foregroundColor(.black)
                     Spacer()
                     }
                     .padding()
                     .background(
                     Color(red: 200/255, green: 240/255, blue: 235/255)
                     )
                     .cornerRadius(25)
                     }
                     }
                     }
                     .padding(.horizontal)
                     } */
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
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category.rawValue)//rawValue gibt String an zu der Kategorie (zeigt also Herzhaft etc. auf den Buttons
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedCategory == category ? .white : .black)//if-else-Struktur
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    /*.background(
                                        selectedCategory == category
                                        ? Color(red: 80/255, green: 196/255, blue: 182/255)
                                        : Color.white
                                    )*/
                                    /*.background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(
                                                selectedCategory == category
                                                ? Color(red: 80/255, green: 196/255, blue: 182/255)
                                                : Color.white
                                            )
                                            .shadow(
                                                color: selectedCategory == category
                                                    ? .black.opacity(0.2)
                                                    : .black.opacity(0.05),
                                                radius: selectedCategory == category ? 8 : 3,
                                                y: selectedCategory == category ? 4 : 2
                                            )
                                    )*/
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(
                                                selectedCategory == category
                                                ? Color(red: 80/255, green: 196/255, blue: 182/255)
                                                : Color.white
                                            )
                                            /*.shadow(
                                                color: selectedCategory == category
                                                    ? Color.black.opacity(0.25)
                                                    : Color.black.opacity(0.1),
                                                radius: selectedCategory == category ? 10 : 5,
                                                x: 0,
                                                y: selectedCategory == category ? 6 : 3
                                            )*/
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(
                                                        selectedCategory == category
                                                        ? Color.clear
                                                        : Color.gray.opacity(0.35),
                                                                lineWidth: 1.5
                                                    )
                                            )
                                                    
                                                    /*.shadow(
                                                        color: selectedCategory == category
                                                            ? Color.black.opacity(0.25)
                                                            : Color.black.opacity(0.1),
                                                        radius: selectedCategory == category ? 10 : 5,
                                                        y: selectedCategory == category ? 6 : 3
                                                    )*/
                                            /*.shadow(
                                                        color: selectedCategory == category
                                                            ? Color.black.opacity(0.25)
                                                            : Color.black.opacity(0.1),
                                                        radius: selectedCategory == category ? 10 : 5,
                                                        x: 0,
                                                        y: selectedCategory == category ? 6 : 3
                                            )*/
                                    )

                                    .cornerRadius(25)
                                    .offset(y: selectedCategory == category ? -2 : 0)
                                    //.shadow(color: .black.opacity(0.15), radius: 2, y: 2)
                            } //So gibt es Buttons mit den Kategorien die man auswählen kann.
                            
                        }
                    }
                    
                    
                    // MARK: - Überschrift
                    Text("Diese Rezepte könnten Dir gefallen:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    
                    
                    // MARK: - Rezept Grid
                    //ScrollView {
                    //  if searchText.contains("#") {
                    // Hashtag-Suche → Filterliste wird oben schon angezeigt, also hier einfach nichts extra anzeigen
                    //EmptyView()
                    //} else if filteredRecipes.isEmpty {
                    // Normale Suche ohne Treffer
                    //  Text("0 Ergebnisse zu „\(searchText)“")
                    //    .font(.headline)
                    //  .foregroundColor(.gray)
                    //.padding()
                    //.frame(maxWidth: .infinity, alignment: .center)
                    //} else {
                    //  LazyVGrid(columns: [
                    //    GridItem(.flexible()),
                    //  GridItem(.flexible())
                    //], spacing: 16) {
                    
                    //  ForEach(filteredRecipes) { recipe in
                    //    if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
                    //      RecipeCard(recipe: $recipes[index])
                    //}
                    //}
                    //}
                    //}
                    ScrollView {
                        if filteredRecipes.isEmpty {
                            Text("0 Ergebnisse zu „\(searchText)“")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            LazyVGrid(columns: [
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
                    //.padding(.horizontal)
                    //}.padding(.horizontal)
                }
                /*.overlay(
                    BottomBarView(), alignment: .bottom
                )*/
                ZStack(alignment: .bottom) {

                    VStack {
                        // dein ganzer Inhalt (Search, Kategorien, Rezepte)
                    }

                    //BottomBarView()
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
                            recipe.isFavorite.toggle()
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
        
        /*struct BottomBarView: View {
            var body: some View {
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        //Image(systemName: "chef.hat")
                        Image(systemName: "bookmark.circle")
                            .font(.system(size: 30, weight: .semibold))
                            .imageScale(.large)
                            .foregroundColor(.white)
                        Text("Gespeichert")
                            .font(.system(size: 13, weight: .medium))
                    }
                    
                    .offset(y: 7)
                    .contentShape(Rectangle())
                    
                    
                    Spacer()
                    
                    /*ZStack {
                        Circle()
                        //.fill(Color(hex: "#3BA194"))
                        //.fill(Color.init(red: 59, green: 161, blue: 148))
                            .fill(Color(red: 59/255, green: 161/255, blue: 148/255))
                            .frame(width: 60, height: 60)
                        
                        //Image(systemName: "arrow.left.arrow.right")
                        //Image(systemName: "arrow.right.arrow.left")
                        Image("Übersetzung_Pfeile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        //.font(.bold)
                            .font(.system(size: 24, weight: .bold))
                    }*/
                    ZStack {
                        Circle()
                            .fill(Color(red: 59/255, green: 161/255, blue: 148/255))
                            .frame(width: 60, height: 60)
                            .shadow(color: .black.opacity(0.25), radius: 10, y: 6)

                        Image("Übersetzung_Pfeile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                    .offset(y: -20)

                    .offset(y: 7)
                    .contentShape(Circle())
                    .accessibilityLabel("Übersetzen")
                    
                    Spacer()
                    
                    VStack {
                        //Image(systemName: "checkmark.circle")
                        Image("Meine_Rezepte")
                            .resizable()
                            .scaledToFit()
                        //.frame(width: 24, height: 24)
                            .frame(width: 40, height: 40)
                        Text("Meine Rezepte")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .offset(y: 7)
                    .padding(.vertical, 2)
                    .contentShape(Rectangle())
                    
                    Spacer()
                }
                .padding(.vertical, 5)
                //.background(Color.init(red: 82, green: 199, blue: 185))
                //.background(Color(red: 126/255, green: 222/255, blue: 211/255))
                /*.background(
                    CurvedBottomBarShape()
                        .fill(Color(red: 126/255, green: 222/255, blue: 211/255))
                        .shadow(color: .black.opacity(0.15), radius: 10, y: -4)
                )*/
                .background(
                    CurvedBottomBarShape()
                        .fill(Color(red: 126/255, green: 222/255, blue: 211/255))
                        .shadow(color: .black.opacity(0.15), radius: 10, y: -4)
                )
                .ignoresSafeArea(edges: .bottom)
                .foregroundColor(.white)//Schriftfarbe von "Gespeichert" und Meine Rezepte mit Icon weiß
                .ignoresSafeArea(edges: .bottom) //Bottom Bar geht ganz nach unten
            }
        }*/
    struct BottomBarView: View {
        var body: some View {
            ZStack(alignment: .top) {

                //VOLLE Bottom Bar Fläche
                Color(red: 126/255, green: 222/255, blue: 211/255)
                    .ignoresSafeArea(edges: .bottom)

                //Inhalte
                HStack {
                    Spacer()

                    Button {
                           print("Gespeichert gedrückt")
                    } label: {
                        VStack {
                            Image("Gespeichert_Seite")
                                .resizable()
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .font(.system(size: 48, weight: .semibold))
                            Text("Gespeichert")
                                .font(.system(size: 16, weight: .medium))
                        }
                    }

                    Spacer()
                    Spacer() // Platz für Center Button
                    Spacer()

                    Button {
                           print("Meine_Rezepte gedrückt")
                    } label: {
                        VStack {
                            Image("Meine_Rezepte")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Text("Meine Rezepte")
                                .font(.system(size: 16, weight: .medium))
                        }
                    }

                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.top, 28)
            }
            .frame(height: 60)
        }
    }
    struct TranslationCenterButton: View {
        var body: some View {
            Button {
                print("Übersetzen Button gedrückt")
                // HIER kommt später Navigation oder Aktion rein
            } label: {
                ZStack {
                    // Halber Kreis HINTER dem Button
                    HalfCircle()
                        .fill(Color(red: 126/255, green: 222/255, blue: 211/255))
                        .frame(width: 120, height: 60)
                        .offset(y: -30)
                    
                    // Runder Button
                    Circle()
                        .fill(Color(red: 59/255, green: 161/255, blue: 148/255))
                        .frame(width: 90, height: 90)
                        .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                        .overlay(
                            Image("Übersetzung_Pfeile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        )
                }
            }
            .buttonStyle(.plain)
        }
    }
    }

    
    
#Preview {
    HomeView()
}
    
    

