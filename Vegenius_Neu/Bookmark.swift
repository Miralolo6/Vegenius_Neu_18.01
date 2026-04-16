//
//  Bookmark.swift
//  Vegenius_Neu
//
//  Created by ta633 on 09.03.26.
//

//
//  Recipe.swift
//  Vegenius_Neu
//
//  Created by ta633 on 11.02.26.
//


import SwiftUI
//import Combine

struct Recipe2: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}

struct RezepteView: View {
    
    let startRecipes: [Recipe2] = [
        Recipe2(title: "Brownies",
               description: "Süßkartoffel Brownies, saftig und lecker.",
               imageName: "Brownies_Gespeicherte_Rezepte"),
        
        Recipe2(title: "Mediterrane Reispfanne",
               description: "Tomaten-Paprika-Basis.",
               imageName: "reis_gespeicherte_rezepte")
    ]
    
    @State private var recipes: [Recipe2] = []
    @State private var showDeleteAlert = false
    @State private var recipeToDelete: Recipe2?
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            
            // Überschrift zentriert
            Text("Meine Rezepte")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(red: 231/255, green: 161/255, blue: 176/255))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 12)
            
            // Reset Button zentriert
            Button("Gelöschte Rezepte wiederherstellen") {
                recipes = startRecipes
            }
            .font(.caption)
            .foregroundColor(Color(red: 35/255, green: 170/255, blue: 150/255))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 6)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(recipes) { recipe in
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            ZStack(alignment: .topTrailing) {
                                Image(recipe.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 120)
                                    .frame(maxWidth: .infinity)
                                    .clipped()
                                    .cornerRadius(12)
                                
                                Button {
                                    recipeToDelete = recipe
                                    showDeleteAlert = true
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
                                .lineLimit(2)
                            
                            Text(recipe.description)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(14)
                        .shadow(radius: 2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }//Ende of ScrollView
        }
        .background(Color(red: 245/255, green: 250/255, blue: 248/255))
        .onAppear {
            recipes = startRecipes
        }
        .alert("Willst du das Rezept aus deiner Sammlung entfernen?", isPresented: $showDeleteAlert) {
            Button("Nein", role: .cancel) { }
            Button("Ja", role: .destructive) {
                if let recipeToDelete {
                    recipes.removeAll { $0.id == recipeToDelete.id }
                }
            }
        }
    }
}

#Preview {
    RezepteView()
}
