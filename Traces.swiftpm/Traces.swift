// Traces.swift
// Traces
// Created by Dario Crippa on 17/02/25

import SwiftUI
import MijickPopups

@main
struct Traces: App {
    // UserDefaults : first app launch
    @AppStorage("firstAppLaunch") private var firstAppLaunch: Bool = true
    
    var body: some Scene {
        // Loads the custom font and registers it for use throughout the app
        let playwriteURL = Bundle.main.url(forResource: "Playwrite", withExtension: "ttf")! as CFURL
        let _ = CTFontManagerRegisterFontsForURL(playwriteURL, CTFontManagerScope.process, nil)
        
        WindowGroup {
            Main()
                .preferredColorScheme(.light)
                // Initializes custom [center] popups based on the MijickPopups framework
                .registerPopups(id: .shared) { popupConfiguration in
                    popupConfiguration
                        .center { $0
                            .backgroundColor(.clear)
                            .tapOutsideToDismissPopup(false)
                            .overlayColor(Color(.black).opacity(0.85))
                        }
                }
                .onAppear {
                    // Renders the OnBoarding view if it's the application's first launch
                    if firstAppLaunch { Task { await OnBoardingPopup().present() }}
                }
        }
    }
}

