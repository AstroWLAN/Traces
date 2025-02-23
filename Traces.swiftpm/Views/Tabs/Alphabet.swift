// Alphabet.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import MijickPopups

struct Alphabet: View {
    // Parsed letters of the alphabet
    @Binding var alphabet : [LetterJSON]?
    
    // Grid structure
    private let gridColumns = Array(repeating: GridItem(.flexible(minimum: 6), spacing: 0), count: 6)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Grid layout to visualize all the alphabet letters in an organized manner
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
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(.systemGray4), radius: 3)
        .onTapGesture {
            // Displays the popup
            selectedLetter = parsedLetter.letter
            Task { await HandwritingPopup(glyph: $selectedLetter).present() }
        }
    }
}

struct HandwritingPopup: CenterPopup {
    @Binding var glyph : String
    var body: some View {
        HandwritingSheet(trace: $glyph)
            .environmentObject(AppState())
    }
}
