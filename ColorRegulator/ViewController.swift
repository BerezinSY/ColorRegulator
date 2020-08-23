//
//  ViewController.swift
//  ColorRegulator
//
//  Created by BEREZIN Stanislav on 22.08.2020.
//  Copyright © 2020 BEREZIN Stanislav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: View outlets
    @IBOutlet weak var colorView: UIView!
    
    // MARK: Color value outlets
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    
    // MARK: Slider outlets
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    // MARK: Slider limits
    private let minimumValue: Float = 0
    private let maximumValue: Float = 1
    private let initialValue: Float = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        congigureColorView()
        configureSliders()
        setStartPreferences()

    }
    
    // MARK: Slider actions
    @IBAction func dragRedColorSlider(_ sender: UISlider) {
        redColorValue.text = String(format: "%.2f", redColorSlider.value)
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1)
    }
    @IBAction func dragGreenColorSlider(_ sender: UISlider) {
        greenColorValue.text = String(format: "%.2f", greenColorSlider.value)
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1)
    }
    @IBAction func dragBlueColorSlider(_ sender: UISlider) {
        blueColorValue.text = String(format: "%.2f", blueColorSlider.value)
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1)
    }
    
    // MARK: Reset
    @IBAction func pressResetButton(_ sender: UIButton) {
        
        redColorSlider.value = initialValue
        greenColorSlider.value = initialValue
        blueColorSlider.value = initialValue
        setStartPreferences()
    }
    
    // MARK: Configuration
    private func congigureColorView() {
        colorView.layer.cornerRadius = colorView.frame.width / 35
    }
    
    private func configureSliders() {
        redColorSlider.minimumValue = minimumValue
        redColorSlider.maximumValue = maximumValue
        
        greenColorSlider.minimumValue = minimumValue
        greenColorSlider.maximumValue = maximumValue
        
        blueColorSlider.minimumValue = minimumValue
        blueColorSlider.maximumValue = maximumValue
    }
    
    private func setStartPreferences() {
        redColorValue.text = String(format: "%.2f", initialValue)
        greenColorValue.text = String(format: "%.2f", initialValue)
        blueColorValue.text = String(format: "%.2f", initialValue)
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redColorSlider.value),
                            green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1)
    }
}

