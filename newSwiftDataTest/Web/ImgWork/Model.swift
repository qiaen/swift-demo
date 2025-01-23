//
//  Model.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2025/1/17.
//

import Foundation
import SwiftUI

class myImgCavasModel: ObservableObject {
    @Published var shoeImagePicker: Bool = false
    @Published var imageData: Data = .init(count: 0)
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var imgScale = 1.0
    // 画布的宽和高
    @Published var canvasWidth:CGFloat = 410.0
    // 当前操作图片的大小
    @Published var workImgSize:CGSize = .zero
    
    @Published var imgOffset:CGSize = .zero
    @Published var imgLastOffset: CGSize = .zero
    
    func resetImgInfo(image: UIImage) {
        imgLastOffset = .zero
        imgOffset = .zero
        
        let imgWidth = image.size.width
        let imgHeight = image.size.height
        
        var frameWidth = canvasWidth
        var frameHeight = canvasWidth
        
        if imgWidth > imgHeight {
            // 宽图，高为canvas的高，宽度为缩放后的宽
            frameWidth = imgWidth / imgHeight * frameHeight
            imgScale = frameWidth / imgWidth
        } else {
            // 高图，高为缩放后的高，宽度为canvas的宽
            frameHeight = imgHeight / imgWidth * frameWidth
            imgScale = frameHeight / imgHeight
        }
        workImgSize.width = frameWidth
        workImgSize.height = frameHeight
        print("图片原始尺寸\(image.size)")
        print("图片宽高：\(frameWidth)x\(frameHeight)")
        
    }
    
    func cropImage(image: UIImage) {
        // 检查传入的 UIImage 是否可以转换为 CGImage，如果不能则直接返回
        guard let cgImage = image.cgImage else { return }
        let offsetX = imgOffset.width / imgScale
        let offsetY = imgOffset.height / imgScale
        print("imgScale=\(imgScale), img.offset.width=\(imgOffset.width), offsetX=\(offsetX)")
        // 获取图像的缩放比例
        let scale = image.scale

        // 计算裁剪后的尺寸，取宽度和高度中较小的值作为裁剪后的尺寸
        let osize = CGSize(width: min(cgImage.width, cgImage.height), height: min(cgImage.width, cgImage.height))

        // 计算裁剪区域，将裁剪区域的原点定位在图像中心位置
        
        let ofy = (cgImage.height - Int(osize.height)) / 2 - Int(offsetY)
        
        let ofx = (cgImage.width - Int(osize.width)) / 2  - Int(offsetX)
        print("ofx=\(ofx)")
        let rect = CGRect(origin: CGPoint(x: ofx, y: ofy), size: osize)

        // 对 CGImage 进行裁剪操作
        if let croppedCGImage = cgImage.cropping(to: rect) {
            // 根据裁剪后的 CGImage 创建新的 UIImage，保持原图像的缩放比例和方向
            let croppedImage = UIImage(cgImage: croppedCGImage, scale: scale, orientation: image.imageOrientation)
            // 调用函数将裁剪后的图像保存到缓存中
            saveImageToCache(image: croppedImage)
        }
    }
}
