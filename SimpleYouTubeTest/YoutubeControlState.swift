//
//  YoutubeControlState.swift
//  
//
//  Created by Marcel on 03.03.21.
//

import Foundation

class YoutubeControlState: ObservableObject {

    enum PlayerCommand {
        case loadNewVideo
        case play
        case pause
        case stop
        case idle
    }

    @Published var videoID: String? {
        didSet {
            self.executeCommand = .loadNewVideo
        }
    }

    @Published var executeCommand: PlayerCommand = .idle

    @Published var videoState: PlayerCommand = .loadNewVideo

    func playPauseButtonTapped() {
        if videoState == .play {
            pauseVideo()
        } else if videoState == .pause {
            playVideo()
        } else {
            print("Unknown player state, attempting playing")
            playVideo()
        }
    }

    func playVideo() {
        executeCommand = .play
    }

    func pauseVideo() {
        executeCommand = .pause
    }
}
