//
//  SecondVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 26.04.2023.
//

import UIKit
import SnapKit

class SecondVC:  UITabBarController, UICollectionViewDelegate, UICollectionViewDataSource  {
    



    var data: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white


        
        setupVC()
        
        let height = view.frame.size.height
        let width = view.frame.size.width

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 13, bottom: 20, right: 13)
        layout.itemSize = CGSize(width: width/2 - 20, height: height/4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
//        let vc1 = UIViewController()
//        let vc2 = UIViewController()
//        let vc3 = UIViewController()
        


//        vc1.view.backgroundColor = .white
//
//
////
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = .clear
//        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        vc1.view.addSubview(collectionView)
//
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: vc1.view.leadingAnchor),
//            collectionView.topAnchor.constraint(equalTo: vc1.view.topAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: vc1.view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: vc1.view.bottomAnchor)
//        ])
        
        
 
        
//        vc1.tabBarItem = UITabBarItem(title: "Kategoriler", image: UIImage(systemName: "1.circle"), tag: 0)
//        vc2.tabBarItem = UITabBarItem(title: "Sepetim", image: UIImage(systemName: "2.circle"), tag: 1)
//        vc3.tabBarItem = UITabBarItem(title: "Hesabım", image: UIImage(systemName: "3.circle"), tag: 2)
//        viewControllers = [vc1, vc2, vc3]
//
//
//
//        selectedIndex = 1

        
        
    }
    
    func templateNavController (unselected : UIImage, selected: UIImage, title : String, viewController: UIViewController, selectedTintColor : UIColor) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = unselected
        nav.tabBarItem.selectedImage = selected
        nav.tabBarItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        tabBar.tintColor = selectedTintColor
        tabBar.backgroundColor = .systemGray
        
        return nav
        
   
    }
    
    func setupVC() {
        viewControllers = [templateNavController(unselected: UIImage(systemName: "house")!, selected: UIImage(systemName: "house.fill")!, title: "Kategoriler", viewController: FirstMenu(),selectedTintColor: .systemBlue), templateNavController(unselected: UIImage(systemName: "basket")!, selected: UIImage(systemName: "basket")!, title: "Sepetim", viewController: BasketVC(),selectedTintColor: .systemBlue), templateNavController(unselected: UIImage(systemName: "person")!, selected: UIImage(systemName: "person.fill")!, title: "Hesabım", viewController: AccountVC(),selectedTintColor: .systemBlue)]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        return cell
    }
    


}


