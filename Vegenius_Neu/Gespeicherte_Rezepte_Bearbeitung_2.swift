//
//  Gespeicherte_Rezepte_Bearbeitung_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 21.04.26.
//

import SwiftUI
import PhotosUI

struct Recipe4: Identifiable {
    let id = UUID()
    var title: String
    var image: UIImage?
    var note: String = ""
}

struct MyRecipesView2: View {
    
    @Environment(\.dismiss) var dismiss

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
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Meine Rezepte")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(red: 231/255, green: 161/255, blue: 176/255))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 12)
                    
                    Spacer()
                    
                    Button {
                        print("gespeichert")
                    } label: {
                        VStack {
                            Image( "gH")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(height: 44)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach($recipes) { $recipe in
                            RecipeCard(recipe: $recipe)
                        }
                    }
                    .padding()
                    
                }
            }.background(Color(red: 247/255, green: 253/255, blue: 252/255))


            
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct RecipeCard2: View {

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
    MyRecipesView2()
}
