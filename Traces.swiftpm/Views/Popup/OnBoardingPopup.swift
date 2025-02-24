//
//  SwiftUIView.swift
//  Traces
//
//  Created by Dario Crippa on 23/02/25.
//

import SwiftUI
import MijickPopups

struct OnBoardingPopup: CenterPopup {
    @State private var scale: CGFloat = 1.0
    @State private var hasBounced = false
    @State private var splashInformation: [SplashJSON]?
    @AppStorage("firstAppLaunch") private var firstAppLaunch: Bool = true
    var body: some View {
        ZStack {
            // Background
            Color(.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // Sheet content
            ZStack {
                // Inner white background
                Color(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                // Content
                VStack(spacing: 0) {
                    Image("hello")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .scaleEffect(scale)
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 20, trailing: 0))
                        .onAppear {
                            if !hasBounced {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.interpolatingSpring(mass: 0.13, stiffness: 17.95, damping: 1.2, initialVelocity: 10.0)) {
                                        scale = 1.3
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.interpolatingSpring(mass: 0.13, stiffness: 17.95, damping: 1.2, initialVelocity: 10.0)) {
                                            scale = 1.0
                                            hasBounced = true
                                        }
                                    }
                                }
                            }
                        }
                    Spacer()
                    List {
                        ForEach(splashInformation ?? [SplashJSON](), id: \.self) { splash in
                            HStack(alignment: .firstTextBaseline) {
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 7.5)
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(Color(.systemBlue).opacity(0.9))
                                    Image(systemName: splash.symbol)
                                        .foregroundStyle(Color(.white))
                                        .font(.system(size: 20))
                                }
                                .alignmentGuide(.firstTextBaseline) { dimension in dimension[VerticalAlignment.center] }
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack(alignment: .firstTextBaseline) {
                                        VStack(alignment: .leading, spacing: 0) {
                                            Text("\(splash.title)")
                                                .font(.headline)
                                                .bold()
                                            Text("\(splash.description)")
                                                .font(.system(size: 15))
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .multilineTextAlignment(.leading)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .contentMargins(.top, 0)
                    .contentMargins(.horizontal, 0.01)
                    .padding(.horizontal, 20)
                    Spacer()
                    Button(action: {
                        firstAppLaunch = false
                        Task { await OnBoardingPopup().dismissAllPopups() }
                    }) {
                        Text("Continue")
                            .padding(.horizontal, 40)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 10) // Added padding to match content spacing
                }
            }
            .background(Color(.white)) // Ensure background consistency
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(10) // Padding between gray and white boxes
            .shadow(color: Color(.systemGray4), radius: 4) // Shadow on white box
        }
        .frame(width: 380, height: 540)
        .onAppear {
            splashInformation = parseSplashJSON(fileName: "splash")
        }
    }
}

