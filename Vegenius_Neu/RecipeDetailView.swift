//
//  RecipeDetailView.swift
//  Vegenius_Neu
//
//  Created by Miriam Nguyen on 17.10.26.
//


import SwiftUI
import UIKit

// MARK: - Einheitliche Rezeptdaten

struct RecipeContent {
    let ingredients: [String]
    let steps: [String]
    let servingSize: String
    var tip: String? = nil

    var shareText: String {
        """
        \(titleForSharing)

        Zutaten (\(servingSize)):
        \(ingredients.map { "• \($0)" }.joined(separator: "\n"))

        Zubereitung:
        \(steps.enumerated().map {
            "\($0.offset + 1). \($0.element)"
        }.joined(separator: "\n\n"))

        \(tip.map { "\nTipp: \($0)" } ?? "")

        Rezept aus meiner App 🙂
        """
    }

    // Wird von der Rezeptansicht gesetzt.
    var titleForSharing: String = ""
}

// MARK: - Wiederverwendbare Rezeptansicht

struct RecipeDetailView: View {
    @Binding var recipe: Recipe

    let content: RecipeContent

    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    @State private var isFavorite = false

    private let backgroundColor = Color(
        red: 247.0 / 255.0,
        green: 253.0 / 255.0,
        blue: 252.0 / 255.0
    )

    private let accentColor = Color(
        red: 82.0 / 255.0,
        green: 199.0 / 255.0,
        blue: 185.0 / 255.0
    )

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                backgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 22) {
                        header
                        recipeImage
                        recipeInformation
                        ingredientsSection
                        preparationSection
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 125)
                }
                .scrollIndicators(.hidden)

                bottomBar
            }
            
            .onAppear {
                isFavorite = RecipeStorage.isSaved(recipe)
                recipe.isFavorite = isFavorite
            }
            .toolbar(.hidden, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showShareSheet) {
                RecipeShareSheet(
                    activityItems: [makeShareText()]
                )
            }
        }
    }
    
    

    // MARK: - Kopfzeile

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(accentColor)
                    .frame(width: 44, height: 44)
                    .background(.white, in: Circle())
                    .overlay {
                        Circle()
                            .stroke(Color.black.opacity(0.04), lineWidth: 1)
                    }
                    .shadow(
                        color: Color.black.opacity(0.10),
                        radius: 5,
                        x: 0,
                        y: 3
                    )
            }
            .accessibilityLabel("Zurück")

            Spacer()

            Text(recipe.title)
                .font(.title3.weight(.semibold))
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Spacer()

            Color.clear
                .frame(width: 44, height: 44)
        }
        .padding(.top, 8)
    }

    // MARK: - Einheitliches quadratisches Bild

    private var recipeImage: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                Group {
                    if let image = recipe.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(recipe.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.width
                )
                .clipped()

                
                 
                Button {
                    toggleFavorite()
                } label: {
                    Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(accentColor)
                        .frame(width: 44, height: 44)
                        .background(.white.opacity(0.96), in: Circle())
                        .contentTransition(.symbolEffect(.replace))
                }
                .padding(12)
                .accessibilityLabel(
                    isFavorite
                        ? "Aus Favoriten entfernen"
                        : "Zu Favoriten hinzufügen"
                )

            }
            .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .aspectRatio(1, contentMode: .fit)
    }

    // MARK: - Rezeptinformationen

    private var recipeInformation: some View {
        HStack(spacing: 12) {
            Label(content.servingSize, systemImage: "fork.knife")
                .lineLimit(2)

            Spacer(minLength: 4)

            Button {
                showShareSheet = true
            } label: {
                Label("Teilen", systemImage: "square.and.arrow.up")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(accentColor)
            }
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .padding(16)
        .background(.white, in: RoundedRectangle(cornerRadius: 18))
    }

    // MARK: - Zutaten

    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Zutaten", symbol: "basket")

            VStack(spacing: 0) {
                ForEach(
                    Array(content.ingredients.enumerated()),
                    id: \.offset
                ) { index, ingredient in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "circle")
                            .font(.system(size: 16))
                            .foregroundStyle(accentColor)
                            .padding(.top, 3)

                        Text(ingredient)
                            .font(.body)

                        Spacer(minLength: 0)
                    }
                    .padding(.vertical, 12)

                    if index < content.ingredients.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 16)
            .background(.white, in: RoundedRectangle(cornerRadius: 18))
        }
    }

    // MARK: - Zubereitung

    private var preparationSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle("Zubereitung", symbol: "chef hat")

            VStack(alignment: .leading, spacing: 20) {
                ForEach(
                    Array(content.steps.enumerated()),
                    id: \.offset
                ) { index, step in
                    HStack(alignment: .top, spacing: 14) {
                        Text("\(index + 1)")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(
                                accentColor,
                                in: Circle()
                            )

                        Text(step)
                            .font(.body)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                    }
                }

                if let tip = content.tip {
                    Label {
                        Text(tip)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )
                    } icon: {
                        Image(systemName: "lightbulb.fill")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(14)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .background(
                        backgroundColor,
                        in: RoundedRectangle(cornerRadius: 14)
                    )
                }
            }
            .padding(16)
            .background(.white, in: RoundedRectangle(cornerRadius: 18))
        }
    }

    private func sectionTitle(
        _ title: String,
        symbol: String
    ) -> some View {
        Label(title, systemImage: symbol)
            .font(.title3.weight(.bold))
            .foregroundStyle(.primary)
    }

    // MARK: - Teilen

    private func makeShareText() -> String {
        var text = """
        \(recipe.title)

        Zutaten (\(content.servingSize)):
        \(content.ingredients.map { "• \($0)" }.joined(separator: "\n"))

        Zubereitung:
        \(content.steps.enumerated().map {
            "\($0.offset + 1). \($0.element)"
        }.joined(separator: "\n\n"))
        """

        if let tip = content.tip {
            text += "\n\nTipp: \(tip)"
        }

        text += "\n\nRezept aus meiner App 🙂"
        return text
    }
    
    
    private func toggleFavorite() {
        let shouldBeFavorite = !isFavorite

        // Sichtbaren Zustand sofort aktualisieren
        isFavorite = shouldBeFavorite
        recipe.isFavorite = shouldBeFavorite

        // Änderung dauerhaft speichern
        if shouldBeFavorite {
            RecipeStorage.addRecipe(recipe)
        } else {
            RecipeStorage.removeRecipe(recipe)
        }
    }


    // MARK: - Bestehende Bottom Bar

    private var bottomBar: some View {
        ZStack(alignment: .bottom) {
            BottomBarView()

            NavigationLink {
                MakeItVeganView()
                    .navigationBarBackButtonHidden(true)
                    .toolbar(.hidden, for: .navigationBar)
            } label: {
                TranslationCenterButton()
            }
            .buttonStyle(.plain)
        }
    }
}



// MARK: - Teilen

struct RecipeShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(
        context: Context
    ) -> UIActivityViewController {
        UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
    }

    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: Context
    ) {
    }
}

