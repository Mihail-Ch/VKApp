//
//  PhotoCollectionViewCell.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    func configure(with photoUrl: URL?) {
        self.userPhoto.kf.setImage(with: photoUrl)
    }
    
}
 
