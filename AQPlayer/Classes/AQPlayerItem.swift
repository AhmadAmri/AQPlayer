//
//  AQPlayerItem.swift
//  AQPlayer
//
//  Created by Ahmad Amri on 3/11/19.
//  Copyright © 2019 Amri. All rights reserved.
//

import Foundation
import AVFoundation

class AQPlayerItem: AVPlayerItem {
    var index: Int!
    var itemInfo: AQPlayerItemInfo!
    
    init(asset: AVAsset, index: Int, itemInfo: AQPlayerItemInfo! = nil) {
        super.init(asset: asset, automaticallyLoadedAssetKeys: nil)
        if let startAt = itemInfo.startAt {
            super.seek(to: CMTime(seconds: startAt , preferredTimescale: Defaults.preferredTimescale), completionHandler: nil)
        }
        self.index = index
        self.itemInfo = itemInfo
    }
}

