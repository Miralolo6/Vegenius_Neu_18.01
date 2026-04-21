//
//  Bookmark_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 21.04.26.
//

import SwiftUI
//import Combine

struct Recipe5: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
}

struct RezepteView2: View {
    
    @Environment(\.dismiss) var dismiss
    
    let startRecipes: [Recipe5] = [
        Recipe5(title: "Brownies",
                description: "Süßkartoffel Brownies, saftig und lecker",
                imageName: "Süßkartoffel Brownies"),
        
        Recipe5(title: "Mediterrane Reispfanne",
                description: "Tomaten-Paprika-Basis",
                imageName: "Mediterrane Reispfanne")
    ]
    
    @State private var recipes: [Recipe5] = []
    @State private var showDeleteAlert = false
    @State private var recipeToDelete: Recipe5?
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Gespeichert")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 231/255, green: 161/255, blue: 176/255))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 12)
                
                Spacer()
                
                Button {
                    print("gespeichert_ohne_Bearbeitung")
                } label: {
                    VStack {
                        Image("Gespeichert_Seite")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .font(.system(size: 48, weight: .semibold))
                        
                    }
                }
                .padding(.top, 8)
            }
            
            Button("Gelöschte Rezepte wiederherstellen") {
                recipes = startRecipes
            }
            .font(.caption)
            .foregroundColor(Color(red: 35/255, green: 170/255, blue: 150/255))
            
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RezepteView2()
}
