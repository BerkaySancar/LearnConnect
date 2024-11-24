//
//  VideoPlayerView.swift
//  LearnConnect
//
//  Created by Berkay Sancar on 24.11.2024.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    
    let videoURL: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VideoPlayer(player: AVPlayer(url: URL(string: videoURL)!))
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
        }
    }
}

#Preview {
    VideoPlayerView(videoURL: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
}
