//
//  ImageView.swift
//  NetworkEngine
//
//  Created by Kanwar Zorawar Singh Rana on 1/28/22.
//

import UIKit

public extension UIImageView {
    func loadImage(_ url: URL, with size: CGSize? = .none) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        ServiceSession.shared.session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
