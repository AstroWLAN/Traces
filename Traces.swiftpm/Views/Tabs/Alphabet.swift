// Alphabet.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import MijickPopups

struct Alphabet: View {
    // Alphabet letters extracted from 'alphabet.json'
    @Binding var alphabet : [LetterJSON]?
    
    // Defines the grid structure
    private let gridColumns = Array(repeating: GridItem(.flexible(minimum: 6), spacing: 0), count: 6)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Creates a grid structure to visualize all the alphabet letters in an orderly manner
                LazyVGrid(columns: gridColumns, alignment: .center, spacing: 40) {
                    ForEach(alphabet ?? [LetterJSON()], id: \.self) { letter in
                        Letter(parsedLetter: letter)
                    }
                }
            }
            .padding(.horizontal, 80)
            .scrollIndicators(.hidden)
        }
    }
}

struct Letter : View {
    @State var parsedLetter : LetterJSON
    @State private var selectedLetter : String = String()
    var body: some View {
        ZStack {
            // Letter
            Image(parsedLetter.word)
                .resizable()
                .scaledToFill()
                .frame(width: 120)
            VStack(spacing: 0)  {
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text(parsedLetter.letter.capitalized)
                    Text(parsedLetter.letter)
                }
                .font(.custom("Playwrite", size: 22))
                .foregroundStyle(Color(.black))
                .outline(color: .white, width: 2)
                Text(parsedLetter.word)
                    .font(.custom("Playwrite", size: 17))
                    .foregroundStyle(Color(.systemGray))
                    .outline(color: .white, width: 2)
            }
            .padding(.bottom, 10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(.systemGray4), radius: 3)
        .onTapGesture {
            selectedLetter = parsedLetter.letter
            // Presents the HandwritingPopup
            Task { await HandwritingPopup(trace: $selectedLetter).present() }
        }
    }
}
