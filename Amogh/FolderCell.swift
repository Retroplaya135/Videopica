//
//  FolderCell.swift
//  Amogh
//
//  Created by Amogh on 13/06/2020.
//  Copyright © 2020 Amogh. All rights reserved.
//

import UIKit

class FolderCell: UICollectionViewCell {
    
    @IBOutlet weak var folderImage:UIImageView!
    @IBOutlet weak var folderTitle:UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
            self.layer.cornerRadius = 10
              self.layer.borderWidth = 1.0
              self.layer.borderColor = UIColor.lightGray.cgColor
              self.layer.backgroundColor = UIColor.white.cgColor
              self.layer.shadowColor = UIColor.gray.cgColor
              self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
              self.layer.shadowRadius = 2.0
              self.layer.shadowOpacity = 1.0
              self.layer.masksToBounds = false
    }

    
}
