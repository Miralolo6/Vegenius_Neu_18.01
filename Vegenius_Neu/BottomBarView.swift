import SwiftUI

struct BottomBarView: View { // minzgrüne Balken unten mit den Buttons
    var body: some View {
        ZStack(alignment: .top) {

            // VOLLE Bottom Bar Fläche
            Color(red: 126/255, green: 222/255, blue: 211/255)
                .ignoresSafeArea(edges: .bottom)

            // Inhalte
            HStack {
                Spacer()

                Button {
                    print("Gespeichert gedrückt")
                } label: {
                    VStack {
                        Image("Gespeichert_Seite")
                            .resizable()
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .font(.system(size: 48, weight: .semibold))
                        Text("Gespeichert")
                            .font(.system(size: 16, weight: .medium))
                    }
                }

                Spacer()
                Spacer() // Platz für Center Button
                Spacer()

                Button {
                    print("Meine_Rezepte gedrückt")
                } label: {
                    VStack {
                        Image("Meine_Rezepte")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("Meine Rezepte")
                            .font(.system(size: 16, weight: .medium))
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .padding(.top, 28)
        }
        .frame(height: 60)
    }
}
