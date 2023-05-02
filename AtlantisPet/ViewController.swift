//
//  ViewController.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 26.04.2023.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController {
    
    let atlantisImage = UIImageView()
    let phoneNumberTextField = UITextField()
    let verificationCodeTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // In your login view controller
    @objc func sendVerificationCode() {
        guard let phoneNumber = phoneNumberTextField.text else { return }
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Save verification ID and prompt user to enter verification code
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
        }
    }

    @objc func signInWithVerificationCode() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID"),
            let verificationCode = verificationCodeTextField.text else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("success")
                self.goMenu()
            }
        }
    }

    func setupUI(){
        
        view.addSubview(atlantisImage)
        atlantisImage.image = UIImage(named: "atlantis")
        atlantisImage.snp.makeConstraints { make in
            make.height.width.equalTo(350)
            make.top.equalToSuperview().offset(75)
            make.centerX.equalToSuperview()
        }
        
        phoneNumberTextField.placeholder = "Phone Number.."
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(atlantisImage.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().inset(75)
            make.width.equalTo(50)
        }
        
        verificationCodeTextField.placeholder = "Verification Code.."
        view.addSubview(verificationCodeTextField)
        verificationCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().inset(75)
            make.width.equalTo(50)
        }

        view.backgroundColor = .white

        let loginBtn = UIButton()
        view.addSubview(loginBtn)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.layer.cornerRadius = 5
        loginBtn.addTarget(self, action: #selector(signInWithVerificationCode), for: .touchUpInside)
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(verificationCodeTextField.snp.bottom).offset(50)
            make.width.equalTo(150)
            make.height.equalTo(75)
        }
        
        let sendSMSBtn = UIButton()
        view.addSubview(sendSMSBtn)
        sendSMSBtn.setTitle("Send Code", for: .normal)
        sendSMSBtn.backgroundColor = .systemBlue
        sendSMSBtn.layer.cornerRadius = 5
        sendSMSBtn.addTarget(self, action: #selector(sendVerificationCode), for: .touchUpInside)
        sendSMSBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtn.snp.bottom).offset(50)
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

