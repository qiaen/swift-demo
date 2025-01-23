//
//  PickFiles.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/26.
//

import SwiftUI
import UniformTypeIdentifiers
import AVFoundation
import Foundation

struct importMusicInfo {
    var id = UUID()
    var cover: String
    var author: String
    var name: String
    var suffix: String
    var fileName: String
}

let utilDirectory = FileManager.default.urls(for:.documentDirectory, in:.userDomainMask).first!
// 判断本地是否储存过文件
func utilIsHasFile(name: String) -> Bool {
//    print("读取文件时：dom====start")
    let fileManager = FileManager.default
    let fileURL = utilDirectory.appendingPathComponent(name)
    let hasFile = fileManager.fileExists(atPath: fileURL.path)
//    print("读取文件时：dom====end")
    return hasFile
}

// 写入文件
func copyFile2Documents(from sourceURL: URL) {
    let folderName = "Documents"
    let folderURL = utilDirectory.appendingPathComponent(folderName)
    // 检查文件夹是否存在，如果不存在则创建
    if !FileManager.default.fileExists(atPath: folderURL.path) {
        do {
            try FileManager.default.createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
            print("文件夹已创建: \(folderURL)")
            
        } catch {
            print("创建文件夹失败: \(error.localizedDescription)")
            return
        }
    } else {
        print("文件夹已存在: \(folderURL)")
    }
    let fileManager = FileManager.default
    let destinationURL = folderURL.appendingPathComponent(sourceURL.lastPathComponent)
    
    if FileManager.default.fileExists(atPath: destinationURL.path) {
        do {
            try FileManager.default.removeItem(at: destinationURL)
            print("Existing file deleted: \(destinationURL)")
        } catch {
            print("Error deleting existing file: \(error.localizedDescription)")
            return
        }
    }
    
    do {
        try fileManager.copyItem(at: sourceURL, to: destinationURL)
        print("File saved to documents directory: \(destinationURL)")
    } catch {
        
        print("Error saving file: \(error.localizedDescription)")
    }
}
// 去除字符串首尾空格
func trimWhitespace(from input: String) -> String {
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
}
// 使用-分割字符串
func splitString(from input: String) -> (author: String, name: String) {
    let arrayString = input.components(separatedBy: "-")
    if arrayString.count == 1 {
        return ("", trimWhitespace(from: arrayString[0]))
    } else {
        return (trimWhitespace(from: arrayString[0]), trimWhitespace(from: arrayString[1]))
    }
}

func backMusicBaseInfo(url: URL) -> importMusicInfo {
    let pc = url.lastPathComponent
    let pe = url.pathExtension
    let fn = pc.replacingOccurrences(of: ".\(pe)", with: "", options: .caseInsensitive, range: nil)
    let (author, name) = splitString(from: fn)
    return importMusicInfo(cover: "", author: author, name: name, suffix: pe, fileName: pc)
}
struct PickFiles: View {
    @State private var selectedFileURLs: [URL] = []
    @State private var isImporting = false
    @State private var players: [AVPlayer] = []

    var body: some View {
        VStack {
            Button("播放所有 MP3 文件") {
                print(splitString(from: "东汉末年分三国"))
                print(splitString(from: "曹操-三分天下"))
                print(splitString(from: "诸葛亮 - 我的茅庐"))
            }
            if selectedFileURLs.isEmpty {
                Text("未选择文件")
            } else {
                List(selectedFileURLs, id: \.self) { url in
                    let data = backMusicBaseInfo(url: url)
                    Text("\(data.author)-\(data.name).\(data.suffix)")
                }
                
            }
            Button("导入多个 MP3 文件") {
                isImporting = true
            }
        }
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [.audio],
            allowsMultipleSelection: true) { result in
                switch result {
                    case.success(let urls):
                        selectedFileURLs = urls
                        // print("选中的文件 URLs: \(urls)")
                        importSuccess()
                        
                    case.failure(let error):
                        print("文件导入失败: \(error)")
                }
        }
    }
    func importSuccess() {
        for info in selectedFileURLs {
            copyFile2Documents(from: info)
        }
    }
}

#Preview {
    PickFiles()
}
