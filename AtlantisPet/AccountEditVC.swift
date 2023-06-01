//
//  AccountEditVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 3.05.2023.
//

import UIKit
import CoreData
import SnapKit

class AccountEditVC: UIViewController {
    
    let nameField = UITextField()
    let phoneField = UITextField()
    let addressBtn = UIButton()
    let addressLabel = UILabel()
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let address = fetchAddressFromCoreData() {
            addressLabel.text = "Address: \(address)"
        } else {
            addressLabel.text = "No address found."
        }
        

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)


        NotificationCenter.default.addObserver(self, selector: #selector(handleAddressUpdate), name: .addressUpdated, object: nil)

        view.backgroundColor = .white
        
        nameField.placeholder = "Ad ve Soyad giriniz..."
        nameField.layer.borderWidth = 1
        nameField.layer.cornerRadius = 5
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.textAlignment = .center
        view.addSubview(nameField)
        nameField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().inset(35)
            make.height.equalTo(50)
        }
        
        phoneField.placeholder = "Telefon Numarasını giriniz..."
        phoneField.layer.borderWidth = 1
        phoneField.layer.cornerRadius = 5
        phoneField.layer.borderColor = UIColor.black.cgColor
        phoneField.textAlignment = .center
        view.addSubview(phoneField)
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(20)
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
            make.top.equalTo(phoneField.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(60)
        }
        
        addressLabel.backgroundColor = .systemBlue
        addressLabel.numberOfLines = 0
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(80)
            make.top.equalTo(addressBtn.snp.bottom).offset(40)
        }


    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func handleAddressUpdate(notification: Notification) {
        if let address = notification.userInfo?["address"] as? String {
            addressLabel.text = "Address: \(address)"
        } else {
            addressLabel.text = "No address found."
        }
    }
    deinit {
            NotificationCenter.default.removeObserver(self)
        }

    @objc func openMap(){
        let mapVC = MapVC()
//        mapVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true)
        
    }

    
    func fetchAddressFromCoreData() -> String? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let lastLocation = results.last as? NSManagedObject,
               let address = lastLocation.value(forKey: "address") as? String {
                return address
            }
        } catch let error as NSError {
            print("Could not fetch address from Core Data. \(error), \(error.userInfo)")
        }
        
        return nil
    }

    


}
