//  Resources.swift
//  Traces
//  Created by Dario Crippa on 23/02/25

import SwiftUI

struct Resources: View {
    // Resource information extracted from 'resources.json'
    @Binding var parsedResource : [ResourceJSON]?
    
    var body: some View {
        List {
            ForEach(Array((parsedResource ?? [ResourceJSON]()).enumerated()), id: \.element) { index, resource in
                if index != 2 {
                    // Renders an SF Symbol with a rounded rectangle as its background
                    HStack(alignment: .firstTextBaseline) {
                        ZStack(alignment: .center) {
                            if index == 0 {
                                RoundedRectangle(cornerRadius: 7.5)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color("packageBrown"))
                                Image(systemName: "shippingbox.fill")
                                    .foregroundStyle(Color(.white))
                                    .font(.system(size: 20, weight: .regular))
                            }
                            else if index == 1 {
                                RoundedRectangle(cornerRadius: 7.5)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color("fontGray"))
                                Image(systemName: "loupe")
                                    .foregroundStyle(Color(.white))
                                    .font(.system(size: 20, weight: .regular))
                            }
                        }
                        .alignmentGuide(.firstTextBaseline) { dimension in dimension[VerticalAlignment.center] }
                        // Information about the fonts and the third-party packages
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .firstTextBaseline) {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("\(resource.name)")
                                        .font(.system(size: 17, weight: .bold))
                                    Text("by \(resource.source)")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(Color(.systemGray2))
                                }
                                Spacer()
                            }
                            Text("\(resource.description)")
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
