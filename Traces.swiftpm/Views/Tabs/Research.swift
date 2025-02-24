// Research.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import PDFKit
import MijickPopups

struct Research: CenterPopup {
    // Research information extracted from 'handwriting.json'
    @Binding var research: [ResearchParagraphJSON]?
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .center, spacing: 60) {
                Spacer()
                ZStack {
                    // Kid illustrations
                    Image("KidLeft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280)
                        .offset(x: -300)
                    Image("KidRight")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280)
                        .offset(x: +300)
                    // Background
                    Color(.systemGray6)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    // Visualizes the research information
                    ResearchInformation(researchParagraphs: $research)
                        .background(
                            Color.white
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: Color(.systemGray4), radius: 4)
                        )
                        .padding(10)
                }
                .frame(maxWidth: 550, maxHeight: 650)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Spacer()
                        Button(action: {
                            // Presents the DevelopmentPopup
                            Task { await DevelopmentPopup().present() }
                        }) {
                            Image(systemName: "info.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(Color(.systemBlue))
                                .font(.system(size: 22, weight: .regular))
                        }
                    }
                }
            }
        }
    }
}

struct ResearchInformation: View {
    
    // Research information extracted from 'handwriting.json'
    @Binding var researchParagraphs: [ResearchParagraphJSON]?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(Array((researchParagraphs ?? [ResearchParagraphJSON()]).enumerated()), id: \.element) { index, paragraph in
                    // Title
                    Text(paragraph.title)
                        .font(.system(size: 20, weight: .bold))
                        .padding([.horizontal, .top], 16)
                    // Content
                    Text(paragraph.content)
                        .font(.system(size: 17, weight: .regular))
                        .padding(.horizontal, 16)
                    if index == 0 {
                        Button(action: {
                            // Visualizes the paper
                            Task { await PDFPopup().present() }
                        }) {
                            // Paper information
                            HStack(alignment: .center, spacing: 16) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("The Importance of Handwriting Experience on the Development of the Literate Brain")
                                        .font(.system(size: 15, weight: .semibold))
                                    Text("Karin H. James")
                                        .font(.system(size: 13, weight: .regular))
                                }
                                .multilineTextAlignment(.leading)
                                Spacer()
                                VStack {
                                    Image(systemName: "text.document.fill")
                                    Text("PDF")
                                        .font(.system(size: 13, weight: .bold))
                                }
                            }
                            .padding(16)
                            .background {
                                Color(.systemBlue).opacity(0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            .foregroundStyle(Color(.systemBlue))
                            .padding(.top, 10)
                            .padding(.bottom, -6)
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

