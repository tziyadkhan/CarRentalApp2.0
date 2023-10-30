//
//  CarCategoryHeader.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit
import RealmSwift

class CarCategoryHeader: UICollectionReusableView {
    
    @IBOutlet weak var carCategoryCollection: UICollectionView!
    let helper = RealmFunctions()
//    var carItems = [CarModel]()
    let realm = try! Realm()
    var categoryCounts = [String: Int]()
    var categorySelectedIndexPath: IndexPath?
//    var originalCarItems = [CarModel]()
    var didSelectCategoryCallback: ((String) -> Void)?
    
}

extension CarCategoryHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for category in CarCategory.allCases {
            let categoryCars = realm.objects(CarModel.self).filter("category = %@", category.rawValue)
            categoryCounts[category.rawValue] = categoryCars.count
        }
        return categoryCounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCategoryCell", for: indexPath) as! CarCategoryCell
        let category = CarCategory.allCases[indexPath.item]
        cell.carCategoryName.text = category.rawValue
        cell.carCategoryImage.image = UIImage(named: category.rawValue)
        
        if indexPath == categorySelectedIndexPath {
            // Apply selected appearance
            cell.background.backgroundColor = .blue
            cell.carCategoryName.textColor = .white
            cell.carCategoryCount.textColor = .white
        } else {
            // Apply default appearance
            cell.background.backgroundColor = .white
            cell.carCategoryName.textColor = .black
            cell.carCategoryCount.textColor = .lightGray
        }
        
        if let count = categoryCounts[category.rawValue] {
            cell.carCategoryCount.text = "\(count)"
        } else {
            cell.carCategoryCount.text = "0"
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = CarCategory.allCases[indexPath.item]
//        let filteredCars = carItems.filter{ $0.category == category.rawValue }
        
        if let previousIndexPath = categorySelectedIndexPath {         // Deselect the previously selected cell and reset its background color
            collectionView.deselectItem(at: previousIndexPath, animated: true)
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CarCategoryCell {
                previousCell.background.backgroundColor = .white // Change to the default background color
                previousCell.carCategoryName.textColor = .black
                previousCell.carCategoryCount.textColor = .lightGray
            }
        }
        categorySelectedIndexPath = indexPath // Update the selected index path
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CarCategoryCell {
            // Change the elements' colors of the newly selected cell
            selectedCell.background.backgroundColor = .blue
            selectedCell.carCategoryName.textColor = .white
            selectedCell.carCategoryCount.textColor = .white
        }
        didSelectCategoryCallback?(category.rawValue)
        carCategoryCollection.reloadData()
//        print("Selected category: \(category)")
//        print("Filtered Cars: \(filteredCars)")
//        print("Normal List: \(carItems)")
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 200, height: collectionView.frame.height)
    }
}
