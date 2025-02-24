// Digits.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI

struct Digits: View {
    // Defines the grid structure
    private let gridColumns = Array(repeating: GridItem(.flexible(minimum: 5), spacing: 0), count: 5)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Creates a grid structure to visualize all the digits from 0 to 9 in an orderly manner
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
    @State var currentDigit : Int
    @State private var selectedDigit : String = String()
    // Defines a dictionary mapping digits to their string representations
    private let digits : [String] = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
    var body: some View {
        // Digit
        ZStack {
            Image(digits[currentDigit])
                .resizable()
                .scaledToFill()
                .frame(width: 120)
            VStack(spacing: 0)  {
                Spacer()
                Text(digits[currentDigit])
                    .font(.custom("Playwrite", size: 17))
                    .foregroundStyle(Color(.systemGray))
                    .outline(color: .white, width: 2)
            }
            .padding(.bottom, 10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(.systemGray4), radius: 3)
        .onTapGesture {
            // Transforms the integer 1 into a string ("1") without converting it to its word form
            selectedDigit = String(currentDigit)
            Task { await HandwritingPopup(trace: $selectedDigit).present() }
        }
    }
}
