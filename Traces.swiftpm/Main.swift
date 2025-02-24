// Main.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI

// Defines custom-shaped outlines
// Based on the tutorial: https://www.youtube.com/watch?v=98Nkp_zSEMk
extension View {
    func outline(color: Color, width: CGFloat) -> some View {
        modifier(StrokeOutline(size: width, color: color))
    }
}

// Implements a custom modifier for generating custom outline shapes
struct StrokeOutline : ViewModifier {
    private let id = UUID()
    var size : CGFloat = 1
    var color : Color = .white
    func body(content: Content) -> some View {
        content
            .padding(size*2)
            .background(
                Rectangle()
                    .foregroundStyle(color)
                    .mask(maskShape(context: content))
                    .shadow(color: Color(.black).opacity(0.5), radius: 2)
                    .drawingGroup()
            )
    }
    
    func maskShape(context: Content) -> some View {
        Canvas(rendersAsynchronously: true) { context,size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { layer in
                if let text = context.resolveSymbol(id: id) {
                    layer.draw(text, at: .init(x: size.width/2, y: size.height/2))
                }
            }
        } symbols: {
            context.tag(id)
                .blur(radius: size)
        }
    }
}

// Root view
struct Main: View {
    @State private var parsedAlphabet : [LetterJSON]?
    @State private var parsedParagraphs : [ResearchParagraphJSON]?
    var body: some View {
        // Navigation
        TabView {
            Tab("Alphabet", systemImage: "textformat") {
                Alphabet(alphabet: $parsedAlphabet)
            }
            Tab("Digits", systemImage: "function") {
                Digits()
            }
            Tab("Research", systemImage: "brain.filled.head.profile") {
                Research(research: $parsedParagraphs)
            }
        }
        .tabViewStyle(.tabBarOnly)
        .onAppear {
            // Reads and processes the alphabet data from the 'alphabet.json' file
            parsedAlphabet = parseAlphabetJSON(fileName: "alphabet") ?? [LetterJSON()]
            // Reads and processes research data from the 'research.json' file
            parsedParagraphs = parseResearchParagraphJSON(fileName: "research") ?? [ResearchParagraphJSON()]
        }
    }
}
