//
//  AccountEditVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 3.05.2023.
//

import UIKit

class AccountEditVC: UIViewController {
    
    let nameField = UITextField()
    let addressBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nameField.placeholder = "Ad ve Soyad giriniz..."
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.black.cgColor
        view.addSubview(nameField)
        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().inset(35)
            make.height.equalTo(50)
        }
        
        addressBtn.backgroundColor = .systemBlue
        addressBtn.setTitle("Adresimi Belirle", for: .normal)
        addressBtn.layer.cornerRadius = 5
        addressBtn.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        view.addSubview(addressBtn)
        addressBtn.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(60)
        }


    }
    @objc func openMap(){
        let mapVC = MapVC()
        present(mapVC, animated: true)
        
    }
    


}
