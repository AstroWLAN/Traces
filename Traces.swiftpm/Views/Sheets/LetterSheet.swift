// Handwriting.swift :
// Traces
// Created by Dario Crippa on 18/02/25

import SwiftUI
import MijickPopups

// Letter‐case forms
private enum caseForm: String, CaseIterable, Equatable {
    case minuscule
    case majuscule
}

struct LetterSheet: View {
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // Sheet content
            
            
        }
        .frame(width: 640, height: 540)
    }
}

