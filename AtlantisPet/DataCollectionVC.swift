//
//  DataCollectionVC.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 29.05.2023.
//

import UIKit
import SnapKit
import Firebase
import SwiftCSV


class DataCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView : UICollectionView?

    var models: [DataModelElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = view.frame.size.height
        let width = view.frame.size.width
        
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 13, bottom: 20, right: 13)
        layout.itemSize = CGSize(width: width/2 - 20, height: height/4)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(CustomProductCell.self, forCellWithReuseIdentifier: CustomProductCell.identifier)
        collectionView?.backgroundColor = UIColor.systemBlue
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        view.addSubview(collectionView!)
        
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                models = try decoder.decode([DataModelElement].self, from: data)
                print(models)
            } catch {
                print("Failed to parse JSON: \(error)")
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomProductCell.identifier, for: indexPath) as! CustomProductCell
        cell.productImage.image = UIImage(named: "food")
        cell.aciklamaLabel.text = models[indexPath.row].açıklaması
        
        return cell
 
    }



}
