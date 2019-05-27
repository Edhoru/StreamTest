//
//  SuggestionsDataService.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/25/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

class BroadcastsDataService {
    
    func get(_ completion: @escaping ([Broadcast], Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "broadcasts", ofType: "json") else {
            fatalError("no file")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let broadcasts = mapBroadcast(from: data)
            completion(broadcasts, nil)
        } catch {
            fatalError("no data")
        }
    }
    
    
    func mapBroadcast(from data: Data) -> [Broadcast] {
        do {
            let broadcasts = try JSONDecoder().decode([Broadcast].self, from: data)
            return broadcasts
        } catch let jsonError {
            print("no json: ", jsonError)
            return []
        }
    }
    
    
    
    /*
     
     //        video&eventType=[completed, live, upcoming]
     guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?type=video&part=snippet&maxResults=15&q=gaming,live,upcoming,stream&key,videogame=AIzaSyBhDDURoSMSMDrfal8Lse3at0pz0_euTv4") else {
     //guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&channelId=UCKqH_9mk1waLgBiL2vT5b9g&order=date&key=AIzaSyBhDDURoSMSMDrfal8Lse3at0pz0_euTv4") else {
     //guard let url = URL(string: "https://www.googleapis.com/youtube/v3/liveStreams?part=id%2C+snippet%2C+cdn%2C+status&key=AIzaSyBhDDURoSMSMDrfal8Lse3at0pz0_euTv4") else {
     //guard let url = URL(string: "https://www.googleapis.com/youtube/v3/channels?part=contentDetails,statistics,snippet&id=UCKqH_9mk1waLgBiL2vT5b9g&key=AIzaSyBhDDURoSMSMDrfal8Lse3at0pz0_euTv4") else {
     print("no url")
     return
     }
     guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
     print("no bundle")
     return
     }
     print("bundleIdentifier: ", bundleIdentifier)
     
     var request = URLRequest(url: url)
     request.addValue(bundleIdentifier, forHTTPHeaderField: "X-Ios-Bundle-Identifier")
     
     URLSession.shared.dataTask(with: request) { (data, response, error) in
     guard error == nil else {
     print(error)
     return
     }
     
     guard let data = data else {
     print("no data")
     return
     }
     do {
     let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
     print(json)
     }
     catch let jsonError {
     print(jsonError)
     return
     }
     }.resume()
     
     let suggestions: [Suggestion] = [
     Suggestion(badge: 0, color: .green, name: "Feed", state: .on),
     Suggestion(badge: 2, color: .red, name: "Ninja", state: .new),
     Suggestion(badge: 3, color: .blue, name: "3", state: .on),
     Suggestion(badge: 0, color: .orange, name: "4", state: .on),
     Suggestion(badge: 5, color: .on, name: "5", state: .off),
     Suggestion(badge: 1, color: .brown, name: "6", state: .off),
     Suggestion(badge: 0, color: .purple, name: "7", state: .on),
     Suggestion(badge: 8, color: .white, name: "8", state: .off),
     Suggestion(badge: 9, color: .cyan, name: "9", state: .off)
     ]
     completion(suggestions, nil)
     }
     }
     */
}

