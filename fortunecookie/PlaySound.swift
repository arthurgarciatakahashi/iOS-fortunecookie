//
//  PlaySound.swift
//  fortunecookie
//
//  Created by arthur takahashi on 25/08/20.
//  Copyright © 2020 Arthur Takahashi. All rights reserved.
//

import Foundation
import AVFoundation

var soundEffect: AVAudioPlayer?

func playSound(name: String, fileType: String) {
    if let path = Bundle.main.path(forResource: name, ofType: fileType) {
        do {
            soundEffect = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            soundEffect?.play()
        } catch {
            print("Could not load the audio failed")
        }
    }
}
