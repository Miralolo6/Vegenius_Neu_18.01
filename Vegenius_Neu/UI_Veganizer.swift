//
//  UI_Veganizer.swift
//  Vegenius_Neu
//
//  Created by TA620 on 07.04.26.
//


import SwiftUI

struct UI_Veganizer: View {
    
    @StateObject private var vm = VeganViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🥦 Veganizer AI")
                .font(.largeTitle)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $vm.inputText)
                    .frame(height: 180)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    .disabled(vm.isLoading)

                if vm.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text("Gib hier ein nicht-veganes Rezept ein…")
                        .foregroundColor(.secondary)
                        .padding(14)
                }
            }
            .padding(.horizontal)
            
            Button {
                vm.veganize()
            } label: {
                HStack {
                    if vm.isLoading {
                        ProgressView()
                    }
                    Text(vm.isLoading ? "Veganisiere…" : "Veganisieren")
                        .bold()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isLoading || vm.inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .padding(.horizontal)
            
            ScrollView {
                if vm.resultText.isEmpty {
                    Text("Das vegane Rezept erscheint hier.")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                } else {
                    Text(vm.resultText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    UI_Veganizer()
}


