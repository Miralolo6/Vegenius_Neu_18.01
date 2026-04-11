//
//  Übersetzte_Rezepte_2.swift
//  Vegenius_Neu
//
//  Created by TA620 on 11.04.26.
//

import SwiftUI

struct VeganResultView2: View {
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Vegan Edition")
                .font(.system(size: 30, weight: .bold, design: .default))
                .foregroundColor(
                    Color(red: 231/255, green: 161/255, blue: 176/255)
                )
            
            let sections = text.components(separatedBy: "\n\n")

            ForEach(sections, id: \.self) { section in
                
                if section.lowercased().contains("zutaten") {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Zutaten")
                            .font(.headline)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(
                                Color(red: 231/255, green: 161/255, blue: 176/255)
                            )
                        
                        ForEach(section.components(separatedBy: "\n").dropFirst(), id: \.self) { item in
                            Text("• \(item.replacingOccurrences(of: "- ", with: ""))")
                        }
                    }
                    
                } else if section.lowercased().contains("zubereitung") {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Zubereitung")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(
                                Color(red: 231/255, green: 161/255, blue: 176/255))
                        
                        ForEach(section.components(separatedBy: "\n").dropFirst(), id: \.self) { step in
                            Text(step)
                        }
                    }
                    
                } else {
                    Text(section)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal)
    }
}
