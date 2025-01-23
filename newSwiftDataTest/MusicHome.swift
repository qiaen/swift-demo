//
//  MusicHome.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2025/1/2.
//

import SwiftUI

struct MusicHome: View {
    var body: some View {
        GeometryReader { gemetry in
            let screenWidth = gemetry.size.width
//            let screenHeight = gemetry.size.height
            ZStack(alignment: .top) {
                // 顶部图片
                Image("avatar4")
                    .resizable()
                    .frame(width: screenWidth, height: screenWidth)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {}
                        .frame(height: screenWidth - 30)
                        .background(.clear)
                    VStack{
                        Text("Test Title")
                            .padding(.top, 50)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("subheading")
                            .padding(.top, 1)
                            .font(.subheadline)
                        
                        HStack {}
                            .frame(width: screenWidth - 60, height: 7)
                            .background(.black.opacity(0.3))
                            .cornerRadius(7)
                            .padding(.top, 40)
                        HStack {
                            Text("00:00")
                                .font(.subheadline)
                            Spacer()
                            Text("04:32")
                                .font(.subheadline)
                        }
                        .frame(width: screenWidth - 60, height: 7)
                        .padding(.top, 5)
                        
                
                        HStack {
                            Image(systemName: "heart")
                            Spacer()
                            Image(systemName: "backward.fill")
                                .font(.title)
                            Image(systemName: "pause.fill")
                                .font(.largeTitle)
                                .padding(.horizontal, 30)
                            Image(systemName: "forward.fill")
                                .font(.title)
                            Spacer()
                            Image(systemName: "text.append")
                        }
                        .padding(.top, 40)
                        .padding(.horizontal, 30)
                    }
                    .frame(width: screenWidth)
                    .background(.white)
                    .cornerRadius(30)
                    
                }
                .frame(width: screenWidth)
                .edgesIgnoringSafeArea(.top)
                
            }
            .edgesIgnoringSafeArea(.top)
        }
        
    }
}

#Preview {
    MusicHome()
}
