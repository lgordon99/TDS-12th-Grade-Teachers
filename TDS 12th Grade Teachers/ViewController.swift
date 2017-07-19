//
//  ViewController.swift
//  TDS 12th Grade Teachers
//
//  Created by Lucia Gordon on 7/18/17.
//  Copyright © 2017 Lucia Gordon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: Label Declarations
    let titleLabel = UILabel()
    let dayLabel = UILabel()
    let periodLabel = UILabel()
    let availabilityLabel = UILabel()
    
    //MARK: Slider Declarations
    let daySlider = UISlider()
    let periodSlider = UISlider()
    
    //MARK: Picker View Declaration
    let teacherPicker = UIPickerView()
    
    //MARK; Text Field Declaration
    let searchTF = UITextField()
    
    //MARK: Impermanent Variable Declarations
    var teachers: [String] = []
    var day = "A"
    var period = "1"
    var time = "A1"
    var teacher = ""
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    //MARK: Permanent Variable Declarations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        
        self.teacherPicker.delegate = self
        self.teacherPicker.dataSource = self
        
        availabilityLabel.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //MARK: Title Label
        titleLabel.isHidden = false
        titleLabel.frame = CGRect(x: screenWidth/9, y: screenHeight / 45, width: 7 * screenWidth/9, height: 0.07 * screenHeight)
        titleLabel.backgroundColor = UIColor.red
        titleLabel.text = "12th Grade Teachers"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.highlightedTextColor = UIColor.white
        titleLabel.isHighlighted = true
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 0.1 * titleLabel.bounds.size.width
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 0.07 * screenWidth)
        
        view.addSubview(titleLabel)
        
        //MARK: Day Label
        
        //MARK: Period Label
        
        //MARK: Availability Label
        
        //MARK: Day Slider
        
        //MARK: Period Slider
        
        //MARK: Teacher Picker
        
        //MARK: Search Text Field
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func daySliderChanged(_sender: AnyObject){
        let currentValue = Int(daySlider.value)
        let numbersToLetters: [Int: String] = [1: "A", 2: "B", 3: "C", 4: "D", 5: "E", 6: "F", 7: "G", 8: "H", 9: "I", 10: "J"]
        dayLabel.text = "Day: \(numbersToLetters[currentValue]!)"
        day = numbersToLetters[currentValue]!
        updateText()
    }
    
    func periodSliderChanged(_sender: AnyObject){
        let currentValue = Int(periodSlider.value)
        periodLabel.text = "Period: \(currentValue)"
        period = String(currentValue)
        updateText()
    }
    
    func searchTFAction(_sender: AnyObject){
        let input = searchTF.text?.lowercased()
        for tea in teachers {
            let nameIndex = tea.lowercased().index(tea.startIndex, offsetBy: 4)
            
            if (input?.contains(tea.lowercased().substring(from: nameIndex)))! {
                teacher = tea
            }
        }
        dismissKeyboard()
        updateText()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teachers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teachers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: teachers[row], attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:UIColor.init(red: 0, green: 255, blue: 255, alpha: 1.0)])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        teacher = teachers[row]
        updateText()
    }

    func updateText(){
        availabilityLabel.isHidden = false
        availabilityLabel.text = "Availability"
        time = day + period
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
