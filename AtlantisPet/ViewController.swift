//
//  ViewController.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 26.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let atlantisImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    func setupUI(){
        view.backgroundColor = .white

        
        
        
        view.addSubview(atlantisImage)
        atlantisImage.image = UIImage(named: "atlantis")
        atlantisImage.snp.makeConstraints { make in
            make.height.width.equalTo(350)
            make.top.equalToSuperview().offset(75)
            make.centerX.equalToSuperview()
        }
        let loginBtn = UIButton()
        view.addSubview(loginBtn)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.layer.cornerRadius = 5
        loginBtn.addTarget(self, action: #selector(goMenu), for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(atlantisImage.snp.bottom).offset(50)
            make.width.equalTo(150)
            make.height.equalTo(75)
        }
        
    }
    
    @objc func goMenu(){
        let secondVC = SecondVC()
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true)
        
    }


}

