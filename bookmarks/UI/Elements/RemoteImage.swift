//
//  RemoteImage.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 04/03/25.
//

import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var image: UIImage? = nil
        var state = LoadState.loading
        var imageCache = ImageCache.getImageCache()
        
        init(url: String?) {
            guard let url =  url else {
                self.state = .failure
                return
            }
            
            let replacedURL = url.replacingOccurrences(of: " ", with: "%20")
            guard let parsedURL = URL(string: replacedURL) else {
                fatalError("Invalid URL: \(url)")
            }
            
            if loadImageFromCache(parsedURL: "\(parsedURL)"){
                self.state = .success
                return
            }
            
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.image = UIImage(data: data)
                    if let image = self.image {
                        self.imageCache.set(forKey: "\(parsedURL)", image: image)
                    }
                    self.state = .success
                } else {
                    self.state = .failure
                }
                
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
        
        func loadImageFromCache(parsedURL: String) -> Bool {
            guard let cacheImage = imageCache.get(forKey: parsedURL) else {
                return false
            }
            
            self.image = cacheImage
            return true
        }
    }
    
    @StateObject private var loader: Loader
    var loading: Image?
    var onFailure: ()->Image
    
    var body: some View {
        VStack{
            selectImage()
        }
    }
    
    init(url: String?, loading: Image? = nil, onFailure: @escaping ()->Image) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.onFailure = onFailure
    }
    
    private func selectImage() -> Image? {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return onFailure()
        default:
            if let image = loader.image {
                return Image(uiImage: image)
                    .resizable()
            } else {
                return onFailure()
            }
        }
    }
}
