//
//  CatMenuCollectionCell.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 27.04.2023.
//

import UIKit

class CatMenuCollectionCell: UICollectionViewCell {
    

    
    var nameLabel : UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.clipsToBounds = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        return nameLabel

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        self.layer.cornerRadius = 25
        
        let borderLayer = CALayer()
        borderLayer.frame = bounds
        borderLayer.borderWidth = 0
        borderLayer.cornerRadius = 25
        borderLayer.borderColor = UIColor.gray.cgColor
        layer.addSublayer(borderLayer)

        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width).inset(16)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(30)
        }
        
        
                

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    
}
