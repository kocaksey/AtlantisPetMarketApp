//
//  BasketVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 29.04.2023.
//

import UIKit
import SnapKit

class BasketVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let basketImage = UIImageView()
        basketImage.image = UIImage(named: "colorfulBasket")
        view.addSubview(basketImage)
        basketImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(250)
            make.width.height.equalTo(200)
            
        }
        
        let infoLabel = UILabel()
        infoLabel.text = "Sepetinizde ürün bulunmamaktadır."
        infoLabel.font = UIFont(name: "Helvetica", size: 22)
        infoLabel.textAlignment = .center
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(basketImage.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
        
        }
        
        
    

    }
    


}
