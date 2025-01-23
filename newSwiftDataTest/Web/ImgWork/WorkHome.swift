import SwiftUI

struct WorkHome: View {
    @StateObject var myImgCavasModel: myImgCavasModel = .init()
    
    var body: some View {
        GeometryReader{ proxy in
            ZStack {
                Color.black.ignoresSafeArea()
                
                Canvas(size: proxy.size)
                    .environmentObject(myImgCavasModel)
                
                HStack(spacing: 15) {
                    Button{
                        
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                    }
                    Spacer()
                    Button {
                        myImgCavasModel.shoeImagePicker.toggle()
                    } label: {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title3)
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
                Button {
                    if !myImgCavasModel.imageData.isEmpty {
                        myImgCavasModel.cropImage(image: UIImage(data: myImgCavasModel.imageData)!)
                    }
                    
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
    //        .alert(myImgCavasModel.errorMessage, isPresented: $myImgCavasModel.showError){
    //
    //        }
            .sheet(isPresented: $myImgCavasModel.shoeImagePicker) {
                if let image = UIImage(data: myImgCavasModel.imageData) {
//                    myImgCavasModel.addImageToStack(image: image)
                    myImgCavasModel.resetImgInfo(image: image)
                }
//                
            } content: {
                ImgPicker(showPicker: $myImgCavasModel.shoeImagePicker, imageData: $myImgCavasModel.imageData)
            }
            .onAppear {
                myImgCavasModel.canvasWidth = proxy.size.width
            }
        }
    }
}

#Preview {
    WorkHome()
}
