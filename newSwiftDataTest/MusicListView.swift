//
//  MusicListView.swift
//  SwiftDataTest
//
//  Created by QIAEN on 2024/12/12.
//

import SwiftUI
import SwiftData

struct MusicListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var allPlayList: [ModelPlaylist]
    @State private var searchText = ""
    
    @State var libData: ModelPlaylist
    
    @State private var selection: ModelMusicList?
    
    @State private var isShowpickMusic = false
    var body: some View {
        
        List( selection: $selection) {
            HStack {
                Image(libData.cover)
                    .resizable()
                    .frame(width: 80, height: 80)
                
                VStack(alignment: .leading) {
                    Text(libData.name)
                        .font(.system(size: 20))
                        .padding(.bottom, 10)
                        .foregroundStyle(.black)
                    
                    HStack {
                        Text(formatTime(libData.createTime))
                            .font(.system(size: 14))
                        Spacer()
                        Button(action: {
                            print("插入数据")
                            let newMusic = ModelMusicList(name: "\(libData.name)-张三")
                            libData.musics.append(newMusic)
                        }) {
                            HStack {
                                Image(systemName: "arrowshape.down")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                                
                                Text("导入歌曲")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                                    .padding(.leading, 2)
                            }
                        }
                        .frame(width: 124, height: 40)
                        .background(.black)
                        .cornerRadius(50)
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(.top, 10)
            
            ForEach(libData.musics) { data in
                HStack {
                    Image(data.cover)
                        .resizable()
                        .frame(width: 50, height: 50)
                        
                    VStack(alignment: .leading) {
                        Text(data.name)
                        Text(formatTime(data.createTime))
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .contentShape(Rectangle())
                .onTapGesture {
                    print(data.name)
                }
            }
            
        }
        .listStyle(InsetListStyle())
        .scrollContentBackground(.hidden)
        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
//            }
            ToolbarItem(placement:.navigationBarTrailing) {
                Button(action: {
                    isShowpickMusic = true
                }) {
                    Image(systemName: "checklist")
                        .foregroundStyle(.pink)
                }
                .sheet(isPresented: $isShowpickMusic) {
                    MusicPickSheet(isShowpickMusic: $isShowpickMusic, bindMusics: $libData.musics)
                        .presentationCornerRadius(24)
                }
            }
        }
        .navigationBarTitle(libData.name, displayMode: .inline)
        .background(Color.white)
        .tint(Color.pink)
    }
}

#Preview {
    MusicControl()
        .modelContainer(for: [ModelMusicList.self, ModelPlaylist.self])
}
