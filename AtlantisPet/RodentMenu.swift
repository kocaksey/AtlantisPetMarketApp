//
//  DogMenu.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 27.04.2023.
//

import UIKit

class RodentMenu: UIViewController  {

    
    var appArray = ["Mamalar","Konserveler","Kum","Ödül Mamaları","Tasmalar","Çantalar","Tuvalet","Tırmalama","Oyuncaklar"]

    var myCollectionView:UICollectionView?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 13, bottom: 20, right: 13)
        layout.itemSize = CGSize(width: width/2 - 20, height: height/8)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(CatMenuCollectionCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = .white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        view.addSubview(myCollectionView!)
        
        let backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        // Set the created UIBarButtonItem as the leftBarButtonItem of the navigationItem of the current view controller
        navigationItem.leftBarButtonItem = backButton
        

    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    



}

extension RodentMenu : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailsVC()
//        present(vc, animated: true)
//        vc.appImage.image = appArray[indexPath.row].image
//        vc.appName.text = appArray[indexPath.row].appName
//        vc.category.text = appArray[indexPath.row].category
//        vc.url.text = appArray[indexPath.row].url
    }
 
    
}
extension RodentMenu : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CatMenuCollectionCell
        myCell.nameLabel.text = appArray[indexPath.row]
        return myCell
    }
    
    
    
    
}

