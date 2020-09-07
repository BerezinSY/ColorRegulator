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
    
    var redValue: Float?
    var greenValue: Float?
    var blueValue: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setupValues(for: redSlider, greenSlider, blueSlider)
        setupValues(for: redTF, greenTF, blueTF)
        setupValues(for: redLabel, greenLabel, blueLabel)
        setupColorForViewBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.view.endEditing(true)
        view.endEditing(true)
    }
    
    @IBAction func save(_ sender: Any) {
        delegate.changeColor(by: colorView.backgroundColor)
        delegate.saveColor(from: redSlider, greenSlider, blueSlider)
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) { dismiss(animated: true) }

    
    // MARK: - Change color by sliders

    @IBAction func dragSliders(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            redLabel.text = string(from: sender)
            redTF.text = string(from: sender)
        case 1:
            greenLabel.text = string(from: sender)
            greenTF.text = string(from: sender)
        case 2:
            blueLabel.text = string(from: sender)
            blueTF.text = string(from: sender)
        default: break
        }
        setupColorForViewBackground()
    }
    
    private func setupValues(for sliders: UISlider...) {
        sliders.forEach { (slider) in
            switch slider.tag {
            case 0 where redValue != nil:
                slider.value = redValue!
            case 1 where greenValue != nil:
                slider.value = greenValue!
            case 2 where blueValue != nil:
                slider.value = blueValue!
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
            displayP3Red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setupColorFromTextFields() {
        redValue = Float(redTF.text ?? "")!
        greenValue = Float(greenTF.text ?? "")!
        blueValue = Float(blueTF.text ?? "")!
        setupValues(for: redSlider, greenSlider, blueSlider)
        setupValues(for: redLabel, greenLabel, blueLabel)
        setupColorForViewBackground()
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
        print("func shouldChangeCharacters")
        return targetLength.length <= maxLength
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        setupColorFromTextFields()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupColorFromTextFields()
        save(saveButton!)
        return true
    }
}
