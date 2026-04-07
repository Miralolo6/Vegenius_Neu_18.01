//
//  UI_Veganizer.swift
//  Vegenius_Neu
//
//  Created by TA620 on 07.04.26.
//

import SwiftUI

struct UI_Veganizer: View {
    @StateObject private var vm: VeganViewModel

    init(viewModel: VeganViewModel) {
        _vm = StateObject(wrappedValue: viewModel)
    }

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

            if let error = vm.errorMessage, !error.isEmpty {
                Text(error)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }

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
    // Provide a mock service so Canvas does not perform network requests
    struct MockAIService: AIServiceProtocol {
        func veganize(recipe: String) async throws -> String {
            """
            Zutaten:
            - 200 g Pasta
            - 150 g Sojahack
            - 100 ml Hafermilch
            Zubereitung:
            1) Beispiel-Schritt 1
            2) Beispiel-Schritt 2
            """
        }
    }

    let vm = VeganViewModel(service: MockAIService())
    return UI_Veganizer(viewModel: vm)
}
