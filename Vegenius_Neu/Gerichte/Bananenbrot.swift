import SwiftUI

struct BananenbrotView: View {
    @Binding var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    
    let shareText = """
Bananenbrot
    Zutaten:
    🍌 3 reife Bananen
    🌾 200 g glutenfreies Mehl
    🥄 50 g Ahornsirup (oder Agavendicksaft)
    🫒 50 ml Pflanzenöl (z. B. Sonnenblumen- oder Rapsöl)
    💧 50 ml Pflanzenmilch (Hafer- oder Sojamilch, ungesüßt)
    🧂 1 TL Backpulver
    🧂 1 Prise Salz
    🥄 1 TL Zimt (optional)
    🌾 1 TL Leinsamen + 3 TL Wasser

1.  Bananen mit Gabel zerdrücken.
2.  Leinsamen mit Wasser mischen, 5 Min quellen lassen.
3.  Öl, Pflanzenmilch und Ahornsirup zu den Bananen geben, gut verrühren.
4.  Mehl, Backpulver, Salz und Zimt dazugeben, kurz zu einem Teig verrühren.
5.  Teig in eine gefettete oder mit Backpapier ausgelegte Kastenform füllen.
6.  Backofen 180 °C, 40–45 Min backen, Stäbchenprobe machen.
7.  Abkühlen lassen, in Scheiben schneiden.

💡 Tipp: Für extra Saftigkeit Bananen leicht überreif verwenden und den Teig nicht zu lange rühren.

Rezept aus meiner App Vegenius 🙂
"""
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color(red: 247/255, green: 253/255, blue: 252/255)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        // HEADER
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
                                
                                Image(systemName: "chevron.left")
                                    .opacity(0)
                            }
                            .overlay(
                                Text("Bananenbrot")
                                    .font(.headline)
                            )
                            .padding(.horizontal)
                            
                            ZStack(alignment: .topTrailing) {
                                Image("Bananenbrot")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 310)
                                
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
                        
                        // ZUTATEN HEADER
                        HStack {
                            Text("📝 Zutatenliste (für 8 Scheiben)")
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
                        .padding(.top)
                        
                        // ✨ NEUE ZUTATEN LISTE
                        VStack(alignment: .leading, spacing: 10) {
                            ZutatenRow(emoji: "🍌", text: "3 reife Bananen")
                            ZutatenRow(emoji: "🌾", text: "200 g glutenfreies Mehl")
                            ZutatenRow(emoji: "🥄", text: "50 g Ahornsirup (oder Agavendicksaft)")
                            ZutatenRow(emoji: "🫒", text: "50 ml Pflanzenöl (z. B. Sonnenblumen- oder Rapsöl)")
                            ZutatenRow(emoji: "💧", text: "50 ml Pflanzenmilch (Hafer- oder Sojamilch, ungesüßt)")
                            ZutatenRow(emoji: "🧂", text: "1 TL Backpulver")
                            ZutatenRow(emoji: "🧂", text: "1 Prise Salz")
                            ZutatenRow(emoji: "🥄", text: "1 TL Zimt (optional)")
                            ZutatenRow(emoji: "🌾", text: "1 TL Leinsamen + 3 TL Wasser")
                        }
                        .padding(.horizontal)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                        
                        // ZUBEREITUNG
                        VStack(alignment: .leading, spacing: 12) {
                            Text("📝 Zubereitung")
                                .font(.headline)
                                .padding(.top)
                            
                            ZubereitungRow(nummer: "1.", text: "Bananen mit Gabel zerdrücken.")
                            ZubereitungRow(nummer: "2.", text: "Leinsamen mit Wasser mischen, 5 Min quellen lassen.")
                            ZubereitungRow(nummer: "3.", text: "Öl, Pflanzenmilch und Ahornsirup zu den Bananen geben, gut verrühren.")
                            ZubereitungRow(nummer: "4.", text: "Mehl, Backpulver, Salz und Zimt dazugeben, kurz zu einem Teig verrühren.")
                            ZubereitungRow(nummer: "5.", text: "Teig in eine gefettete oder mit Backpapier ausgelegte Kastenform füllen.")
                            ZubereitungRow(nummer: "6.", text: "Backofen 180 °C, 40–45 Min backen, Stäbchenprobe machen.")
                            ZubereitungRow(nummer: "7.", text: "Abkühlen lassen, in Scheiben schneiden.")
                            
                            Text("💡 Tipp: Für extra Saftigkeit Bananen leicht überreif verwenden und den Teig nicht zu lange rühren.")
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
                RecipeShareSheet(activityItems: [shareText])
            }
        }
    }
}

#Preview {
    BananenbrotView(
        recipe: .constant(
            Recipe(
                title: "Bananenbrot",
                imageName: "Bananenbrot",
                category: .suess,
                filters: [.nutFree, .glutenFree],
                isFavorite: false,
                //route: .defaultRecipe
            )
        )
    )
}


// ✨ NEUE ZUTATEN ROW
struct ZutatenRow: View {
    let emoji: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.title3)
                .frame(width: 30)
            
            Text(text)
                .font(.system(size: 16))
            
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 14)
        .background(Color(red: 241/255, green: 248/255, blue: 246/255))
        .cornerRadius(14)
    }
}
