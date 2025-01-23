//
//  MusicPickSheet.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/13.
//

import SwiftUI
import SwiftData
struct MusicPickSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Query var allPlayList: [ModelPlaylist]
    @Query var allMusicList: [ModelMusicList]
    
    @Binding var  isShowpickMusic: Bool
    @Binding var bindMusics: [ModelMusicList]
    
    @State private var selections: [UUID] = []
//    @State private var firstId: UUID = UUID()
    var body: some View {
        NavigationStack() {
            List {
                ForEach(allMusicList) { data in
                    HStack {
                        Image(systemName: selections.contains(data.id) ? "checkmark.circle.fill" : "circle.dashed")
                        Image(data.cover)
                            .resizable()
                            .frame(width: 50, height: 50)
                            
                        VStack(alignment: .leading) {
                            Text(data.name)
                            Text(formatTime(data.createTime))
                        }
                    }
                    .listSectionSeparator(.hidden, edges: .top)
                    .listRowInsets(EdgeInsets())
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if selections.contains(data.id) {
                            selections = selections.filter { $0 != data.id }
                        } else {
                            selections.append(data.id)
                        }
                    }
                }
                
            }
            .listStyle(InsetListStyle())
            .scrollContentBackground(.hidden)
            .navigationBarTitle("挑选你喜欢的歌曲", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button("完成") {
                        print("ok")
                        var newMs: [ModelMusicList] = []
                        allMusicList.forEach { aa in
                            if selections.contains(aa.id) {
                                newMs.append(aa)
                            }
                        }
                        bindMusics = newMs
                        isShowpickMusic = false
                    }
                }
            }
            .tint(Color.pink)
            .onAppear {
//                firstId = bindMusics[0].id
//                selections = bindMusics.musics.map { $0.id }
                selections = bindMusics.map { $0.id }
            }
        }
        
    }
}

#Preview {
    MusicControl()
        .modelContainer(for: [ModelMusicList.self, ModelPlaylist.self])
}
