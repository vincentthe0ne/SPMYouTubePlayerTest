//
//  SimpleYouTubeTestApp.swift
//  SimpleYouTubeTest
//
//  Created by Marcel on 05.03.21.
//

import SwiftUI

@main
struct SimpleYouTubeTestApp: App {
    let youTubeState: YoutubeControlState = YoutubeControlState()
    var body: some Scene {
        WindowGroup {
            ContentView(videoID: "xcJtL7QggTI")
                .environmentObject(youTubeState)
        }
    }
}
