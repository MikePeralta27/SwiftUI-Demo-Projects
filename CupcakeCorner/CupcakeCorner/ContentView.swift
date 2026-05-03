//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Michael Peralta on 4/29/26.
//

import SwiftUI

//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}

struct ContentView: View {

    //    @State private var results: [Result] = [Result]()

    var body: some View {

        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Text("Error: There was an error loading the image")
            } else {
                ProgressView()

            }
                

        }
        .frame(width: 300, height: 300)

        //        List(results, id: \.trackId) { result in
        //            VStack(alignment: .leading) {
        //                Text(result.trackName)
        //                    .font(.headline)
        //                Text(result.collectionName)
        //            }
        //        }
        //        .task {
        //            await loadData()
        //        }
    }

    //    func loadData() async {
    //
    //        //1- Create URL to read
    //        guard
    //            let url = URL(
    //                string:
    //                    "https://itunes.apple.com/search?term=taiylor+swift&entity=song"
    //            )
    //        else {
    //            print("URL is invalid")
    //            return
    //        }
    //
    //        //2 - Fetch data
    //        do {
    //            let (data, _) = try await URLSession.shared.data(from: url)
    //            //more code
    //            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
    //                results = decodedResponse.results
    //            }
    //        } catch {
    //            print("Invalid Data")
    //        }
    //
    //        // 3 - decode code as response
    //
    //        let decoder = JSONDecoder()
    //
    //    }
}

#Preview {
    ContentView()
}
