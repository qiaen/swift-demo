//
//  upload.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/23.
//

import SwiftUI
import PhotosUI

func saveImageToCache(image: UIImage) {
    guard let cacheDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Failed to get cache directory")
        return
    }
    print(image)
    let cacheFilePath = cacheDirectory.appendingPathComponent(UUID().uuidString + ".jpeg")
    
    if let jpegData = image.jpegData(compressionQuality: 1.0) {
        do {
            try jpegData.write(to: cacheFilePath)
            print("Image saved to cache: \(cacheFilePath)")
        } catch {
            print("Failed to save image to cache: \(error)")
        }
    }
}
func cropImage(image: UIImage) {
        guard let cgImage = image.cgImage else { return }
 
        let scale = image.scale
        let size = CGSize(width: min(cgImage.width, cgImage.height), height: min(cgImage.width, cgImage.height))
        let rect = CGRect(origin: CGPoint(x: (cgImage.width - Int(size.width)) / 2, y: (cgImage.height - Int(size.height)) / 2), size: size)
 
        if let croppedCGImage = cgImage.cropping(to: rect) {
            let croppedImage = UIImage(cgImage: croppedCGImage, scale: scale, orientation: image.imageOrientation)
            saveImageToCache(image: croppedImage)
        }
    }

struct upload: View {
    @State private var selectedItem: PhotosPickerItem? = nil
        @State private var selectedImageData: Data? = nil
        
        var body: some View {
            VStack(spacing: 0) {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text("Select a photo")
                    }
                    .onChange(of: selectedItem) {
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                                if (selectedImageData != nil) {
//                                    saveImageToCache(image: UIImage(data: selectedImageData!)!)
                                    cropImage(image: UIImage(data: selectedImageData!)!)
                                }
                                
                            }
                        }
                    }

                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .cornerRadius(6)
                        .clipped()
                }
            }
        }
}

#Preview {
    upload()
}
