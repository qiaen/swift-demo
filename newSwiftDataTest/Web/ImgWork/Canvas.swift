//
//  Canvas.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2025/1/17.
//

import SwiftUI

struct Canvas: View {
    @State var size: CGSize
    @EnvironmentObject var myImgCavasModel: myImgCavasModel
    
    var body: some View {
        ZStack {
            Color.white
            
            if let image = UIImage(data: myImgCavasModel.imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.width)
                    .offset(myImgCavasModel.imgOffset)
                    .clipped()
            }
        }
        .frame(width: size.width, height: size.width)
        .clipped()
        .gesture(
            DragGesture()
                .onChanged({value in
                    if !myImgCavasModel.imageData.isEmpty {
                        var th = value.translation.height
                        var tw = value.translation.width
                        // 画布宽高都是宽度
                        if myImgCavasModel.workImgSize.height > size.width {
                            // 图片的高比画布高，不能左右移动
                            tw = 0
                        } else {
                            // 图片的高等于画布高，不能上下移动
                            th = 0
                        }
                        // 图片的宽比画布宽，只能左右移动
                        myImgCavasModel.imgOffset = CGSize(
                            width: myImgCavasModel.imgLastOffset.width + tw,
                            height: myImgCavasModel.imgLastOffset.height + th
                        )
                    }
                    
                })
                .onEnded({value in
                    if !myImgCavasModel.imageData.isEmpty {
                        myImgCavasModel.imgLastOffset = myImgCavasModel.imgOffset
                    }
                })
        )
    }
}

#Preview {
    WorkHome()
}
