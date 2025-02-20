// Digits.swift :
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI

struct Digits: View {
    // Grid structure
    private let gridColumns = Array(repeating: GridItem(.flexible(minimum: 5), spacing: 0), count: 5)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Grid layout to visualize all the digits in an organized manner
                LazyVGrid(columns: gridColumns, alignment: .center, spacing: 40) {
                    ForEach(0..<10, id: \.self) { index in
                        Number(currentDigit: index)
                    }
                }
            }
            .padding(.horizontal, 80)
            .scrollIndicators(.hidden)
        }
    }
}

struct Number : View {
    private let digits : [Int : String] = [0:"Zero", 1:"One", 2:"Two", 3:"Three", 4:"Four", 5:"Five", 6:"Six", 7:"Seven", 8:"Eight", 9:"Nine"]
    @State var currentDigit : Int
    @State private var selectedDigit : String = String()
    var body: some View {
        ZStack {
            Image(digits[currentDigit] ?? "Missing")
                .resizable()
                .scaledToFill()
                .frame(width: 120)
            VStack(spacing: 0)  {
                Spacer()
                Text(digits[currentDigit] ?? "Missing")
                    .font(.custom("Playwrite", size: 17))
                    .foregroundStyle(Color(.systemGray))
                    .outline(color: .white, width: 2)
            }
            .padding(.bottom, 10)
        }
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(.systemGray5), radius: 2)
        .onTapGesture {
            // Displays the popup
            selectedDigit = String(currentDigit)
            Task { await AlphabetPopup(letter: $selectedDigit).present() }
        }
    }
}
