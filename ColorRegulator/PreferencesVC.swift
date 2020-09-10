//
//  ViewController.swift
//  ColorRegulator
//
//  Created by BEREZIN Stanislav on 22.08.2020.
//  Copyright © 2020 BEREZIN Stanislav. All rights reserved.
//

import UIKit

class PreferencesVC: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var delegate: ColorManagement!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        
        colorView.backgroundColor = color
        
        setupValues(for: redSlider, greenSlider, blueSlider)
        setupValues(for: redLabel, greenLabel, blueLabel)
        setupValues(for: redTF, greenTF, blueTF)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        delegate.changeColor(by: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) { dismiss(animated: true) }

    
    // MARK: - Change color by sliders

    @IBAction func dragSliders(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            setupValues(for: redLabel)
            setupValues(for: redTF)
        case 1:
            setupValues(for: greenLabel)
            setupValues(for: greenTF)
        case 2:
            setupValues(for: blueLabel)
            setupValues(for: blueTF)
        default: break
        }
        setupColorForViewBackground()
    }
    
    private func setupValues(for sliders: UISlider...) {
        let ciColor = CIColor(color: color)
        sliders.forEach { (slider) in
            switch slider.tag {
            case 0: redSlider.value = Float(ciColor.red)
            case 1: greenSlider.value = Float(ciColor.green)
            case 2: blueSlider.value = Float(ciColor.blue)
            default: break
            }
        }
    }
    
    private func setupValues(for labels: UILabel...) {
        labels.forEach { (label) in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func setupValues(for textFields: UITextField...) {
        textFields.forEach { (textField) in
            switch textField.tag {
            case 0: redTF.text = string(from: redSlider)
            case 1: greenTF.text = string(from: greenSlider)
            case 2: blueTF.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func setupColorForViewBackground() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension PreferencesVC: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        let maxLength = 4
        let currentLength: NSString = textField.text! as NSString
        let targetLength: NSString = currentLength.replacingCharacters(
            in: range,
            with: string) as NSString
        return targetLength.length <= maxLength
    }

    func textFieldDidEndEditing(_ textField: UITextField,
                                reason: UITextField.DidEndEditingReason) {
        redSlider.value = Float(redTF.text ?? "")!
        greenSlider.value = Float(greenTF.text ?? "")!
        blueSlider.value = Float(blueTF.text ?? "")!
        setupColorForViewBackground()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
