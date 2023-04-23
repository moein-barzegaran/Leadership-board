import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    private let session = URLSession.shared
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
    }
    
    func load(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                let error = NSError(domain: "com.imagecache", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load image from URL"])
                completion(.failure(error))
                return
            }
            
            self.cache.setObject(image, forKey: url as NSURL, cost: data.count)
            
            completion(.success(image))
        }
        
        task.resume()
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
