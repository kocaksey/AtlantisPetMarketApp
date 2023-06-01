//
//  CustomProductCell.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 30.05.2023.
//

import UIKit
import SnapKit

class CustomProductCell: UICollectionViewCell {
    
    static let identifier = "myCell"
    let aciklamaLabel = UILabel()
    let productImage = UIImageView()
//    var stepper = UIStepper()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 25


        
        addSubview(aciklamaLabel)
        addSubview(productImage)
        
        productImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(60)
        }
        
        aciklamaLabel.numberOfLines = .zero
        aciklamaLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(80)
        }
        
        
        
//        stepper.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(500)
//            make.leading.equalToSuperview().offset(150)
//        }
//        stepper.clipsToBounds = true
//        stepper.layer.cornerRadius = 8
//        stepper.backgroundColor = .systemPink
//        stepper.setIncrementImage(UIImage(systemName: "arrow.up.heart.fill"), for: .normal)
//        stepper.setDecrementImage(UIImage(systemName: "arrow.down.heart.fill"), for: .normal)
//        stepper.stepValue = 5
//        stepper.minimumValue = 0
//        stepper.maximumValue = 50
//        stepper.addTarget(self, action: #selector(changeNumber), for: .valueChanged)
        
        
    }
//    @objc func changeNumber(){
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
