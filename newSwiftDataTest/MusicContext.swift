//
//  MusicContext.swift
//  MyTest
//
//  Created by QIAEN on 2024/12/12.
//

import Foundation
import SwiftData
@Model
final class ModelPlaylist {
    // 1 reverse 2 forward
//    @Published var orderType = 1
    
    var id: UUID
    var type: Int
    var name: String
    var cover: String
    var createTime: Date
    var musics = [ModelMusicList]()
    
    init (id: UUID = UUID(), type: Int = 1, name: String, cover: String = "cover", createTime: Date = .now, musics: [ModelMusicList]) {
        self.id = id
        self.type = type
        self.name = name
        self.cover = cover
        self.createTime = createTime
        self.musics = musics
    }
    
    static var all: FetchDescriptor<ModelPlaylist> {
        // .reverse 倒叙，.forward 正序，先创建的在上面
        FetchDescriptor(sortBy: [SortDescriptor(\ModelPlaylist.createTime, order: .reverse)])
    }
}

@Model
final class ModelMusicList {
    var id: UUID
    var name: String
    var cover: String
    var author: String
    var suffix: String
    var createTime: Date
    var lastPlayTime: Date
    var playTimes: Int
    var isFavorite: Bool
    // name, suffix 必须
    init(id: UUID = UUID(), name: String, cover: String = "cover", author: String = "蒙面", suffix: String = "mp3", createTime: Date = .now, lastPlayTime: Date = .now, playTimes: Int = 0, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.cover = cover
        self.author = author
        self.suffix = suffix
        self.createTime = createTime
        self.lastPlayTime = lastPlayTime
        self.playTimes = playTimes
        self.isFavorite = isFavorite
    }
}
