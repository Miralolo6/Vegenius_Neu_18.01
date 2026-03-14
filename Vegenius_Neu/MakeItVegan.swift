//
//  MakeItVegan.swift
//  Vegenius_Neu
//
//  Created by TA617 on 18.01.26.
//
import SwiftUI
import UIKit



struct CameraPicker: UIViewControllerRepresentable {

    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct MakeItVeganView: View {
    
    @State private var recipeText: String = ""
    @State private var showCamera = false
    @State private var selectedImage: UIImage?

    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color(
                    red:247/255,
                    green:253/255,
                    blue:252/252)
                .ignoresSafeArea()
                
                
                
                ScrollView{
                    
                    VStack(spacing: 24) {
                        
                        
                        // MARK: - Header
                        HStack {
                            Button(action: {
                                // Back action
                            }) {
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
                                
                                
                                TextEditor(text: $recipeText)
                                    .font(.body)
                                    .frame(minHeight: 120)
                                
                                if recipeText.isEmpty {
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
                                
                                Button(action: {
                                    print("Send tapped")
                                }) {
                                    Image(systemName: "arrow.up")
                                        .foregroundColor(.white)
                                        .padding(12)
                                        .background(Color.teal)
                                        .clipShape(Circle())
                                }
                            }
                            .foregroundColor(.gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(1))
                        )
                        .padding(.horizontal)
                        
                        Spacer(minLength: 500)
                        
                            .sheet(isPresented: $showCamera) {
                                CameraPicker(image: $selectedImage)
                            }
                        
                    }
                    .padding(.top)
                }
            }
        }
        
    }
    
    
}
    
    #Preview {
        MakeItVeganView()
    }
    
