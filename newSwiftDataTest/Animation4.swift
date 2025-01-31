//
//  Animation3.swift
//  newSwiftDataTest
//
//  Created by TEEMO on 2025/1/31.
//

import SwiftUI
//    .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
//        content
//            .opacity(phase.isIdentity ? 1 : 0)
//            .scaleEffect(phase.isIdentity ? 1 : 0.75)
//            .blur(radius: phase.isIdentity ? 0 : 10)
//    }
let shudao_nan = [
    "噫吁嚱，危乎高哉！蜀道之难，难于上青天！",
    "蚕丛及鱼凫，开国何茫然！",
    "尔来四万八千岁，不与秦塞通人烟。",
    "西当太白有鸟道，可以横绝峨眉巅。",
    "地崩山摧壮士死，然后天梯石栈相钩连。",
    "上有六龙回日之高标，下有冲波逆折之回川。",
    "黄鹤之飞尚不得过，猿猱欲度愁攀援。",
    "青泥何盘盘，百步九折萦岩峦。",
    "扪参历井仰胁息，以手抚膺坐长叹。",
    "问君西游何时还？畏途巉岩不可攀。",
    "但见悲鸟号古木，雄飞雌从绕林间。",
    "又闻子规啼夜月，愁空山。",
    "蜀道之难，难于上青天，使人听此凋朱颜！",
    "连峰去天不盈尺，枯松倒挂倚绝壁。",
    "飞湍瀑流争喧豗，砯崖转石万壑雷。",
    "其险也如此，嗟尔远道之人胡为乎来哉！",
    "剑阁峥嵘而崔嵬，一夫当关，万夫莫开。",
    "所守或匪亲，化为狼与豺。",
    "朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。",
    "锦城虽云乐，不如早还家。",
    "蜀道之难，难于上青天，侧身西望长咨嗟！"
]
struct Animation4: View {
    @Namespace var nspace
    @State var showLyric = false
    var boxHeight: CGFloat {
        return showLyric ? 604 : 400
    }
    var imageHeight: CGFloat {
        return showLyric ? 60 : 340
    }
    
    var body: some View {
        
        VStack {
            if showLyric {
                // has lyric
                VStack {
                    HStack {
                        Image("avatar4")
                            .resizable()
                            .cornerRadius(6)
                            .matchedGeometryEffect(id: "cover", in: nspace)
                            .frame(width: imageHeight,height: imageHeight)
                            .padding()
                            .onTapGesture {
                                withAnimation(.spring) {
                                    showLyric.toggle()
                                }
                            }
                        VStack(alignment: .leading) {
                            Text("蜀道难")
                                .font(.title2)
                            Text("李白")
                                .font(.body)
                        }
                        .matchedGeometryEffect(id: "name", in: nspace)
                        
                        Spacer()
                        Image(systemName: "heart")
                            .padding()
                    }
                    .padding(.top, 20)
                    ScrollView(showsIndicators: false) {
                        ForEach(shudao_nan, id: \.self) {item in
                            Text(item)
                                .frame(width: 340, alignment: .leading)
                                .font(.title2)
                                .padding(3)
                                
                        }
                    }
                }
                .frame(height: boxHeight)
                
                
            } else {
                // no lyric
                VStack {
                    Image("avatar4")
                        .resizable()
                        .cornerRadius(12)
                        .matchedGeometryEffect(id: "cover", in: nspace)
                        .frame(width: imageHeight,height: imageHeight)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring) {
                                showLyric.toggle()
                            }
                        }
                    Spacer()
                }
                .padding(.top, 20)
                .frame(height: boxHeight)
                VStack {
                    Text("蜀道难")
                        .font(.largeTitle)
//                        .lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                    Text("李白")
                        .font(.body)
                        .padding(.top, 1)
                }
                .matchedGeometryEffect(id: "name", in: nspace)
                
            }
            
            
            HStack {
                Image(systemName: "backward.fill")
                    .font(.title2)
                Image(systemName: "play.fill")
                    .font(.largeTitle)
                    .padding(.horizontal, 40)
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    Animation4()
}
