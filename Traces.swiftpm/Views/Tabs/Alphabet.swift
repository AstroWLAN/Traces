// Alphabet.swift : practicing handwriting with letters
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import MijickPopups

struct Alphabet: View {
    // Parsed letters of the alphabet
    @Binding var alphabet : [ParsedLetter]?
    
    // Grid structure
    private let gridColumns = Array(repeating: GridItem(.flexible(minimum: 6), spacing: 0), count: 6)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Grid layout to visualize all the alphabet letters in an organized manner
                LazyVGrid(columns: gridColumns, alignment: .center, spacing: 40) {
                    ForEach(alphabet ?? [ParsedLetter()], id: \.self) { letter in
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
    @State var parsedLetter : ParsedLetter
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
            Task { await AlphabetPopup(letter: $selectedLetter).present() }
        }
    }
}

struct AlphabetPopup: CenterPopup {
    @Binding var letter : String
    var body: some View {
        LetterSheet(glyph: $letter)
    }
}
