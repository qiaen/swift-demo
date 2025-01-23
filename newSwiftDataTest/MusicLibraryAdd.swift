//
//  MusicLibraryAdd.swift
//  MyTest
//
//  Created by QIAEN on 2024/12/12.
//

import SwiftUI
import SwiftData

struct MusicLibraryAdd: View {
    @Environment(\.modelContext) private var modelContext
    @Query var allPlayList: [ModelPlaylist]
    
    @State private var libraryName: String = ""
    @State private var libraryCover: String = ""
    @State private var libraryId: UUID?
    
    @FocusState private var isTextFieldFocused: Bool
    
    @Binding var showLibraryAddSheet: Bool
    @Binding var bindEditData: ModelPlaylist?
    
    @State private var selectPlaylist: ModelPlaylist = ModelPlaylist(type: 1, name: "", cover: "cover1", musics: [])
    
    @State private var isEdit = false
    func savePlaylist() {
        print("完成操作被点击")
        
        if isEdit == true {
            bindEditData!.name = selectPlaylist.name
            bindEditData!.cover = selectPlaylist.cover
            print("\(bindEditData!.name)")
        } else {
            selectPlaylist.createTime = .now
            modelContext.insert(selectPlaylist)
        }
        showLibraryAddSheet = false
    }
    var body: some View {
        NavigationView() {
            VStack {
                Image(selectPlaylist.cover)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 50)
                
                TextField("请输入列表名称", text: $selectPlaylist.name)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        savePlaylist()
                    }
//                MusicListView(allMusics: $selectPlaylist.musics)
                Spacer()
            }
            .padding(.horizontal, 50).padding(.top, 30)
            .navigationBarTitle("新建播放列表", displayMode: .inline)
            .toolbar {
                 ToolbarItem(placement:.navigationBarTrailing) {
                     Button("创建") {
                         savePlaylist()
                     }
                 }
                ToolbarItem(placement:.navigationBarLeading) {
                    Button("取消") {
                        showLibraryAddSheet = false
                    }
                }
             }
            .onAppear {
                isTextFieldFocused = true
            }
            
        }
        .tint(.pink)
        .onAppear {
            if bindEditData != nil {
                isEdit = true
                selectPlaylist.name = bindEditData!.name
                selectPlaylist.id = bindEditData!.id
                selectPlaylist.cover = bindEditData!.cover
            } else {
                isEdit = false
            }
        }
    }
}


#Preview {
    MusicControl()
        .modelContainer(for: [ModelMusicList.self, ModelPlaylist.self])
}
