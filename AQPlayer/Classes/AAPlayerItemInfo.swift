//
//  AQPlayerItemInfo.swift
//  AQPlayer
//
//  Created by Ahmad Amri on 3/13/19.
//  Copyright © 2019 Amri. All rights reserved.
//

public class AQPlayerItemInfo: Equatable {
    public var id: Int!
    public var url: URL!
    public var title: String!
    public var albumTitle: String!
    public var coverImage: UIImage!
    public var startAt: TimeInterval!
    
    public init(id: Int!, url: URL!, title: String!, albumTitle: String!, coverImageURL: String!, startAt: TimeInterval!) {
        self.id = id
        self.url = url
        self.title = title
        self.albumTitle = albumTitle
        
        if let urlStr = coverImageURL, let url = URL(string: urlStr) {
            DispatchQueue.global().async {
                if let data = try? Data( contentsOf:url)
                {
                    DispatchQueue.main.async {
                        self.coverImage = UIImage(data: data)
                    }
                }
            }
        }
        
        self.startAt = startAt
    }
    
    public init(id: Int!, url: URL!, title: String!, albumTitle: String!, coverImage: UIImage!, startAt: TimeInterval!) {
        self.id = id
        self.url = url
        self.title = title
        self.albumTitle = albumTitle
        self.coverImage = coverImage
        self.startAt = startAt
    }
    
    public static func == (lhs: AQPlayerItemInfo, rhs: AQPlayerItemInfo) -> Bool {
        return lhs.id == rhs.id || lhs.url == rhs.url
    }
}
