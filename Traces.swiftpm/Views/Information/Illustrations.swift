//  Illustrations.swift
//  Traces
//  Created by Dario Crippa on 23/02/25

import SwiftUI

struct Illustrations: View {
    // Resource information extracted from 'resources.json'
    @Binding var parsedResource : [ResourceJSON]?
    
    var body: some View {
        List {
            ForEach(Array((parsedResource ?? [ResourceJSON]()).enumerated()), id: \.element) { index, illustrations in
                if index == 2 {
                    // Renders an SF Symbol with a rounded rectangle as its background
                    HStack(alignment: .top, spacing: 10) {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 7.5)
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color(.systemBlue).opacity(0.9))
                            Image(systemName: "photo")
                                .foregroundStyle(Color(.white).opacity(0.75))
                                .font(.system(size: 20, weight: .regular))
                        }
                        // Illustration informations
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(illustrations.name)")
                                .font(.system(size: 17, weight: .bold))
                            Text("made with \(illustrations.source)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color(.systemGray2))
                                .padding(.bottom, 5)
                            Text("\(illustrations.description)")
                                .font(.system(size: 15, weight: .regular))
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
    }
}

