//
//  Bookmark_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 21.04.26.
//

import SwiftUI
//import Combine



struct RezepteView2: View {
    
    @Environment(\.dismiss) var dismiss
    
    
    
    
    @State private var recipes: [Recipe] = []
    @State private var showDeleteAlert = false
    @State private var recipeToDelete: Recipe?
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                
                // Mittig (unabhängig von Buttons)
                Text("Gespeichert")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 231/255, green: 161/255, blue: 176/255))
                
                // Leiste mit Buttons
                HStack {
                    Button {
                        dismiss()
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
            
            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(recipes) { recipe in
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            ZStack(alignment: .topTrailing) {
                                Image(recipe.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 140)
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
                .padding(.horizontal, 1)
                .padding(.vertical, 10)
            }//Ende of ScrollView
        }
        .padding(.horizontal)
        .background(
            Color(red: 247/255, green: 253/255, blue: 252/255)
                .ignoresSafeArea()
        )
        .onAppear {
            loadSavedRecipes()
        }
        .alert(
            "Willst du das Rezept aus deiner Sammlung entfernen?",
            isPresented: $showDeleteAlert
        ) {
            Button("Nein", role: .cancel) {
                recipeToDelete = nil
            }

            Button("Ja", role: .destructive) {
                if let recipeToDelete {
                    // Aus der Anzeige entfernen
                    recipes.removeAll {
                        $0.id == recipeToDelete.id
                    }

                    // Dauerhaft aus dem Speicher entfernen
                    RecipeStorage.removeRecipe(recipeToDelete)

                    self.recipeToDelete = nil
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func loadSavedRecipes() {
        recipes = RecipeStorage.loadRecipes()
    }
    
}

#Preview {
    RezepteView2()
}
