//
//  VehiclePageController.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit
import RealmSwift
class VehiclePageController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var background: UIView!
    
    let helper = RealmFunctions()
    var carItems = [CarModel]()
    let realm = try! Realm()
//    let searchController = UISearchController(searchResultsController: nil)
    var searching = false
    var searchedCar = [CarModel]()
//    var categoryCounts = [String: Int]()
    var categorySelectedIndexPath: IndexPath?
    var originalCarItems = [CarModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layerConfig()
        fetchItems()
        helper.getFilePath()
        collection.register(UINib(nibName: "CarListCell", bundle: nil),forCellWithReuseIdentifier: "CarListCell")
        originalCarItems = carItems
    }
    
    
    @IBAction func searchButton(_ sender: UITextField) {
        if let searchText = sender.text, !searchText.isEmpty {
            searching = true
            searchedCar = carItems.filter { car in
                if let model = car.model {
                    return model.lowercased().contains(searchText.lowercased())
                }
                return false
            }
        } else {
            searching = false
            searchedCar.removeAll()
        }
        collection.reloadData()
    }
    
    
}
extension VehiclePageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searching {
            return searchedCar.count
        } else {
            return carItems.count
        }
    }
    
    //Cell configuration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarListCell", for: indexPath) as! CarListCell
        
        if searching {
            cell.carNameLabel.text = searchedCar[indexPath.row].name
            cell.carModelLabel.text = searchedCar[indexPath.row].model
            cell.carImage.image = UIImage(named: searchedCar[indexPath.row].model ?? "emptyCar")
            cell.carPriceLabel.text = searchedCar[indexPath.row].price
            cell.carEngineLabel.text = searchedCar[indexPath.row].engine
            
        } else {
            cell.carNameLabel.text = carItems[indexPath.item].name
            cell.carModelLabel.text = carItems[indexPath.item].model
            cell.carImage.image = UIImage(named: carItems[indexPath.item].model ?? "emptyCar")
            cell.carEngineLabel.text = carItems[indexPath.item].engine
            cell.carPriceLabel.text = carItems[indexPath.item].price
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width * 0.855, height: 355)
    }
    
    // Header configuration
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CarCategoryHeader.self)", for: indexPath) as! CarCategoryHeader
        //        header.carItems = carItems
        //        header.originalCarItems = carItems
        header.didSelectCategoryCallback = { category in
            let filteredCars = self.originalCarItems.filter {$0.category == category}
            self.carItems = filteredCars
            self.collection.reloadData()
            
        }
        //        header.backgroundColor = .orange
        return header
    }
}

//MARK: Functions(Search layerConfig, Fetching)
extension VehiclePageController {
    func layerConfig() {
        background.layer.cornerRadius = 30
        background.layer.masksToBounds = true
    }
    
    func fetchItems() {
        carItems.removeAll()
        let data = realm.objects(CarModel.self)
        carItems.append(contentsOf: data)
        collection.reloadData()
    }
}
