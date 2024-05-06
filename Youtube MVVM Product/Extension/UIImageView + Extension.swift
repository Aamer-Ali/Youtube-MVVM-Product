//
//  UIImageView + Extension.swift
//  Youtube MVVM Product
//
//  Created by aamer sayyed on 05/05/24.
//

import UIKit
import Kingfisher

extension UIImageView{
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resouces = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resouces)
    }
}
