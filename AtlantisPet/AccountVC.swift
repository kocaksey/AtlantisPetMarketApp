//
//  AccountVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 2.05.2023.
//

import UIKit
import SnapKit
import CoreData

class AccountVC: UIViewController{
    
    var userName = UILabel()
    var userAddress = UILabel()
    var userNumber = UILabel()
    var editBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
    }
    
 
    func setupUI(){
        userNumber.text = "telefon no"
        view.addSubview(userNumber)
        userNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        userName.text = "İsimm Soyisim"
        view.addSubview(userName)
        userName.snp.makeConstraints { make in
            make.top.equalTo(userNumber.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        userAddress.text = "Adres"
        view.addSubview(userAddress)
        userAddress.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        editBtn.backgroundColor = .systemBlue
        editBtn.setTitle("Profili Düzenle", for: .normal)
        editBtn.addTarget(self, action: #selector(openEditVC), for: .touchUpInside)
        view.addSubview(editBtn)
        editBtn.layer.cornerRadius = 8
        editBtn.snp.makeConstraints { make in
            make.top.equalTo(userAddress.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(60)
        }
        
        
        
        
    }
    

    
    @objc func openEditVC(){
        let editVC = AccountEditVC()
        present(editVC, animated: true)
        
    }
    




    



    

    


}
