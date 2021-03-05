//
//  ContentView.swift
//  SimpleYouTubeTest
//
//  Created by Marcel on 05.03.21.
//

import SwiftUI

struct ContentView: View {
    var videoID: String
    @EnvironmentObject var state: YoutubeControlState

    var body: some View {
        YoutubePlayer(state)
            .onAppear(perform: {
                self.state.videoID = videoID
            })
            .frame(width: .infinity, height: 400)
            .background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(videoID: "xcJtL7QggTI")
            .environmentObject(YoutubeControlState())
    }
}
