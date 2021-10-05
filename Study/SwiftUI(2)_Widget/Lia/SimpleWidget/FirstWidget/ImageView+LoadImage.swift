//
//  ImageView+LoadImage.swift
//  SimpleWidget
//
//  Created by Lia on 2021/10/05.
//

import UIKit
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
