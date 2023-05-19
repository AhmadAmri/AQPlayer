//
//  AQPlayerStatus.swift
//  AQPlayer
//
//  Created by Ahmad Amri on 3/11/19.
//  Copyright © 2019 Amri. All rights reserved.
//

import Foundation

public enum AQPlayerStatus: Int {
    case none
    case loading
    case failed
    case readyToPlay
    case playing
    case paused
}
