//  AppState.swift
//  Traces
//  Created by Dario Crippa on 22/02/25

import Foundation

class AppState: ObservableObject {
    // Pencil canvas is the first responder
    @Published var canvasFirstResponder: Bool = false
    
    // Toggle canvasFirstResponder
    func toggleCanvasFirstResponder() {
        canvasFirstResponder.toggle()
    }
}
