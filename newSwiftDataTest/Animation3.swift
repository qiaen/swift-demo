//
//  Animation3.swift
//  newSwiftDataTest
//
//  Created by TEEMO on 2025/1/31.
//

import SwiftUI
struct AnimationSheet: View {
    @Binding var expand: Bool
    var shapeTransition: Namespace.ID
    
    var body: some View {
        VStack {
            Image("avatar4")
                .resizable()
                .matchedGeometryEffect(id: "circle", in: shapeTransition)
                .frame(width: 340,height: 340)
                .cornerRadius(12)
                .padding()
                .padding(.top, 20)
                
            Text("蜀道难")
                .font(.largeTitle)
            Text("李白")
                .font(.body)
                .padding(.top, 1)
            Spacer()
        }
    }
}
struct Animation3: View {
    @State var showAniDetail = false
    
    @State private var expand = false
    @Namespace private var shapeTransition
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                
            }
            HStack {
                Image("avatar4")
                    .resizable()
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: 46,height: 46)
                    .cornerRadius(6)
                    .sheet(isPresented: $showAniDetail) {
//                        AnimationSheet(expand: $showAniDetail, shapeTransition: shapeTransition)
                        Animation4()
                    }
                VStack {
                    Text("蜀道难 - 李白")
                        .font(.system(size: 18))
                }
                Spacer()
            }
            .onTapGesture {
                showAniDetail = true
            }
            .padding()
        }
        
    }
}

#Preview {
    Animation3()
}
