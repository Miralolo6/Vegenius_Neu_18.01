//
//  MakeitVegan_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 11.04.26.
//

import SwiftUI
import UIKit



struct CameraPicker2: UIViewControllerRepresentable {

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
            }
            parent.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct MakeItVeganView2: View {
    
    @Environment(\.dismiss) var dismiss
    //@State private var recipeText: String = ""
    @State private var showCamera = false
    @State private var selectedImage: UIImage?

    @StateObject private var vm = VeganViewModel()
    
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
                                    vm.veganize()
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
                        ScrollView {
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
        MakeItVeganView2()
    }
    
