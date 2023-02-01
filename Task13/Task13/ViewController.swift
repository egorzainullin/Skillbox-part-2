//
//  ViewController.swift
//  Task13
//
//  Created by Егор Зайнуллин on 01.02.2023.
//

import UIKit
import AVFoundation

class AssetStore {
    let video1: AVAsset
    
    let video2: AVAsset
    
    let video3: AVAsset
    
    let audio1: AVAsset
    
    let audio2: AVAsset
    
    init(video1: AVAsset, video2: AVAsset, video3: AVAsset, audio1: AVAsset, audio2: AVAsset) {
        self.video1 = video1
        self.video2 = video2
        self.video3 = video3
        self.audio1 = audio1
        self.audio2 = audio2
    }
    
    
    static func test() -> AssetStore {
        return AssetStore(video1: AssetStore.asset("video1", type: "mp4"),
                          video2: AssetStore.asset("video2", type: "mp4"),
                          video3: AssetStore.asset("video3", type: "mp4"),
                          audio1: AssetStore.asset("audio1", type: "mp3"),
                          audio2: AssetStore.asset("audio2", type: "mp3"))
    }
    
    static func asset(_ resource: String, type: String) -> AVAsset {
        guard let url = Bundle.main.url(forResource: resource, withExtension: type)
        else {
            fatalError("Can't find file \(resource) with this name")
        }
        return AVAsset(url: url)
    }
    
    func compose() -> AVAsset {
        let composition = AVMutableComposition()
        guard let videoTrack1 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else { fatalError() }
        guard let videoTrack2 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else { fatalError() }
        guard let videoTrack3 = composition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else { fatalError() }
        
        func insertVideo(asset: AVAsset, at: CMTime) {
            
        }
     
        return composition
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let assetStore = AssetStore.test()
        let video1Asset = assetStore.video1
        startPlaying(asset: video1Asset)
    }

    func startPlaying(asset: AVAsset) {
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
    }
}

