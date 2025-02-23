// Research.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import PDFKit
import MijickPopups

struct Research: View {
    // Research information parsed from the file : handwriting.json
    @Binding var researchContent: [ParsedParagraph]?
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .center, spacing: 60) {
                Spacer()
                ZStack {
                    // Background
                    Color(.systemGray6)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    // Visualizes the research information
                    ResearchInformation(paragraphs: $researchContent)
                        .background(
                            Color.white
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: Color(.systemGray4), radius: 4)
                        )
                        .padding(10)
                }
                .frame(maxWidth: 550, maxHeight: 650)
                // Illustration
                Image("Kid")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Spacer()
                        // Sheet close button
                        Button(action: {
                            
                        }) {
                            Image(systemName: "info.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(Color(.systemBlue))
                                .font(.system(.title3))
                        }
                    }
                }
            }
        }
    }
}

struct ResearchInformation: View {
    
    @Binding var paragraphs: [ParsedParagraph]?
    
    var body: some View {
        let content = paragraphs ?? [ParsedParagraph()]
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(Array(content.enumerated()), id: \.element) { index, paragraph in
                    // Paragraph information
                    Text(paragraph.title)
                        .font(.system(size: 20, weight: .bold))
                    Text(paragraph.content)
                        .font(.system(size: 17, weight: .regular))
                    if index == 0 {
                        // Visualizes the details of the research paper [ author : Karin H.James ]
                        Button(action: {
                            print("Tap")
                        }) {
                            HStack(alignment: .center, spacing: 16) {
                                // Title and author of the paper
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("The Importance of Handwriting Experience on the Development of the Literate Brain")
                                        .font(.system(size: 15, weight: .semibold))
                                    Text("Karin H. James")
                                        .font(.system(size: 13, weight: .regular))
                                }
                                .multilineTextAlignment(.leading)
                                Spacer()
                                // Information about the file
                                VStack {
                                    Image(systemName: "text.document.fill")
                                    Text("PDF")
                                        .font(.system(size: 13, weight: .bold))
                                }
                            }
                            .padding()
                            .background {
                                Color(.systemBlue).opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .foregroundStyle(Color(.systemBlue))
                            .padding(.vertical, 10)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
