//
//  searchableTest.swift
//  MyTest
//
//  Created by QIAEN on 2024/12/11.
//

import SwiftUI
import SwiftData
let dateFormatter = DateFormatter()

func formatTime(_ d: Date) -> String {
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.string(from: d)
}
struct PlayListItem: View {
    @State var data: ModelPlaylist
    let editData: (ModelPlaylist) -> Void
    
    var body: some View {
        HStack {
            Image(data.cover)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.trailing, 8)
//                .padding(.leading, -36)
                
            VStack(alignment: .leading) {
                Text(data.name)
                Text(formatTime(data.createTime))
            }
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
//        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .contentShape(Rectangle())
        .onTapGesture {
            editData(data)
        }
    }
}

struct MusicControl: View {
    @Environment(\.modelContext) private var modelContext
    @Query var allPlayList: [ModelPlaylist]
    @Query var allMusicList: [ModelMusicList]
    // @Query(ModelPlaylist.all) private var allPlayList: [ModelPlaylist]
    
    @State private var searchText = ""
    @State private var showLibraryAddSheet = false
    @State var selectPlaylist: ModelPlaylist? = nil
    
    let audioPlay = AudioPlay()
    var body: some View {
        NavigationView {
            // List 在scrollView中无法显示
            List {
                ForEach(searchResults) { item in
                    NavigationLink {
                        MusicListView(libData: item)
                            
                    } label: {
                        PlayListItem(data: item, editData: editData)
                    }
                    .listSectionSeparator(.hidden, edges: .top)
                }
            }
            .listStyle(InsetListStyle())
            .scrollContentBackground(.hidden)
            .navigationTitle("Libary")
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button(action: {
                        addData()
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.pink)
                    }
                    .sheet(isPresented: $showLibraryAddSheet) {
                        MusicLibraryAdd(showLibraryAddSheet: $showLibraryAddSheet, bindEditData: $selectPlaylist)
                            .presentationCornerRadius(24)
                    }
                }
            }
        }
        .background(Color.pink)
        .searchable(text: $searchText, prompt: "请输入搜索内容")
        .tint(Color.pink)
        
//        .refreshable {
////            print(allPlayList.count)
//            print("用户下拉刷新:")
////            for pl in allPlayList {
////                print("ID: \(pl.id.uuidString), 名称: \(pl.name), 年龄: \(pl.createTime)")
////            }
//            for pl in allMusicList {
//                print("名称: \(pl.name), 年龄: \(pl.createTime)")
//            }
//        }
        .onAppear {
            audioPlay.play(allPlayList: allPlayList)
            if allMusicList.isEmpty {
                print("haimeiy")
            } else {
//                let n1 = ModelMusicList(name: "月亮惹的祸", author: "张飞")
//                let n2 = ModelMusicList(name: "七里香", author: "张飞")
//                let n3 = ModelMusicList(name: "笨小孩", author: "诸葛亮")
//                let n4 = ModelMusicList(name: "忐忑", author: "曹操")
//                modelContext.insert(n1)
//                modelContext.insert(n3)
//                modelContext.insert(n2)
//                modelContext.insert(n4)
                print("yijin youshuju le ")
            }
        }
    }
        
    
    var searchResults: [ModelPlaylist] {
        if searchText.isEmpty {
            return allPlayList
        } else {
            return allPlayList.filter { $0.name.contains(searchText) }
        }
    }
    
    func addData() {
        self.selectPlaylist = nil
        showLibraryAddSheet = true
    }
    func editData(_ data: ModelPlaylist) {
        self.selectPlaylist = data
        showLibraryAddSheet = true
    }
}

#Preview {
    MusicControl()
        .modelContainer(for: [ModelMusicList.self, ModelPlaylist.self]) { result in
//            do {
//                let container = try result.get()
//                
//                // 先检查有没数据
//                let descriptor = FetchDescriptor<ModelMusicList>()
//                let existingArticles = try container.mainContext.fetchCount(descriptor)
//                guard existingArticles == 0 else { return }
//                print("开始")
////
////                // 读取 bundle 里的文件
//                if let url = Bundle.main.url(forResource: "init-musics", withExtension: "json") {
//                    print("chenggongle, \(url)")
//                                    let data = try Data(contentsOf: url)
////                                    let articles = try JSONDecoder().decode([ModelMusicList].self, from: data)
//                    //
//                    //                for article in articles {
//                    //                    container.mainContext.insert(article)
//                    //                }
//                }
//                print("hello, 这里jiesu")
//
//
//            } catch {
//                print("初始化倒入失败！")
//            }
        }
}
