// Main.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI

struct Main: View {
    var body: some View {
        TabView {
            Tab("Alphabet", systemImage: "textformat") {
                Alphabet()
            }
            Tab("Digits", systemImage: "function") {
                Digits()
            }
            Tab("Shapes", systemImage: "hexagon") {
                Shapes()
            }
            Tab("Research", systemImage: "brain.filled.head.profile") {
                Research()
            }
        }
        .tabViewStyle(.tabBarOnly)
    }
}
