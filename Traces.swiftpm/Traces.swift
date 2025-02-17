// Traces.swift :
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI

@main
struct Traces: App {
    var body: some Scene {
        // Loads and applies custom font to the app
        let playwriteURL = Bundle.main.url(forResource: "Playwrite", withExtension: "ttf")! as CFURL
        let _ = CTFontManagerRegisterFontsForURL(playwriteURL, CTFontManagerScope.process, nil)
        WindowGroup {
            Main()
        }
    }
}
