//
//  SearchPageController.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit
import RealmSwift
class SearchPageController: UIViewController {

    @IBOutlet weak var searchBackgroundView: UIView!
    @IBOutlet weak var carListCollection: UICollectionView!
    let helper = RealmFunctions()
    var carItems = [CarModel]()
    let realm = try! Realm()
    var searching = false
    var searchedCar = [CarModel]()
    var backupCars = [CarModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.getFilePath()
        layerConfig()
        fetchItems()
        carListCollection.register(UINib(nibName: "CarListCell", bundle: nil), forCellWithReuseIdentifier: "CarListCell")
        backupCars = carItems
    }
    
    @IBAction func search(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            searching = true
            carItems = carItems.filter { car in
                if let model = car.model {
                    return model.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            carItems.removeAll()
            carItems = backupCars
            
        }
        carListCollection.reloadData()
        }
}
extension SearchPageController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if searching {
//            return searchedCar.count
//        } else {
            return carItems.count
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarListCell", for: indexPath) as! CarListCell
//        if searching {
//            cell.addItemToCell(name: searchedCar[indexPath.row].name,
//                               model: searchedCar[indexPath.row].model,
//                               price: searchedCar[indexPath.row].price,
//                               engine: searchedCar[indexPath.row].engine)
//            
//        } else {
            cell.addItemToCell(name: carItems[indexPath.row].name,
                               model: carItems[indexPath.row].model,
                               price: carItems[indexPath.row].price,
                               engine: carItems[indexPath.row].engine)
//        }
        return cell
    }
    
}

//MARK: Functions(searchLayerConfig, Fetching)
extension SearchPageController {
    func layerConfig() {
        searchBackgroundView.layer.cornerRadius = 30
        searchBackgroundView.layer.masksToBounds = true
    }
    
    func fetchItems() {
        carItems.removeAll()
        let data = realm.objects(CarModel.self)
        carItems.append(contentsOf: data)
        carListCollection.reloadData()
    }
}
