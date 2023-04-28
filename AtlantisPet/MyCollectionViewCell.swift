//
//  MyCollectionViewCell.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 26.04.2023.
//

import UIKit
import SnapKit

class MyCollectionViewCell: UICollectionViewCell {
    
    
    
    var imageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView

    }()
    
    var nameLabel : UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.clipsToBounds = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        return nameLabel

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 25
        
        //
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).inset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(8)
            make.height.equalTo(imageView.snp.width)
        }
        
        
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).inset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
