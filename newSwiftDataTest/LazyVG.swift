//
//  LazyVG.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2024/12/25.
//

import SwiftUI
struct Model: Identifiable {
    var id = UUID()
    var imageName: String
}

let sampleModels = (1...30).map{ _ in Model(imageName: "avatar4") }
struct LazyVG: View {
    @State private var photoSet = sampleModels
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(photoSet) { photo in
                        Image(photo.imageName)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .padding(.bottom, 14)
                    }
                }
                .padding()
                HStack{}.padding(.bottom, 60)
            }
            
            Button(action: {
                
            }, label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                Text("上传")
                    .foregroundStyle(.white)
                    .font(.system(size: 20))
                    
            })
            .frame(width: 200, height: 60)
            .background(.pink)
            .cornerRadius(60)
        }
        
    }
}

#Preview {
    LazyVG()
}
