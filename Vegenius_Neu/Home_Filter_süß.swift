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
    var isFavorite: Bool
}

enum Category: String, CaseIterable {
    case kochen = "Kochen"
    case backen = "Backen"
    case suess = "Süß"
}

import SwiftUI

struct HomeView: View {
    
    @State private var searchText = ""
    @State private var selectedCategory: Category = .kochen
    
    @State private var recipes: [Recipe] = [
        Recipe(title: "Twisted Potatoe in Auflaufform", imageName: "recipe1", category: .kochen, isFavorite: false),
        Recipe(title: "Mediterrane Reispfanne", imageName: "recipe2", category: .kochen, isFavorite: true),
        Recipe(title: "Soychicken Couscous", imageName: "recipe3", category: .backen, isFavorite: false),
        Recipe(title: "Gemüsegratin mit Zucchini", imageName: "recipe4", category: .suess, isFavorite: false)
    ]
    
    var filteredRecipes: [Recipe] {
        recipes.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        ZStack {
            //Color(hex: "#F7FDFC")
            Color.init(red: 247, green: 253, blue: 252)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: - Suchleiste + Menü
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchText)
                        
                        Image(systemName: "mic.fill")
                            .foregroundColor(.pink)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    
                    Button {
                        print("Menü geöffnet")
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            //.foregroundColor(Color(hex: "#52C7B9"))
                            .foregroundColor(Color.init(red: 82, green: 199, blue: 185))
                    }
                }
                .padding(.horizontal)
                
                
                // MARK: - Kategorien
                HStack(spacing: 12) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button {
                            selectedCategory = category
                        } label: {
                            Text(category.rawValue)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    selectedCategory == category
                                    //? Color(hex: "#52C7B9")
                                    ? Color.init(red: 82, green: 199, blue: 185)
                                    : Color.white
                                )
                                .cornerRadius(25)
                        }
                    }
                }
                
                
                // MARK: - Überschrift
                Text("Diese Rezepte könnten Dir gefallen:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                
                // MARK: - Rezept Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        
                        ForEach(filteredRecipes.indices, id: \.self) { index in
                            RecipeCard(recipe: $recipes[index])
                            
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // MARK: - Bottom Bar
                BottomBarView()
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
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                        .padding(8)
                }
            }
            
            Text(recipe.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
        }
    }
}

struct BottomBarView: View {
    var body: some View {
        HStack {
            
            Spacer()
            
            VStack {
                Image(systemName: "chef.hat")
                Text("Favoriten")
                    .font(.caption)
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    //.fill(Color(hex: "#3BA194"))
                    .fill(Color.init(red: 59, green: 161, blue: 148))
                    .frame(width: 60, height: 60)
                
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundColor(.white)
                    .font(.title2)
            }
            
            Spacer()
            
            VStack {
                Image(systemName: "checkmark.circle")
                Text("Meine Rezepte")
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding(.vertical, 10)
        .background(Color.init(red: 82, green: 199, blue: 185))
    }
}




#Preview {
    HomeView()
}
