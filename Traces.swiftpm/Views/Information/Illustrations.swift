//  Illustrations.swift
//  Traces
//  Created by Dario Crippa on 23/02/25.

import SwiftUI

struct Illustrations: View {
    @Binding var parsedResource : [ParsedResource]?
    var body: some View {
        List {
            ForEach(Array((parsedResource ?? [ParsedResource]()).enumerated()), id: \.element) { index, illustration in
                if index == 2 {
                    // SF Symbol with a rounded rectangle background
                    HStack(alignment: .firstTextBaseline) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 7.5)
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color(.systemBlue).opacity(0.9))
                            Image(systemName: "photo.on.rectangle.angled")
                                .foregroundStyle(Color(.white))
                                .font(.system(size: 20))
                        }
                        .alignmentGuide(.firstTextBaseline) { dimension in dimension[VerticalAlignment.center] }
                        // Information about the font
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .firstTextBaseline) {
                                // Name and author
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(illustration.name)")
                                        .font(.headline)
                                        .bold()
                                    Text("made with \(illustration.source)")
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(Color(.systemGray2))
                                }
                                Spacer()
                            }
                            // Description
                            Text("\(illustration.description)")
                                .font(.system(size: 15))
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
        .contentMargins(.top, 0)
        .contentMargins(.horizontal, 0.01)
    }
}

