//  Development.swift
//  Traces
//  Created by Dario Crippa on 23/02/25

import SwiftUI

// https://stackoverflow.com/questions/62063972/how-do-i-include-ios-app-icon-image-within-the-app-itself
extension Bundle {
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
}

// Retrieves the app version
// Tutorial : https://www.polpiella.dev/show-app-icon-and-version-in-a-swiftui-view
func getVersion(bundle : Bundle = .main) -> String {
    guard let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
        fatalError("Something went wrong while retrieving the app version 🔥")
    }
    return version
}

// Segments available in the details picker
private enum DetailSegment : String, CaseIterable {
    case illustrations
    case resources
}

struct Development: View {
    // DEFAULT selected segment in the picker is .settings
    @State private var selectedSegment : DetailSegment = .illustrations
    // Parsed data from the JSON files
    @State private var resources : [ParsedResource]?
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack(spacing: 0) {
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
                    .padding(10)
                }
                // App icon
                Bundle.main.iconFileName
                    .flatMap { UIImage(named: $0) }
                    .map { Image(uiImage: $0) }
                    .scaledToFit()
                    .frame(width: 76, height: 76)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Traces")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 5)
                Text("Version \(getVersion())")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(Color(.systemGray2))
                Text("Developed by Dario Crippa")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(Color(.systemGray2))
                    .padding(.bottom, 20)
                // Navigates the details popup subviews
                Picker(String(), selection: $selectedSegment) {
                    ForEach(DetailSegment.allCases, id: \.self) { segment in
                        Text(segment.rawValue.capitalized).tag(segment)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                
                Group {
                    switch selectedSegment {
                        case .illustrations:
                        Illustrations(parsedResource: $resources)
                    case .resources:
                        Resources(parsedResource: $resources)
                    }
                }
                .padding(.vertical, 10)
                Spacer()
            }
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(10)
            .shadow(color: Color(.systemGray4), radius: 4)
        }
        .frame(width: 380, height: 540)
        .onAppear {
            // Decodes the JSON files and initializes data when the Details view appears
            resources = parseResourcesJSON(fileName: "resources")
        }
    }
}
