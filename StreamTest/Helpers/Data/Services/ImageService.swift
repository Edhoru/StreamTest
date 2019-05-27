//
//  ImagesService.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/27/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()


class ImageService {
    
    var imageUrl: URL?
    
    func findImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        
        imageUrl = url
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(imageFromCache)
            return
        }
        
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            
            if response is HTTPURLResponse,
                let imageData = data,
                let imageToCache = UIImage(data: imageData) {
                if self.imageUrl == url {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                    completion(imageToCache)
                }
            } else {
                print("Couldn't get response code for some reason")
            }
        }
        
        downloadPicTask.resume()
    }
}
