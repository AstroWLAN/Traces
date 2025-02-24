//  Development.swift
//  Traces
//  Created by Dario Crippa on 23/02/25

import SwiftUI
import MijickPopups

// Retrieves the app icon from the assets
// Based on the answer: https://stackoverflow.com/questions/62063972/how-do-i-include-ios-app-icon-image-within-the-app-itself
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
// Based on the tutorial: https://www.polpiella.dev/show-app-icon-and-version-in-a-swiftui-view
func getVersion(bundle : Bundle = .main) -> String {
    guard let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
        fatalError("Something went wrong while retrieving the app version 🔥")
    }
    return version
}

// Lists the segments available in the development picker
private enum DevelopmentSegment : String, CaseIterable {
    case illustrations
    case resources
}

struct DevelopmentPopup: CenterPopup {
    // Sets .illustrations as the default selected segment in the picker
    @State private var selectedSegment : DevelopmentSegment = .illustrations
    // Resource information extracted from 'resources.json'
    @State private var resources : [ResourceJSON]?
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    // Dismesses the DevelopmentPopup
                    Button(action: { Task { await dismissAllPopups() }}) {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(Color(.systemBlue))
                            .font(.system(size: 22, weight: .regular))
                    }
                    .padding(10)
                }
                // Visualizes the app information
                Bundle.main.iconFileName
                    .flatMap { UIImage(named: $0) }
                    .map { Image(uiImage: $0) }
                    .scaledToFit()
                    .frame(width: 76, height: 76)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                Text("Traces")
                    .font(.system(size: 34, weight: .bold))
                    .padding(.bottom, 5)
                Text("Version \(getVersion())")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color(.systemGray2))
                Text("Developed by Dario Crippa")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color(.systemGray2))
                    .padding(.bottom, 20)
                // Navigates through the subviews of the details popup
                Picker(String(), selection: $selectedSegment) {
                    ForEach(DevelopmentSegment.allCases, id: \.self) { segment in
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
            // Reads and processes the resource information from the 'resources.json' file
            resources = parseResourcesJSON(fileName: "resources")
        }
    }
}
