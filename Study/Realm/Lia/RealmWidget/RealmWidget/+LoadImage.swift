//
//  +LoadImage.swift
//  RealmWidget
//
//  Created by Lia on 2021/11/02.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func load(url: String?) {
        let url = URL(string: url!)
        self.kf.setImage(with: url) { result in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self.image = UIImage(named: "LoadFail.jpg")
            }
        }
    }

}

extension String {
    
    func loadImage() -> UIImage? {
        let imageView = UIImageView()
        imageView.load(url: self)
        
        return imageView.image
    }

}
