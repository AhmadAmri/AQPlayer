//
//  AQQueuePlayer.swift
//  AQPlayer
//
//  Created by Ahmad Amri on 3/11/19.
//  Copyright © 2019 Amri. All rights reserved.
//

import Foundation
import AVFoundation

class AQQueuePlayer: AVQueuePlayer {
    var currentIndex: Int! {
        if let item = self.currentItem as? AQPlayerItem {
            return item.index
        }
        return nil
    }
}

extension AVQueuePlayer {
    func goTo(index: Int, with initialItems: [AVPlayerItem]) {
        self.removeAllItems()
        let newItems = initialItems.dropFirst(index)
        for item in newItems {
            if self.canInsert(item, after: nil) {
                self.insert(item, after: nil)
            }
        }
    }
}
