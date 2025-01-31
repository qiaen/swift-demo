//
//  Animation2.swift
//  newSwiftDataTest
//
//  Created by TEEMO on 2025/1/31.
//

import SwiftUI

struct Animation2: View {
    @Namespace private var shapeTransition
    @State var expand = false
    var body: some View {
        VStack {
            VStack {
                if expand {

                    // Rounded Rectangle
                    Spacer()

                    RoundedRectangle(cornerRadius: 50.0)
                        .matchedGeometryEffect(id: "circle", in: shapeTransition)
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                        .padding()
                        .foregroundColor(Color(.systemGreen))
                        .onTapGesture {
                            withAnimation {
                                expand.toggle()
                            }
                        }

                } else {

                    // Circle
                    RoundedRectangle(cornerRadius: 50.0)
                        .matchedGeometryEffect(id: "circle", in: shapeTransition)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(.systemOrange))
                        .onTapGesture {
                            withAnimation {
                                expand.toggle()
                            }
                        }

                    Spacer()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    Animation2()
}
