//  PDFPopup.swift
//  Traces
//  Created by Dario Crippa on 22/02/25

import SwiftUI
import PDFKit
import MijickPopups

struct PDFPopup: CenterPopup {
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
            // PDF visualizer
            PDFVisualizer(url: Bundle.main.url(forResource: "handwriting_importance", withExtension: "pdf")!)
            VStack {
                HStack {
                    Spacer()
                    // Dismisses the PDFPopup
                    Button(action: { Task { await dismissAllPopups() }}) {
                        // Dismiss popup button
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color(.systemBlue))
                            .font(.system(size: 22, weight: .regular))
                    }
                }
                .padding(10)
                Spacer()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(width: 800, height: 640)
    }
}

struct PDFVisualizer: UIViewRepresentable {
    
    // PDF URL
    let url: URL
    // PDF initial zoom level
    let zoomLevel: CGFloat = 0.9
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        
        let PDF = PDFKit.PDFView()
        PDF.autoScales = false
        
        // Retrieves the document
        if let document = PDFDocument(url: url) {
            PDF.document = document
            PDF.scaleFactor = zoomLevel
        } else {
            debugPrint("Something went wrong with the PDF loading process 🔥")
        }
        
        // Hides scroll indicators
        if let scrollView = PDF.subviews.compactMap({ $0 as? UIScrollView }).first {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
        }
        
        return PDF
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) { }
}
