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

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        let height = view.frame.size.height
        let width = view.frame.size.width

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 13, bottom: 20, right: 13)
        layout.itemSize = CGSize(width: width/2 - 20, height: height/4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
 
        

        let vc1 = UIViewController()
        vc1.view.backgroundColor = .white

//
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        vc1.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: vc1.view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: vc1.view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: vc1.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: vc1.view.bottomAnchor)
        ])
        
        
        let vc2 = UIViewController()
        let vc3 = UIViewController()
        
        vc1.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "1.circle"), tag: 0)
        vc2.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "2.circle"), tag: 1)
        vc3.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "3.circle"), tag: 2)
        viewControllers = [vc1, vc2, vc3]

        selectedIndex = 1

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        return cell
    }
    


}

extension SecondVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Category.init().categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = Category.init().categories[indexPath.row]
        content.image = UIImage(named: Category.init().images[indexPath.row])
        cell.contentConfiguration = content
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let collectionVC = SecondVC()
        
        if indexPath.row == 0 {
            let catVC = CatMenu()
            catVC.modalPresentationStyle = .fullScreen
            present(catVC, animated: true)
        } else if indexPath.row == 1 {
            let dogVC = DogMenu()
            dogVC.modalPresentationStyle = .fullScreen
            present(dogVC, animated: true)
        } else if indexPath.row == 2 {
            let birdVC = BirdMenu()
            birdVC.modalPresentationStyle = .fullScreen
            present(birdVC, animated: true)
            
        }
        
        navigationController?.pushViewController(collectionVC, animated: true)
    }
    
    
}
