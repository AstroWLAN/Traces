// Handwriting.swift :
// Traces
// Created by Dario Crippa on 18/02/25

import SwiftUI
import MijickPopups
import PencilKit

// Letter‐case forms
enum caseForm: String, CaseIterable, Equatable {
    case minuscule
    case majuscule
}

struct HandwritingSheet: CenterPopup {
    @Binding var trace: String
    @State private var canvasView = PKCanvasView()
    @State private var selectedCase: caseForm = .minuscule
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            // Sheet content
            ZStack {
                // Handwriting canvas
                HandwritingCanvas(symbol: $trace, selectedForm: $selectedCase, canvasView: $canvasView)
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        // Letter-case picker
                        Picker(String(), selection: $selectedCase) {
                            ForEach(caseForm.allCases, id: \.self) { style in
                                Text(style.rawValue.capitalized).tag(style)
                            }
                        }
                        .fixedSize()
                        .pickerStyle(SegmentedPickerStyle())
                        .opacity(isGlyphDigit($trace) ? 0 : 1)
                        .onChange(of: selectedCase) { _,_ in
                            canvasView.drawing = PKDrawing()
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .overlay {
                        HStack {
                            Spacer()
                            // Sheet close button
                            Button(action: {
                                Task { await dismissAllPopups() }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(Color.secondary)
                                    .font(.system(.title2))
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    Spacer()
                }
            }
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(10)
            .shadow(color: Color(.systemGray4), radius: 4)
        }
        .frame(width: 640, height: 540)
    }
    func onDismiss() {
        canvasView.resignFirstResponder()
    }
}

struct HandwritingCanvas : View {
    @Binding var symbol : String
    @Binding var selectedForm : caseForm
    @Binding var canvasView : PKCanvasView
    
    // Tool picker è l'interfaccia che permette di selezionare gli strumenti di disegno
    @State private var toolPicker = PKToolPicker()
    var body: some View {
        ZStack {
            // Letter grid
            Grid(alignment: .center, horizontalSpacing:80, verticalSpacing:20) {
                ForEach (0..<4) { row in
                    GridRow {
                        ForEach(0..<4) { _ in
                            HStack(alignment: .lastTextBaseline, spacing: 10) {
                                Text(selectedForm == .minuscule ? symbol.lowercased() : symbol.uppercased())
                            }
                            .foregroundStyle(Color(.systemGray4))
                            .font(.custom("Playwrite", size: 22))
                        }
                    }
                    Divider()
                }
            }
            .padding(80)
            DrawingView(canvasView: $canvasView, toolPicker: $toolPicker)
        }
    }
}

// UIViewRepresentable permette di utilizzare una UIView di UIKit in SwiftUI
struct DrawingView: UIViewRepresentable {
    // @Binding permette di ricevere riferimenti modificabili dalle proprietà
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    
    // Questa funzione viene chiamata quando la vista viene creata
    func makeUIView(context: Context) -> PKCanvasView {
        // Configuriamo lo strumento iniziale: penna nera con spessore 15
        canvasView.tool = PKInkingTool(.pen, color: .systemBlue, width: 15)
    
        canvasView.drawingPolicy = .pencilOnly
        
        canvasView.backgroundColor = .clear
        
        // Configuriamo il tool picker
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        
        // Facciamo diventare il canvas il first responder per ricevere gli input
        self.canvasView.becomeFirstResponder()
        return canvasView
    }
    
    // Questa funzione viene chiamata quando la vista deve essere aggiornata
    // Al momento non abbiamo bisogno di aggiornamenti specifici
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}

func isGlyphDigit(_ glyph: Binding<String>) -> Bool {
    // Ensure the string is exactly one character long
    guard glyph.wrappedValue.count == 1,
          let character = glyph.wrappedValue.first,
          character.isNumber,
          let intValue = Int(String(character))
    else {
        return false
    }
    // Check if the number is between 0 and 9
    return (0...9).contains(intValue)
}
