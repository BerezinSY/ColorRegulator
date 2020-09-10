//
//  MainVC.swift
//  ColorRegulator
//
//  Created by BEREZIN Stanislav on 05.09.2020.
//  Copyright © 2020 BEREZIN Stanislav. All rights reserved.
//

import UIKit

protocol ColorManagement {
    func changeColor(by color: UIColor?)
}

class MainScreenVC: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let navigationVC = segue.destination as? UINavigationController,
            let preferencesVC = navigationVC.topViewController as? PreferencesVC
            else {
                return
        }
        
        preferencesVC.delegate = self
        preferencesVC.color = view.backgroundColor
    }
}

extension MainScreenVC: ColorManagement {
    
    func changeColor(by color: UIColor?) {
        view.backgroundColor = color
    }
}
