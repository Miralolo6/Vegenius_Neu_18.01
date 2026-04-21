import SwiftUI

struct BottomBarView: View {

    var body: some View {

        ZStack(alignment: .bottom) {
            Color(red: 126/255, green: 222/255, blue: 211/255)
                .ignoresSafeArea(edges: .bottom)

            CurvedBottomBarShape()
                .fill(Color(red: 126/255, green: 222/255, blue: 211/255))
                .frame(height: 90)
                .ignoresSafeArea(edges: .bottom)
            HalfCircle()
                .fill(Color(red: 126/255, green: 222/255, blue: 211/255))
                .frame(width: 140, height: 70)
                .offset(y: -45)
            

            HStack {

                Spacer()

                NavigationLink(destination: RezepteView()) {
                    VStack {
                        Image("Gespeichert_Seite")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .font(.system(size: 48, weight: .semibold))

                        Text("Gespeichert")
                            .font(.system(size: 16, weight: .medium))
                    }
                }

                Spacer()
                Spacer()
                Spacer()

                NavigationLink(destination: MyRecipesView2()) {
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
