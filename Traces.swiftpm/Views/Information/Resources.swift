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
                    HStack(alignment: .top, spacing: 10) {
                        ZStack(alignment: .center) {
                            if index == 0 {
                                RoundedRectangle(cornerRadius: 7.5)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color("packageBrown"))
                                Image(systemName: "shippingbox.fill")
                                    .foregroundStyle(Color(.white).opacity(0.75))
                                    .font(.system(size: 20, weight: .regular))
                            } else if index == 1 {
                                RoundedRectangle(cornerRadius: 7.5)
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(Color("fontGray"))
                                Image(systemName: "loupe")
                                    .foregroundStyle(Color(.white).opacity(0.75))
                                    .font(.system(size: 20, weight: .regular))
                            }
                        }
                        // Resource informations
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(resource.name)")
                                .font(.system(size: 17, weight: .bold))
                            Text("made with \(resource.source)")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color(.systemGray2))
                                .padding(.bottom, 5)
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
