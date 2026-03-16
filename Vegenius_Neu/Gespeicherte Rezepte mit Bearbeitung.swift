//
//  Gespeicherte Rezepte mit Bearbeitung.swift
//  Vegenius_Neu
//
//  Created by TA617 on 11.03.26.
//

import SwiftUI
import PhotosUI

struct Recipe: Identifiable {
    let id = UUID()
    var title: String
    var image: UIImage?
    var note: String = ""
}

struct MyRecipesView: View {

    @State private var recipes: [Recipe] = [
        Recipe(title: "Vegane Brownies - saftig und einfach"),
        Recipe(title: "Saftiger Schoko-Bananen-Kuchen"),
        Recipe(title: "Veganisierte Lasagne mit Hack-Alternative"),
        Recipe(title: "Veganisierte Spaghetti Carbonara")
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                LazyVGrid(columns: columns, spacing: 20) {

                    ForEach($recipes) { $recipe in
                        RecipeCard(recipe: $recipe)
                    }

                }
                .padding()
            }

            .navigationTitle("Meine Rezepte")
            
            
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct RecipeCard: View {

    @Binding var recipe: Recipe

    @State private var selectedItem: PhotosPickerItem?

    var body: some View {

        VStack(spacing: 12) {

            Text(recipe.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            

            // Bild
            if let image = recipe.image {

                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 90)
                    .clipped()
                    .cornerRadius(10)

            } else {

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 90)
                    .overlay(
                        Image(systemName: "camera")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
            }

            // Foto Button
            PhotosPicker(selection: $selectedItem, matching: .images) {

                Label("Foto hinzufügen", systemImage: "camera")
                    .font(.caption)
                    .padding(6)
                    .background(Color.teal.opacity(0.6))
                    .cornerRadius(8)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        recipe.image = UIImage(data: data)
                    }
                }
            }

            // Notizfeld
            TextField("Notiz hinzufügen", text: $recipe.note)
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

        }
        .padding()
        .background(Color.teal.opacity(0.35))
        .cornerRadius(20)
    }
}

#Preview {
    MyRecipesView()
}
