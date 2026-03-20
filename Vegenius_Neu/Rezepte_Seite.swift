import SwiftUI

    struct RezeptDetailView: View {
        @Binding var recipe: Recipe
        @Environment(\.dismiss) private var dismiss
        //@State private var isFavorite: Bool = false
        @State private var showShareSheet = false
        
        let shareText = """
    Mediterrane Reispfanne
        Zutaten:
        🧅 1 große rote Zwiebel
        🧄 2 Knoblauchzehen
        🫑 1 gelbe Paprika
        🥒 1 kleine Zucchini
        🍅 3 mittelgroße Tomaten
        🍚 150 g Langkornreis
        🛢️ 2 EL Rapsöl
        🥫 2 EL Tomatenmark
        🌿 1 Zweig Rosmarin
        🌿 2 Stiele Thymian
        🌿 einige Blätter frisches Basilikum
        🧂 Salz & Pfeffer nch Geschmack
        🍋 optional: etwas Zitronensaft
    
    
    1.⁠ ⁠Zwiebel und Knoblauch fein würfeln. Paprika und Zucchini in kleine Würfel schneiden, Tomaten grob hacken.

    2.⁠ ⁠In einer großen Pfanne das Rapsöl erhitzen und die Zwiebeln glasig anschwitzen, dann Knoblauch kurz mitbraten (ca. 1 Min.).

    3.⁠ ⁠Paprika und Zucchini dazugeben, 3–4 Minuten bei mittlerer Hitze anbraten, bis das Gemüse leicht gebräunt ist.

    4.⁠ ⁠Tomatenmark einrühren und 1 Minute rösten, damit sich das Aroma entfaltet.

    5.⁠ ⁠Den Langkornreis hinzufügen und alles gut vermengen, sodass der Reis leicht glasig wird.

    6.⁠ ⁠300 ml Wasser oder Gemüsebrühe angießen, Thymian und Rosmarin hinzufügen. Alles aufkochen lassen, dann die Hitze reduzieren und zugedeckt 15–18 Minuten köcheln lassen, bis der Reis gar ist.

    7.⁠ ⁠Gehackte Tomaten und Basilikum unterrühren, mit Salz, Pfeffer und optional etwas Zitronensaft abschmecken.

    8.⁠ ⁠Vor dem Servieren 5 Minuten abgedeckt ziehen lassen, dann auf Tellern anrichten. Mit frischem Basilikum garnieren.

    Tipps: Wer es scharf mag, kann Chili-Flocken hinzufügen.

    Rezept aus meiner App 🙂
    """

        var body: some View {
            ZStack(alignment: .bottom) {
                Color(red: 247/255, green: 253/255, blue: 252/255)
                    .ignoresSafeArea() // damit sie den ganzen Bildschirm füllt
                ScrollView {
                    
                    VStack(spacing: 0) {

                        // MARK: - HEADER
                        VStack(spacing: 12) {

                            HStack {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                .padding()
                                Spacer()

                                Text("Mediterrane Reispfanne – Tomaten\nPaprika Basis")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)

                                Image(systemName: "chevron.left")
                                    .opacity(0)
                            }
                            .padding(.horizontal)

                            // Bild + Favorit
                            ZStack(alignment: .topTrailing) {
                                Image("Mediterrane Reispfanne")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 260)
                                    .clipped()

                                Button {
                                    recipe.isFavorite.toggle()
                                } label: {
                                    Image(systemName: recipe.isFavorite ? "bookmark.fill" : "bookmark")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(Color(red: 82/255, green: 199/255, blue: 185/255))
                                        .padding(12)
                                        .background(Color(red: 247/255, green: 253/255, blue: 252/255))
                                        .clipShape(Circle())
                                }
                                .padding(10)
                            }
                        }
                        .padding(.top)

                        // MARK: - Zutaten + Share
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("📝 Zutatenliste (für 2–4 Personen)")
                                    .font(.headline)
                                    .padding(.leading)

                                Spacer()

                                Button {
                                    showShareSheet = true
                                } label: {
                                    Image(systemName: "square.and.arrow.up.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.mintDark)
                                        .padding(10)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                .padding(.trailing)
                            }
                        }
                        .padding(.top)

                        // MARK: - Zutaten Liste
                        VStack(alignment: .leading, spacing: 8) {
                            Zutaten(text: "🧅 1 große rote Zwiebel")
                            Zutaten(text: "🧄 2 Knoblauchzehen")
                            Zutaten(text: "🫑 1 gelbe Paprika")
                            Zutaten(text: "🥒 1 kleine Zucchini")
                            Zutaten(text: "🍅 3 mittelgroße Tomaten")
                            Zutaten(text: "🍚 150 g Langkornreis")
                            Zutaten(text: "🛢️ 2 EL Rapsöl")
                            Zutaten(text: "🥫 2 EL Tomatenmark")
                            Zutaten(text: "🌿 1 Zweig Rosmarin")
                            Zutaten(text: "🌿 2 Stiele Thymian")
                            Zutaten(text: "🌿 einige Blätter frisches Basilikum")
                            Zutaten(text: "🧂 Salz & Pfeffer nach Geschmack")
                            Zutaten(text: "🍋 optional: etwas Zitronensaft")
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)

                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📝 Zubereitung")
                                .font(.headline)
                                .padding(.top)

                            Text("""
    1.⁠ ⁠Zwiebel und Knoblauch fein würfeln. Paprika und Zucchini in kleine Würfel schneiden, Tomaten grob hacken.  

    2.⁠ ⁠In einer großen Pfanne das Rapsöl erhitzen und die Zwiebeln glasig anschwitzen, dann Knoblauch kurz mitbraten (ca. 1 Min.).  

    3.⁠ ⁠Paprika und Zucchini dazugeben, 3–4 Minuten bei mittlerer Hitze anbraten, bis das Gemüse leicht gebräunt ist.  

    4.⁠ ⁠Tomatenmark einrühren und 1 Minute rösten, damit sich das Aroma entfaltet.  

    5.⁠ ⁠Den Langkornreis hinzufügen und alles gut vermengen, sodass der Reis leicht glasig wird.  

    6.⁠ ⁠300 ml Wasser oder Gemüsebrühe angießen, Thymian und Rosmarin hinzufügen. Alles aufkochen lassen, dann die Hitze reduzieren und zugedeckt 15–18 Minuten köcheln lassen, bis der Reis gar ist.  

    7.⁠ ⁠Gehackte Tomaten und Basilikum unterrühren, mit Salz, Pfeffer und optional etwas Zitronensaft abschmecken.  

    8.⁠ ⁠Vor dem Servieren 5 Minuten abgedeckt ziehen lassen, dann auf Tellern anrichten. Mit frischem Basilikum garnieren.  

    Tipps: Wer es scharf mag, kann Chili-Flocken hinzufügen.

    """)
                            .font(.body)
                            .padding(.bottom, 20)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 120)
                }

                ZStack(alignment: .bottom) {
                    BottomBarView()
                    TranslationCenterButton()
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [shareText])
            }
        }
    }

    // MARK: - Zutaten Zeile
    struct Zutaten: View {
        let text: String

        var body: some View {
            Text(text)
                .font(.body)
                .multilineTextAlignment(.leading)
        }
    }

    
    

    // MARK: - Share Sheet
    struct ShareSheet: UIViewControllerRepresentable {

        var activityItems: [Any]

        func makeUIViewController(context: Context) -> UIActivityViewController {
            UIActivityViewController(
                activityItems: activityItems,
                applicationActivities: nil
            )
        }

        func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    }

    // MARK: - Farben
    extension Color {
        static let mintLight = Color(red: 0.56, green: 0.87, blue: 0.82)
        static let mintDark  = Color(red: 0.18, green: 0.70, blue: 0.64)
    }

#Preview {
    RezeptDetailView(
        recipe: .constant(
            Recipe(
                title: "Mediterrane Reispfanne – Tomaten\nPaprika Basis",
                imageName: "Mediterrane Reispfanne",
                category: .unter_zwanzig,
                filters: [.glutenFree, .nutFree],
                isFavorite: false
            )
        )
    )
}
