//
//  VideoPlayerView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: VideoPlayerViewModel
    
    var player: AVPlayer?
    
    init(course: Course) {
        self._viewModel = StateObject(wrappedValue: VideoPlayerViewModel(course: course))
        self.player = AVPlayer(url: .init(string: course.video)!)
    }
        
    var body: some View {
        ZStack {
            VideoPlayer(player: self.player)
                .onAppear {
                    setVideoDuration()
                    setVideoStartTime()
                    addObserverForVideoCompletion()
                }
                .edgesIgnoringSafeArea(.all)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                        }
                    }
                }
                .onDisappear {
                    if let player {
                        viewModel.setVideoCurrentTimeForCourse(currentTime: player.currentTime().seconds)
                    }
                    removeObserverForVideoCompletion()
                }
        }
    }
    
    private func setVideoDuration() {
        Task {
            if let duration = try await player?.currentItem?.asset.load(.duration) {
                viewModel.setVideoDurationForCourse(duration: CMTimeGetSeconds(duration)) 
            }
        }
    }
    
    private func setVideoStartTime() {
        if viewModel.lastVideoTime != 0.0 {
            let time = CMTime(seconds: viewModel.lastVideoTime, preferredTimescale: 600)
            player?.seek(to: time) { _ in
                player?.play()
            }
        } else {
            player?.play()
        }
    }
    
    private func addObserverForVideoCompletion() {
         NotificationCenter.default.addObserver(
             forName: .AVPlayerItemDidPlayToEndTime,
             object: player?.currentItem,
             queue: .main) { _ in
                 viewModel.isVideoFinished.toggle()
         }
     }
     
     private func removeObserverForVideoCompletion() {
         NotificationCenter.default.removeObserver(
             self,
             name: .AVPlayerItemDidPlayToEndTime,
             object: player?.currentItem
         )
     }
}

#Preview {
    VideoPlayerView(course: .example)
}
