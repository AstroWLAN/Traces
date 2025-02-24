//  OnBoardingPopup.swift
//  Traces
//  Created by Dario Crippa on 23/02/25

import SwiftUI
import MijickPopups

struct OnBoardingPopup: CenterPopup {
    // UserDefaults : first app launch
    @AppStorage("firstAppLaunch") private var firstAppLaunch: Bool = true
    
    // 'Hello' text scaling factor for pulse animation
    @State private var scale: CGFloat = 1.0
    @State private var hasPulsed: Bool = false
    // Splash screen information extracted from 'splash.json'
    @State private var splashInformation: [SplashJSON]?
    
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            ZStack {
                VStack(spacing: 0) {
                    Image("hello")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .scaleEffect(scale)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 20, trailing: 0))
                        .onAppear {
                            if !hasPulsed {
                                // Applies the pulse animation
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    withAnimation(.easeInOut(duration: 0.6)) { scale = 1.2 }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            scale = 1.0
                                            hasPulsed = true
                                        }
                                    }
                                }
                            }
                        }
                    Spacer()
                    GeometryReader { geometry in
                        List {
                            // Splash information
                            ForEach(splashInformation ?? [SplashJSON](), id: \.self) { splash in
                                HStack(alignment: .top, spacing: 16) {
                                    ZStack(alignment: .center) {
                                        RoundedRectangle(cornerRadius: 7.5)
                                            .frame(width: 32, height: 32)
                                            .foregroundStyle(Color(.systemBlue).opacity(0.2))
                                        Image(systemName: splash.symbol)
                                            .foregroundStyle(Color(.systemBlue))
                                            .font(.system(size: 20, weight: .regular))
                                    }
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text(splash.title)
                                            .font(.system(size: 17, weight: .bold))
                                        Text(splash.description)
                                            .font(.system(size: 15, weight: .regular))
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 10, leading: 360 - geometry.size.width + 40, bottom: 10, trailing: 360 - geometry.size.width + 40))
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                    }
                    Spacer()
                    Button(action: {
                        firstAppLaunch = false
                        Task { await dismissAllPopups() }
                    }) {
                        Text("Continue")
                            .font(.system(size: 17, weight: .semibold))
                            .padding(.horizontal, 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 10)
                }
            }
            .background(Color(.white))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(10)
            .shadow(color: Color(.systemGray4), radius: 4)
        }
        .frame(width: 380, height: 540)
        .onAppear {
            splashInformation = parseSplashJSON(fileName: "splash")
        }
    }
}
