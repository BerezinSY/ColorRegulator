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
    func saveColor(from sliders: UISlider...)
}

class MainScreenVC: UIViewController {
    
    private var redColorValue: Float?
    private var greenColorValue: Float?
    private var blueColorValue: Float?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let navigationVC = segue.destination as? UINavigationController,
            let preferencesVC = navigationVC.topViewController as? PreferencesVC
            else {
                return
        }
        
        preferencesVC.delegate = self
        preferencesVC.redValue = redColorValue
        preferencesVC.greenValue = greenColorValue
        preferencesVC.blueValue = blueColorValue
    }
}

extension MainScreenVC: ColorManagement {
    
    func changeColor(by color: UIColor?) {
        view.backgroundColor = color
    }
    
    func saveColor(from sliders: UISlider...) {
        sliders.forEach { (slider) in
            switch slider.tag {
            case 0: redColorValue = slider.value
            case 1: greenColorValue = slider.value
            case 2: blueColorValue = slider.value
            default: break
            }
        }
    }
}
