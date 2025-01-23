//
//  MusicObservable.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/13.
//

import Foundation
//import SwiftUICore
//import _SwiftData_SwiftUI
//import SwiftData

class AudioPlay: ObservableObject {
//    @Environment(\.modelContext) private var modelContext
//    @Query var allPlayList: [ModelPlaylist] = []
    
    func play(allPlayList: [ModelPlaylist]) {
        print("用户点击play:")
        for pl in allPlayList {
            print("ID: \(pl.id.uuidString), 名称: \(pl.name), 年龄: \(pl.createTime)")
        }
    }
}
