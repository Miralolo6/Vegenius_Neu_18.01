//
//  Recipe.swift
//  Vegenius_Neu
//
//  Created by Miriam Nguyen on 30.05.26.
//

import SwiftUI

struct Recipe: Identifiable, Equatable {

    let id: UUID

    var title: String
    var description: String = ""

    // Für normale Rezepte
    var imageName: String = ""

    // Für AI-generierte Rezepte
    var generatedText: String? = nil

    // Für selbst erstellte Rezepte
    var image: UIImage? = nil
    var note: String = ""

    // Kategorien
    var category: Category = .alle
    var filters: Set<FilterType> = []

    // Favoriten
    var isFavorite: Bool = false

    // Kennzeichnung
    var isGenerated: Bool = false

    init(
        id: UUID = UUID(),
        title: String,
        description: String = "",
        imageName: String = "",
        generatedText: String? = nil,
        image: UIImage? = nil,
        note: String = "",
        category: Category = .alle,
        filters: Set<FilterType> = [],
        isFavorite: Bool = false,
        isGenerated: Bool = false
    ) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.generatedText = generatedText
        self.image = image
        self.note = note
        self.category = category
        self.filters = filters
        self.isFavorite = isFavorite
        self.isGenerated = isGenerated
    }
}
