// Research.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import PDFKit
import MijickPopups

struct Research: View {
    // Parsed letters of the alphabet
    @Binding var paragraphs: [ParsedParagraph]?
    
    var body: some View {
        HStack(alignment: .center, spacing: 80) {
            Spacer()
            ZStack {
                Color(.systemGray6)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                VStack {
                    ResearchInformation(paragraphs: $paragraphs)
                        .background(
                            Color.white
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: Color(.systemGray4), radius: 4)
                        )
                }
                .padding(10)
            }
            .frame(maxWidth: 550, maxHeight: 600)
            
            // Illustration
            Image("Handwriting")
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            Spacer()
        }
    }
}

struct ResearchInformation: View {
    @Binding var paragraphs: [ParsedParagraph]?
    
    var body: some View {
        let firstParagraph = paragraphs?.first ?? ParsedParagraph()
        return ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text(firstParagraph.paragraph)
                    .font(.system(size: 20, weight: .semibold))
                Text(firstParagraph.content)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.bottom, 10)
                Button(action: {
                    Task {
                        await PDFPopup().present()
                    }
                }, label: {
                    HStack {
                        Label {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("The Importance of Handwriting Experience on the Development of the Literate Brain")
                                    .font(.headline)
                                    .bold()
                                Text("Karin H. James")
                                    .font(.subheadline)
                            }
                        } icon: {
                            Image(systemName: "text.document.fill")
                        }
                        Spacer()
                    }
                })
                .buttonStyle(.bordered)
                .tint(Color(.systemBlue))
                .padding(.vertical, 10)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PDFViewer: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFKit.PDFView {
        let pdfView = PDFKit.PDFView()
        pdfView.autoScales = true
        
        if let document = PDFDocument(url: url) {
            pdfView.document = document
            print("PDF loaded successfully from: \(url)")
        } else {
            print("Error: Unable to load PDF from URL: \(url)")
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFKit.PDFView, context: Context) {
        // Handle updates if needed
    }
}

struct PDFPopup: CenterPopup {
    var body: some View {
        PDFContentView()
    }
}

struct PDFContentView: View {
    var body: some View {
        PDFViewer(url: Bundle.main.url(forResource: "handwriting_importance", withExtension: "pdf")!)
            .frame(width: 640, height: 540)
    }
}
