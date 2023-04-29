//
//  FirstMenu.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 29.04.2023.
//

import UIKit
import SnapKit

class FirstMenu: UIViewController {
    let tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }

    }
    



}


extension FirstMenu : UITableViewDataSource, UITableViewDelegate {
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
        //
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            print("asd")
            let catVC = CatMenu()
            self.navigationController?.pushViewController(catVC, animated: true)
        } else if indexPath.row == 1 {
            let dogVC = DogMenu()
            self.navigationController?.pushViewController(dogVC, animated: true)

        } else if indexPath.row == 2 {
            let birdVC = BirdMenu()
            self.navigationController?.pushViewController(birdVC, animated: true)

            
        } else if indexPath.row == 3 {
            let fishMenu = FishMenu()
            self.navigationController?.pushViewController(fishMenu, animated: true)

            
        }else if indexPath.row == 4 {
            let rodentMenu = RodentMenu()
            self.navigationController?.pushViewController(rodentMenu, animated: true)

            
        }else if indexPath.row == 5 {
            let reptileMenu = ReptileMenu()
            self.navigationController?.pushViewController(reptileMenu, animated: true)

            
        }
        
        
//        navigationController?.pushViewController(collectionVC, animated: true)
    }
    
    
}
