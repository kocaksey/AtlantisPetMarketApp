//
//  AccountEditVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 3.05.2023.
//

import UIKit
import CoreData

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
//        mapVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchSavedLocations()

    }
    
    func fetchSavedLocations() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Location>(entityName: "Location")
        
        do {
            let locations = try context.fetch(fetchRequest)
            if locations.isEmpty {
                print("No saved locations")
            } else {
                for location in locations {
                    print("Saved location: \(location.latitude), \(location.longitude), \(location.address ?? "")")
                }
                let addressInfo = UILabel()
                addressInfo.text = "Adres Seçildi."
                addressInfo.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(addressBtn.snp.bottom).offset(50)
                    make.width.equalTo(50)
                }
                
            }
        } catch let error {
            print("Error fetching saved locations: \(error.localizedDescription)")
        }
    }
    


}
