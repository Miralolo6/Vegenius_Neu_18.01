import SwiftUI

struct RezeptDetailView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
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


1. Zwiebel & Knoblauch würfeln, Gemüse schneiden.

2. Zwiebeln im Öl glasig braten, Knoblauch kurz dazu.

3. Paprika & Zucchini 3–4 Min. anbraten.

4. Tomatenmark 1 Min. rösten.

5. Reis einrühren, kurz glasig werden lassen.

6. 300 ml Wasser & Kräuter dazu, 15–18 Min. köcheln.

7. Tomaten & Basilikum unterrühren, würzen

8. 5 Min. ziehen lassen, servieren.

💡Tipp: Optional Chili für Schärfe.

Rezept aus meiner App Vegenius 🙂
"""

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(red: 247/255, green: 253/255, blue: 252/255)
                    .ignoresSafeArea()
                
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
                            
                            ZStack(alignment: .topTrailing) {
                                Image("Mediterrane Reispfanne")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 310)
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
                        VStack(alignment: .leading, spacing: 10) {
                                                    ZutatenRow(emoji: "🧅", text: "1 große rote Zwiebel")
                                                    ZutatenRow(emoji: "🧄", text: "2 Knoblauchzehen")
                                                    ZutatenRow(emoji: "🫑", text: "1 gelbe Paprika")
                                                    ZutatenRow(emoji: "🥒", text: "1 kleine Zucchini")
                                                    ZutatenRow(emoji: "🍅", text: "3 mittelgroße Tomaten")
                                                    ZutatenRow(emoji: "🍚", text: "150 g Langkornreis")
                                                    ZutatenRow(emoji: "🛢️", text: "2 EL Rapsöl")
                                                    ZutatenRow(emoji: "🥫", text: "2 EL Tomatenmark")
                                    ZutatenRow(emoji: "🌿 ", text: "1 Zweig Rosmarin")
                                    ZutatenRow(emoji: "🌿", text: "2 Stiele Thymian")
                                    ZutatenRow(emoji: "🌿", text: "einige Blätter frisches Basilikum")
                                    ZutatenRow(emoji: "🧂", text: "Salz & Pfeffer nach Geschmack")
                                    ZutatenRow(emoji: "🍋", text: "optional: etwas Zitronensaft")
                            
                            
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // MARK: - Zubereitung
                        VStack(alignment: .leading, spacing: 12) {
                            Text("📝 Zubereitung")
                                .font(.headline)
                                .padding(.top)
                            
                            ZubereitungRow(nummer: "1.", text: "Zwiebel & Knoblauch würfeln, Gemüse schneiden.")
                            ZubereitungRow(nummer: "2.", text: "Zwiebeln im Öl glasig braten, Knoblauch kurz dazu.")
                            ZubereitungRow(nummer: "3.", text: "Paprika & Zucchini 3–4 Min. anbraten.")
                            ZubereitungRow(nummer: "4.", text: "Tomatenmark 1 Min. rösten.")
                            ZubereitungRow(nummer: "5.", text: "Reis einrühren, kurz glasig werden lassen.")
                            ZubereitungRow(nummer: "6.", text: "300 ml Wasser & Kräuter dazu, 15–18 Min. köcheln.")
                            ZubereitungRow(nummer: "7.", text: "Tomaten & Basilikum unterrühren, würzen.")
                            ZubereitungRow(nummer: "8.", text: "5 Min. ziehen lassen, servieren.")
                            
                            Text("💡Tipp: Optional Chili für Schärfe.")
                                .padding(.top, 5)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 120)
                }
                
                ZStack(alignment: .bottom) {
                    BottomBarView()
                    NavigationLink {
                        MakeItVeganView2()
                            .navigationBarBackButtonHidden(true)
                            .toolbar(.hidden, for: .navigationBar)
                    } label: {
                        TranslationCenterButton()
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: [shareText])
            }
        }
    }
}

// MARK: - Zutaten Zeile (FINAL FIX)
struct Zutaten: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .multilineTextAlignment(.leading)
            
            Spacer() // ← zwingt alles nach links
        }
    }
}

// MARK: - Zubereitung Row
struct ZubereitungRow: View {
    let nummer: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(nummer)
                .frame(width: 25, alignment: .leading)
            
            Text(text)
                .multilineTextAlignment(.leading)
        }
        .font(.body)
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
                isFavorite: false,
               // route: .defaultRecipe
            )
        )
    )
}
