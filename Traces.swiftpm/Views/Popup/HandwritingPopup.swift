// HandwritingPopup.swift
// Traces
// Created by Dario Crippa on 18/02/25

import SwiftUI
import PencilKit
import MijickPopups

// Possible letter-case forms
enum caseForm: String, CaseIterable, Equatable {
    case lowercase
    case capital
}

struct HandwritingPopup: CenterPopup {
    // Trace of the selected letter or digit
    @Binding var trace: String
    @State private var canvasView = PKCanvasView()
    @State private var selectedCase: caseForm = .lowercase
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            ZStack {
                // Handwriting canvas for Apple Pencil interactions
                HandwritingCanvas(symbol: $trace, selectedForm: $selectedCase, canvas: $canvasView)
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        // Letter-case selector for handwriting style options
                        Picker(String(), selection: $selectedCase) {
                            ForEach(caseForm.allCases, id: \.self) { style in
                                Text(style.rawValue.capitalized)
                                    .tag(style)
                                    .font(.system(size: 17, weight: .regular))
                            }
                        }
                        .fixedSize()
                        .pickerStyle(SegmentedPickerStyle())
                        .opacity(isDigit(glyph: $trace) ? 0 : 1)
                        .onChange(of: selectedCase) { _,_ in
                            // Cleans up the canvas during transitions between capital and lowercase letter styles
                            canvasView.drawing = PKDrawing()
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .overlay {
                        HStack {
                            Spacer()
                            // Dismesses the HandwritingPopup
                            Button(action: { Task { await dismissAllPopups() }}) {
                                Image(systemName: "xmark.circle.fill")
                                    .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(Color(.systemBlue))
                                    .font(.system(size: 22, weight: .regular))
                            }
                            .padding(10)
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
        // Ensure the canvas resigns first responder status once the popup is dismissed
        canvasView.resignFirstResponder()
    }
}

struct HandwritingCanvas: View {
    @Binding var symbol: String
    @Binding var selectedForm: caseForm
    @Binding var canvas: PKCanvasView
    
    var body: some View {
        ZStack {
            // Generates a grid of symbols inserting a divider between every row
            Grid(alignment: .center, horizontalSpacing: 100, verticalSpacing: 20) {
                ForEach(Array((0..<4).enumerated()), id: \.offset) { _,index in
                    GridRow {
                        ForEach(0..<4) { _ in
                            HStack(alignment: .lastTextBaseline, spacing: 10) {
                                Text(selectedForm == .lowercase ? symbol.lowercased() : symbol.uppercased())
                            }
                            .foregroundStyle(Color(.systemGray4))
                            .font(.custom("Playwrite", size: 32))
                        }
                    }
                    if index != 3 { Divider() }
                }
            }
            .padding(80)
            DrawingView(canvas: $canvas)
        }
    }
}

// Apple Pencil canvas 
struct DrawingView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @State private var toolPicker = PKToolPicker()
    func makeUIView(context: Context) -> PKCanvasView {
        // Configures the initial drawing tool
        canvas.tool = PKInkingTool(.monoline, color: .black, width: 15)
        // Disables drawing actions triggered by finger touch input
        canvas.drawingPolicy = .pencilOnly
        // Sets the canvas background to transparent
        canvas.backgroundColor = .clear
        // Sets the canvas as the primary responder
        canvas.becomeFirstResponder()
        // Configures the tool picker
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) { }
}

// Returns true if the input number is within the inclusive range of 0 to 9
func isDigit(glyph: Binding<String>) -> Bool {
    guard glyph.wrappedValue.count == 1,
          let character = glyph.wrappedValue.first,
          character.isNumber,
          let intValue = Int(String(character))
    else { return false }
    return (0...9).contains(intValue)
}
