//
//  Gespeicherte Rezepte mit Bearbeitung.swift
//  Vegenius_Neu
//
//  Created by TA617 on 11.03.26.
//

import SwiftUI
import PhotosUI

struct Recipe3: Identifiable {
    let id = UUID()
    var title: String
    var image: UIImage?
    var note: String = ""
}

struct MyRecipesView: View {

    @State private var recipes: [Recipe3] = [
        Recipe3(title: "Vegane Brownies - saftig und einfach"),
        Recipe3(title: "Saftiger Schoko-Bananen-Kuchen"),
        Recipe3(title: "Veganisierte Lasagne mit Hack-Alternative"),
        Recipe3(title: "Veganisierte Spaghetti Carbonara")
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                LazyVGrid(columns: columns, spacing: 20)
                {

                    ForEach($recipes) { $recipe in
                        RecipeCard(recipe: $recipe)
                    }

                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Meine Rezepte")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            Color(
                                red: 231/255,
                                green: 161/255,
                                blue: 176/255
                            )
                        )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RecipeCard: View {

    @Binding var recipe: Recipe3

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
                    .fill(
                        Color(
                            red: 246/255,
                            green: 242/255,
                            blue: 236/255
                        )
                    )
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
                    .font(.footnote)
                    .padding(6)
                    .background(
                        Color(
                            red: 126/255,
                            green: 222/255,
                            blue: 211/255
                        )
                    )
                    .foregroundColor(.black)
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
            HStack(spacing: 6) {
                Image(systemName: "pencil")
                    .foregroundColor(.gray)
                TextField("Notiz hinzufügen", text: $recipe.note)
            }
            .padding(8)
            .frame(minHeight: 44)
            .background(
                Color(
                    red: 246/255,
                    green: 242/255,
                    blue: 236/255
                )
            )
            .cornerRadius(8)

        }
        .padding()
        .background(
            Color(
                red: 190/255,
                green: 234/255,
                blue: 229/255
            )
        )
        .cornerRadius(20)
    }
}

#Preview {
    MyRecipesView()
}
