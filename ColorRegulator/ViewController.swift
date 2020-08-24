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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupValues()
        setViewColor()
        configureView()

    }
    
    // MARK: Slider actions
    @IBAction func dragSliders(_ sender: UISlider) {
        setViewColor()
        setupValues()
    }
    
    // MARK: Configuration
    private func setupValues() {
        redColorValue.text = String(format: "%.2f", redColorSlider.value)
        greenColorValue.text = String(format: "%.2f", greenColorSlider.value)
        blueColorValue.text = String(format: "%.2f", blueColorSlider.value)
    }
    
    private func setViewColor() {
        colorView.backgroundColor = UIColor(
            displayP3Red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1)
    }
    
    private func configureView() {
        colorView.layer.cornerRadius = colorView.frame.width / 35
    }
}
