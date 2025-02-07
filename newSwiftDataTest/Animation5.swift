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
let shudao_nan1 = [
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
struct Animation5: View {
    @Namespace var nspace
    @State var showLyric = false
    var boxHeight: CGFloat {
        return showLyric ? 605 : 480
    }
    var imageHeight: CGFloat {
        return showLyric ? 60 : 340
    }
    var body: some View {
        
        VStack {
            ZStack(alignment: .bottom) {
                Image("avatar4")
                    .resizable()
                    .cornerRadius(12)
                    .matchedGeometryEffect(id: "cover", in: nspace)
                    .frame(width: imageHeight,height: imageHeight)
                    .position(x: showLyric ? 50 : 200, y: showLyric ? 50 : 200)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            showLyric.toggle()
                        }
                    }
                VStack(alignment: showLyric ? .leading : .center) {
                    Text("蜀道难")
                        .font(showLyric ? .title2 :.largeTitle)
                    Text("李白")
                        .font(.body)
                        .padding(.top, showLyric ? 0 : 1)
                }
                .position(x: showLyric ? 125 : 200, y: showLyric ? 50 : 440)
                
                
                
                if showLyric {
                    Image(systemName: "heart")
                        .position(x: 360, y: 50)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(shudao_nan, id: \.self) {item in
                            Text(item)
                                .frame(width: 340, alignment: .leading)
                                .font(.title2)
                                .padding(3)
                                
                        }
                    }
                    .frame(height: boxHeight - 100)
                }
                
                
            }.frame(height: boxHeight)
            
            
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
    Animation5()
}
