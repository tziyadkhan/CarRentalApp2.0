//
//  AccountPageController.swift
//  CarRentalApp2.0
//
//  Created by Ziyadkhan on 30.10.23.
//

import UIKit
import Lottie

class AccountPageController: UIViewController {

    @IBOutlet weak var accountAnimation: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountAnimation.play()
        accountAnimation.loopMode = .autoReverse
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
