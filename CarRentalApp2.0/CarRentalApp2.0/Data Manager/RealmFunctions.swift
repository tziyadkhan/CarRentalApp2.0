//
//  RealmFunctions.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import Foundation
import RealmSwift

class RealmFunctions {
    let realm = try! Realm()
    func getFilePath() {
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
    
}
