//
//  GetData.swift
//  newSwiftDataTest
//
//  Created by QIAEN on 2025/2/7.
//

import SwiftUI
struct ExamDesc: Codable {
    var examinationPointDesc: String
}
struct Examdata: Codable {
    var data: ExamDesc
}
struct ResponseData: Codable {
    let origin: String
}
struct GetData: View {
    @State var responseText = "---"
    var body: some View {
        Text(responseText)
        Button(action: {
            getdata()
        }, label: {
            Text("获取详情")
        })
    
    }
    func getdata() {
        let url = URL(string: "https://api.kezhitech.com/fp-question-web/examinationPoint/detail?examinationPointId=214")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(Examdata.self, from: data)
//                        print(decodedData.data.examinationPointDesc)
                        responseText = decodedData.data.examinationPointDesc
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                    }
                }
            }
            
        }
        task.resume()
    }
}

#Preview {
    GetData()
}
