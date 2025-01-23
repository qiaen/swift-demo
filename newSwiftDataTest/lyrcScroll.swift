//
//  DownMusicList.swift
//  Music
//
//  Created by TEEMO on 2024/11/30.
//

import SwiftUI
import AVFoundation
let lrc = [
    "[00:00.00]等你归来",
    "[00:04.00]演唱：程响",
    "[00:08.00]作词/作曲：宁缺",
    "[00:20.93]我就在这里",
    "[00:23.06]等你披星戴月 乘着风而来",
    "[00:30.30]我就在这里",
    "[00:32.30]埋好烈酒 候你故事开",
    "[00:36.74]",
    "[00:37.44]千千万万人海 灯火阑珊",
    "[00:42.45]你多少次不在",
    "[00:46.00]走遍高高低低 一路辗转",
    "[00:50.81]朝暮青丝已白",
    "[00:54.55]",
    "[00:56.43]我在红尘等你 人间等你",
    "[01:01.68]守繁华之外",
    "[01:04.81]揽尽星辰入怀 千川归来",
    "[01:10.03]化一片沧海",
    "[01:12.58]",
    "[01:13.28]我在九幽等你 极乐等你",
    "[01:18.38]望彼岸花开",
    "[01:21.58]长对三生浮白 不畏不改",
    "[01:26.72]渡过去将来",
    "[01:30.30](Music)",
    "[01:51.03]我就在这里",
    "[01:52.93]等你跨山越海 踏着云烟来",
    "[02:00.46]我就在这里",
    "[02:01.98]望尽天涯 风雨也不改",
    "[02:07.08]",
    "[02:07.78]安安静静岁月 时光荏苒",
    "[02:12.42]你或许会徘徊",
    "[02:15.84]挥别近近远远 一身尘埃",
    "[02:20.74]俯仰皆是无奈",
    "[02:24.70]",
    "[02:26.55]我在红尘等你 人间等你",
    "[02:31.65]守繁华之外",
    "[02:34.80]揽尽星辰入怀 千川归来",
    "[02:40.04]化一片沧海",
    "[02:42.65]",
    "[02:43.35]我在九幽等你 极乐等你",
    "[02:48.40]望彼岸花开",
    "[02:51.54]长对三生浮白 不畏不改",
    "[02:56.82]渡过去将来",
    "[02:59.31]",
    "[02:59.81]我在红尘等你 人间等你",
    "[03:05.25]守繁华之外",
    "[03:08.31]揽尽星辰入怀 千川归来",
    "[03:13.56]化一片沧海",
    "[03:16.07]",
    "[03:16.77]我在九幽等你 极乐等你",
    "[03:21.78]望彼岸花开",
    "[03:25.01]长对三生浮白 不畏不改",
    "[03:30.28]渡过去将来",
    "[03:33.77]",
    "[03:35.07]长对三生浮白 不畏不改",
    "[03:40.84]渡过去将来"
]
// 分割歌词
func convertStringToDictionary(_ inputString: String) -> lyrcStruct {
    if let startIndexOfTime = inputString.firstIndex(of: "["),
       let endIndexOfTime = inputString.firstIndex(of: "]") {
        let timeString = String(inputString[inputString.index(after: startIndexOfTime)..<endIndexOfTime])
        let startIndexOfText = inputString.index(after: endIndexOfTime)
        let textString = String(inputString[startIndexOfText...])
        let timeDouble = timeStringToSeconds(timeString)
        return lyrcStruct(time: timeDouble ?? -1, text: textString)
    } else {
        return lyrcStruct(time: -1, text: "")
    }
}
// 把歌词时间转化为Double秒
func timeStringToSeconds(_ timeString: String) -> Double? {
    let components = timeString.components(separatedBy: ":")
    guard components.count == 2 else {
        return nil
    }
    guard let minutes = Double(components[0]), let seconds = Double(components[1]) else {
        return nil
    }
    let totalSeconds = minutes * 60 + seconds
    return totalSeconds
}
struct lyrcStruct: Identifiable {
    var id = UUID()
    var time: Double
    var text: String
}
class TimerExample: ObservableObject {
    @Published var count: Int = 20
    
    var timer: Timer?
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self!.count += 1
//            print("Count: \(self?.count ?? 0)")
            if self!.count > 180 {
                self!.stopTimer()
            }
            NotificationCenter.default.post(name: NSNotification.Name("pushPlayTime"), object: self!.count)
        }
    }

    func stopTimer() {
        timer?.invalidate()
        count = 20
        timer = nil
    }
}

struct LyrcScroll: View {
//    @State private var offset: CGFloat = 0
    @EnvironmentObject var timerExample: TimerExample
//
//    var offset:CGFloat {
//        return 0 - CGFloat(timerExample.count * 80)
//    }
    
    var lyrics: [lyrcStruct] {
        return lrc.map {
            let output = convertStringToDictionary($0)
            return lyrcStruct(time: output.time, text: output.text)
        }
    }
    
    var timer: Timer?
    @State var playTime:Double = 0
    var body: some View {
        ScrollViewReader { proxy in
        ZStack {
//                HStack {
//                    Image("avatar8")
//                        .resizable()
//                        .scaledToFill()
//                        .blur(radius: 40)
//                }
            Rectangle()
                .fill(.bgWhite.opacity(0.6))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                ScrollView {
                        VStack(alignment:.leading) {
                            ForEach(lyrics) { lyric in
                                Text(lyric.text)
                                    .font(.system(size: 25))
                                    .padding()
                                    .id(lyric.time)
                                    .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                        content
                                            .opacity(phase.isIdentity ? 1 : 0)
                                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                            .blur(radius: phase.isIdentity ? 0 : 10)
                                    }
                            }
                        }
                }
                .frame(width: 310, height: 300)
                .padding(.horizontal, 50)
                .scrollIndicators(.hidden)
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("pushPlayTime"))) { notification in
                    if notification.object is Int {
//                        print("时间到了：\(String(describing: notification.object))")
                        for lc in lyrics.reversed() {
                            if lc.time < notification.object as! Double {
                                playTime = lc.time
                                withAnimation {
                                    proxy.scrollTo(lc.time, anchor: .center)
                                }
                                return
                            }
                        }
                    }
                }
                HStack{
                    Button("开始", action: {
                        timerExample.startTimer()
                    })
                    Button("结束", action: {
                        timerExample.stopTimer()
                    })
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
//        .onAppear {
//            print(lyrics[0])
//        }
        }
    }
}

#Preview {
    let timerExample = TimerExample()
    LyrcScroll()
        .environmentObject(timerExample)
}
