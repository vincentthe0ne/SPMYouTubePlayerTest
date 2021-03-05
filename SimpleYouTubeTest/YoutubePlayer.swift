//
//  YoutubePlayer.swift
//  
//
//  Created by Marcel on 03.03.21.
//

import SwiftUI
import SwiftUIX
import YouTubePlayer

struct YoutubePlayer: AppKitOrUIKitViewRepresentable {

    typealias UIViewType = YouTubePlayerView

    @ObservedObject var controlState: YoutubeControlState

    init(_ state: YoutubeControlState) {
        self.controlState = state
    }

    func makeAppKitOrUIKitView(context: Context) -> YouTubePlayerView {
        // for a full documentation of the possible parameters see: https://developers.google.com/youtube/player_parameters.html?playerVersion=HTML5#Parameters
        // 'controls'           - Show Controls, player will be loaded when user starts playback
        // 'fs'                 - Disable "Fullscreen"-Option
        // 'hl'                 - Language setting for the player
        // 'iv_load_policy'     - Disable Video notes
        // 'modestbranding'     - Disable YouTube Logo instead a small label will be shown when paused
        // 'rel'                - Disable playback of similar videos
        // 'playsinline'        - Disable fullscreen mode when played on iOS Devices
        let playerVars = [
            "controls": "2",
            "fs": "0",
            "hl": Locale.current.languageCode ?? "en",
            "iv_load_policy": "3",
            "modestbranding": "1",
            "rel" : "0",
            "playsinline": "1"
        ] as YouTubePlayerView.YouTubePlayerParameters

        let playerView = YouTubePlayerView()

        playerView.playerVars = playerVars
        playerView.delegate = context.coordinator
        return playerView
    }

    func updateAppKitOrUIKitView(_ view: YouTubePlayerView, context: Context) {
        guard let videoID = controlState.videoID else { return }

        if !(controlState.executeCommand == .idle) && view.ready {

            controlState.executeCommand = .idle
            switch controlState.executeCommand {
            case .loadNewVideo:
                view.loadPlaylistID(videoID)
            case .play:
                view.play()
            case .pause:
                view.pause()
            case .stop:
                view.stop()
            case .idle:
                // Nothing to do
                break
            }
        } else if !view.ready {
            view.loadVideoID(videoID)
        }
    }

    class Coordinator: YouTubePlayerDelegate {

        @ObservedObject var controlState: YoutubeControlState

        init(_ playerState: YoutubeControlState) {
            self.controlState = playerState
        }

        func playerReady(_ videoPlayer: YouTubePlayerView) {
            videoPlayer.play()
            controlState.videoState = .play
        }

        func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
            switch playerState {
            case .Playing:
                controlState.videoState = .play
            case .Paused, .Buffering, .Unstarted:
                controlState.videoState = .pause
            case .Ended:
                controlState.videoState = .stop
            default:
                // Unsupported
                break
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(controlState)
    }
}
