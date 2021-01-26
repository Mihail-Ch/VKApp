//
//  TableViewCell.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "TableViewCell", bundle: nil)
    static let reuseId = "TableViewCell"
    
    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var label: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewAvatar.layer.cornerRadius = viewAvatar.frame.height / 2
        avatar.layer.cornerRadius = avatar.frame.height / 2
    }
    
    func configure(name: String, avatar: UIImage) {
        self.avatar.image = avatar
        self.label.text = name
    }
    
}
