//
//  MakeitVegan_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 11.04.26.
//

import SwiftUI //moderne UI in Swift
import UIKit //ältere iOS-Komponenten (hier wichtig für Kamera)



struct CameraPicker2: UIViewControllerRepresentable { //UIKit-Kamera-Controller in SwiftUI eingebaut

    @Environment(\.dismiss) var dismiss //Ermöglicht das Schließen des Kamera-Fensters
    @Binding var image: UIImage? //Verbindet das ausgewählte Bild mit der Haupt-View
    

    func makeUIViewController(context: Context) -> UIImagePickerController { //Erstellt den iOS Kamera-Controller
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        //Öffnet direkt die Kamera
        picker.delegate = context.coordinator //Ergebnis wird vom Coordinator verarbeitet
        return picker //Kamera-Controller zurückgeben
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {} //nicht genutzt

    func makeCoordinator() -> Coordinator { //Helfer-Objekt
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate { //Kamera-Ergebnisse kümmern

        let parent: CameraPicker2

        init(_ parent: CameraPicker2) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            } //Speichert das Foto in der Binding-Variable
            parent.dismiss() //Schließt Kamera
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct MakeItVeganView2: View { //Hauptoberfläche
    
    @Environment(\.dismiss) var dismiss //Schließt diese View
    @State private var showCamera = false //Steuert Kamera-Overlay
    @State private var selectedImage: UIImage? //Speichert Foto aus Kamera

    @StateObject private var vm = VeganViewModel() //ViewModel für Logik (z.B. veganisieren)
    
    
    
    @State private var showResult = false //Ergebnisseite anzeigen
    
    var body: some View {
        
        NavigationStack { //Navigation wird aktiviert
            
            ZStack {
                Color(
                    red:247/255,
                    green:253/255,
                    blue:252/252)
                .ignoresSafeArea() //Füllt kompletten Bildschirm
                
                
                
                ScrollView{
                    
                    VStack(spacing: 24) {
                        
                        
                        // MARK: - Header
                        HStack {
                            Button{
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                            
                            
                            
                            Spacer()
                            
                            Text("Make it vegan")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(
                                    Color(
                                        red:231/255,
                                        green: 161/255,
                                        blue: 176/255
                                    )
                                )
                            
                            Spacer()
                            
                            // Empty space to keep title centered
                            Color.clear.frame(width: 24)
                        }
                        .padding(.horizontal)
                        
                        
                        // MARK: - Input Card
                        VStack(alignment: .leading, spacing: 12) {
                            
                            ZStack(alignment: .topLeading) {
                                
                                
                                TextEditor(text: $vm.inputText)
                                    .font(.body)
                                    .frame(minHeight: 120)
                                    .disabled(vm.isLoading)
                                
                                if vm.inputText.isEmpty {
                                    Text("Gib dein Rezept ein!")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                        .padding(.top, 10)
                                        .padding(.leading, 1)
                                        .allowsHitTesting(false)
                                }
                            }
                            
                            HStack(spacing: 16) {
                                Button {
                                    showCamera = true
                                } label: {
                                    Image(systemName: "camera")
                                }
                                Image(systemName: "mic")
                                Spacer()
                                
                                
                                Button {
                                    vm.veganize {
                                        showResult = true
                                    }
                                } label: {
                                    Image(systemName: "arrow.up")
                                        .foregroundColor(.white)
                                        .padding(12)
                                        .background(Color.teal)
                                        .clipShape(Circle())
                                }
                                .contentShape(Circle())
                                .disabled(vm.isLoading || vm.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                                
                                
                            }
                            .foregroundColor(.gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(1))
                        )
                        .padding(.horizontal)
                        
                        // MARK: - Ergebnis
                        /*ScrollView {
                         if vm.resultText.isEmpty {
                         Text("Das vegane Rezept erscheint hier.")
                         .foregroundColor(.secondary)
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding()
                         } else {
                         VeganResultView2(text: vm.resultText)
                         }
                         }
                         .frame(maxHeight: 300) // optional: begrenzt Höhe
                         .padding(.horizontal)*/
                        
                        Spacer(minLength: 500)
                        
                            
                        
                    }
                    .padding(.top)
    
                }
                .navigationDestination(isPresented: $showResult) {
                    VeganResultView2(text: vm.resultText)
                }
  
                
            }
            
            .sheet(isPresented: $showCamera) {
                CameraPicker2(image: $selectedImage)
            }
        }
        
    }
    
    
}
    
    #Preview {
        MakeItVeganView2()
    }
    
