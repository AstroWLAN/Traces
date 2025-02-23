//  PDFSheet.swift
//  Traces
//  Created by Dario Crippa on 22/02/25

import SwiftUI
import PDFKit

struct PDFSheet: View {
    var body: some View {
        ZStack {
            Color(.systemGray6)
            PDFVisualizer(url: Bundle.main.url(forResource: "handwriting_importance", withExtension: "pdf")!)
            VStack {
                HStack {
                    Spacer()
                    // Sheet close button
                    Button(action: {
                        Task { await dismissAllPopups() }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color(.systemBlue))
                            .font(.system(.title2))
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
    
    let url: URL
    let zoomLevel: CGFloat = 0.9

    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.autoScales = false
        
        if let document = PDFDocument(url: url) {
            pdfView.document = document
            pdfView.scaleFactor = zoomLevel
        } else {
            debugPrint("Unable to load the requested PDF 🔥")
        }
        
        // Hides scroll indicators
        if let scrollView = pdfView.subviews.compactMap({ $0 as? UIScrollView }).first {
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}
