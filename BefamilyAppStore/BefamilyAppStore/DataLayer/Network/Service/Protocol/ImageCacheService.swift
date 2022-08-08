//
//  ImageCacheService.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/07.
//

import UIKit

class ImageCacheService {

    static let shared = NSCache<NSString, UIImage>()
    static let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first

    static func saveData(image: UIImage?, url: URL) {
        guard let image = image else { return }
        
        let nextLastPath = url.pathComponents[url.pathComponents.count - 2]

        shared.setObject(image, forKey: nextLastPath as NSString)
        guard let pathURL = path else { return }

        let fileManager = FileManager()
        var filePath = URL(fileURLWithPath: pathURL)
        filePath.appendPathComponent(nextLastPath)

        guard !fileManager.fileExists(atPath: filePath.path) else { return }

        fileManager.createFile(atPath: filePath.path, contents: image.jpegData(compressionQuality: 0.5))
    }

    static func loadData(url: URL) -> UIImage? {
        let nextLastPath = url.pathComponents[url.pathComponents.count - 2]
        
        guard let cachedData = shared.object(forKey: nextLastPath as NSString) else {

            guard let pathURL = path else { return nil }
            let fileManager = FileManager()
            var filePath = URL(fileURLWithPath: pathURL)
            filePath.appendPathComponent(nextLastPath)

            if fileManager.fileExists(atPath: pathURL) {
                guard let imageData = try? Data(contentsOf: filePath) else { return nil }
                return UIImage(data: imageData)
            }
            return nil
        }

        return cachedData
    }
}
