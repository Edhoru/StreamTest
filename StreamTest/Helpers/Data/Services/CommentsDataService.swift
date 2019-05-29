//
//  CommentsDataService.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/28/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation

class CommentsDataService {
    
    func get(_ completion: @escaping ([Comment], Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "comments", ofType: "json") else {
            fatalError("no file")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let comments = mapComment(from: data)
            completion(comments, nil)
        } catch {
            fatalError("no data")
        }
    }
    
    
    func mapComment(from data: Data) -> [Comment] {
        do {
            let comments = try JSONDecoder().decode([Comment].self, from: data)
            return comments
        } catch let jsonError {
            print("no json: ", jsonError)
            return []
        }
    }
    /*
    func getComments(videoId: String) {
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&maxResults=10&order=time&textFormat=plainText&videoId=Xp7t9fWz62Q&key=AIzaSyBhDDURoSMSMDrfal8Lse3at0pz0_euTv4") else {
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
    }*/
}
