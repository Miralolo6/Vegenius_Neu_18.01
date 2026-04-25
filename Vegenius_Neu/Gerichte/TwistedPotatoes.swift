//
//  TwistedPotatoes.swift
//  Vegenius_Neu
//
//  Created by TA620 on 10.03.26.
//

import SwiftUI

    struct TwistedPotatoesView: View {
        @Binding var recipe: Recipe
        @Environment(\.dismiss) private var dismiss
        //@State private var isFavorite: Bool = false
        @State private var showShareSheet = false
        
        let shareText = """
    Vegane Twisted Potatoes
        Zutaten:
        🥔 4 große Kartoffeln (festkochend)
        🫒 2–3 EL Olivenöl
        🧂 1 TL Salz
        🌶️ 1 TL Paprikapulver (edelsüß oder geräuchert)
        🧄 ½ TL Knoblauchpulver
        🧅 ½ TL Zwiebelpulver
        🌿 ½ TL getrocknete Kräuter (z. B. Oregano oder Thymian)
        🌶️ Optional: etwas Chili oder Cayennepfeffer für Schärfe
    

    1.  Kartoffeln waschen.
    
    2.  Holzspieß längs durch jede Kartoffel stecken.
    
    3.  Kartoffel spiralförmig einschneiden.
    
    4.  Spirale vorsichtig auseinanderziehen.
    
    5.  Mit Olivenöl einreiben.
    
    6.  Mit Gewürzen bestreuen.
    
    7.  Backofen: 200 °C, 30–40 Min backen
        oder 🌪️ Airfryer: 180 °C, 20–25 Min.

    Rezept aus meiner App Vegenius 🙂
    """

        var body: some View {
            NavigationStack {
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
                                    
                                    Image(systemName: "chevron.left")
                                        .opacity(0)
                                }
                                .overlay(
                                    Text("Twisted Potatoes")
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                )
                                .padding(.horizontal)
                                
                                // Bild + Favorit
                                ZStack(alignment: .topTrailing) {
                                    Image("Twisted Potatoe")
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
                                    Text("📝 Zutatenliste (für 1-2 Personen)")
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
                                                        ZutatenRow(emoji: "🥔", text: "4 große Kartoffeln (festkochend)")
                                                        ZutatenRow(emoji: "🫒", text: "2–3 EL Olivenöl")
                                                        ZutatenRow(emoji: "🧂", text: "1 TL Salz")
                                                        ZutatenRow(emoji: "🌶️", text: "1 TL Paprikapulver (edelsüß oder geräuchert)")
                                                        ZutatenRow(emoji: "🧄", text: "½ TL Knoblauchpulver")
                                                        ZutatenRow(emoji: "🧅", text: "½ TL Zwiebelpulver")
                                                        ZutatenRow(emoji: "🌿", text: "½ TL getrocknete Kräuter (z.B. Oregano oder Thymian)")
                                                        ZutatenRow(emoji: "🌶️", text: "Optional: etwas Chili oder Cayennepfeffer für Schärfe")
                                                    
                              
                            }
                            .padding(.horizontal)
                            .padding(.top, 5)
                            .padding(.bottom, 20)
                            
                            // MARK: - Zubereitung
                            VStack(alignment: .leading, spacing: 8) {
                                Text("📝 Zubereitung")
                                    .font(.headline)
                                    .padding(.top)
                                
                                Text("""
        
        1.⁠ ⁠Kartoffeln waschen. 
        
        2.⁠ ⁠Holzspieß längs durch jede Kartoffel stecken. 
        
        3.⁠ ⁠Kartoffel spiralförmig einschneiden. 
        
        4.⁠ ⁠Spirale vorsichtig auseinanderziehen. 
        
        5.⁠ ⁠Mit Olivenöl einreiben. 
        
        6.⁠ ⁠Mit Gewürzen bestreuen. 
        
        7.⁠ ⁠Backofen: 200 °C, 30–40 Min backen
            oder Airfryer: 180 °C, 20–25 Min. 
        
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
                .navigationBarBackButtonHidden(true)
                .sheet(isPresented: $showShareSheet) {
                    RecipeShareSheet(activityItems: [shareText])
                }
            }
        }
    }

// MARK: - Share Sheet (unique)
struct RecipeShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


    
#Preview {
    TwistedPotatoesView(
        recipe: .constant(
            Recipe(
                title: "Twisted Potatoes",
                imageName: "Twisted Potatoe",
                category: .herzhaft,
                filters: [.glutenFree, .nutFree],
                isFavorite: false,
              //  route: .defaultRecipe
            )
        )
    )
}
   
