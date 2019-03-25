//
//  AQPlayerDelegate.swift
//  AQPlayer
//
//  Created by Ahmad Amri on 3/11/19.
//  Copyright © 2019 Amri. All rights reserved.
//

import Foundation

public protocol AQPlayerDelegate {
    func aQPlayerManager(_ playerManager: AQPlayerManager, progressDidUpdate percentage: Double)
    func aQPlayerManager(_ playerManager: AQPlayerManager, itemDidChange itemIndex: Int)
    func aQPlayerManager(_ playerManager: AQPlayerManager, statusDidChange status: AQPlayerStatus)
    
    func getCoverImage(_ player: AQPlayerManager, _ callBack: @escaping (_ coverImage: UIImage?) -> Void)
}
