//  Resources.swift
//  Traces
//  Created by Dario Crippa on 23/02/25.

import SwiftUI

struct Resources: View {
    @Binding var parsedResource : [ParsedResource]?
    var body: some View {
        List {
            ForEach(Array((parsedResource ?? [ParsedResource]()).enumerated()), id: \.element) { index, resource in
                if index != 2 {
                    // SF Symbol with a rounded rectangle background
                    HStack(alignment: .firstTextBaseline) {
                        ZStack(alignment: .center) {
                            if index == 0 {
                                RoundedRectangle(cornerRadius: 7.5)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color("packageBrown"))
                                Image(systemName: "shippingbox.fill")
                                    .foregroundStyle(Color(.white))
                                    .font(.system(size: 20))
                            }
                            else if index == 1 {
                                RoundedRectangle(cornerRadius: 7.5)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color("fontGray"))
                                Image(systemName: "loupe")
                                    .foregroundStyle(Color(.white))
                                    .font(.system(size: 20))
                            }
                        }
                        .alignmentGuide(.firstTextBaseline) { dimension in dimension[VerticalAlignment.center] }
                        // Information about the font
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .firstTextBaseline) {
                                // Name and author
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(resource.name)")
                                        .font(.headline)
                                        .bold()
                                    Text("by \(resource.source)")
                                        .font(.caption)
                                        .bold()
                                        .foregroundStyle(Color(.systemGray2))
                                }
                                Spacer()
                            }
                            // Description
                            Text("\(resource.description)")
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
