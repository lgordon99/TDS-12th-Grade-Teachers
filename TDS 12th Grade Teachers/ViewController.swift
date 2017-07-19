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
    var teachers: [String] = ["Mr. Lindow", "Ms. Spalding", "Mr. Thomas", "Mr. Tarbath", "Ms. LiCalsi", "Dr. Henry", "Mr. Moonga"]
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
        titleLabel.frame = CGRect(x: screenWidth/9, y: screenHeight / 30, width: 7 * screenWidth/9, height: 0.07 * screenHeight)
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
        dayLabel.isHidden = false
        dayLabel.frame = CGRect(x: 2 * screenWidth/30, y: 3 * screenHeight / 20, width: 6 * screenWidth/30, height: 0.06 * screenHeight)
        dayLabel.backgroundColor = UIColor.clear
        dayLabel.text = "Day: A"
        dayLabel.textAlignment = NSTextAlignment.left
        dayLabel.highlightedTextColor = UIColor.gray
        dayLabel.isHighlighted = true
        dayLabel.layer.masksToBounds = true
        dayLabel.layer.cornerRadius = 0.1 * dayLabel.bounds.size.width
        dayLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 0.05 * screenWidth)
        
        view.addSubview(dayLabel)
        
        //MARK: Day Slider
        daySlider.isHidden = false
        daySlider.frame = CGRect(x: 10 * screenWidth/30, y: 3 * screenHeight/20, width: screenWidth - 2 * screenWidth/30 - 10 * screenWidth/30, height: 0.06 * screenHeight)
        daySlider.value = 1
        daySlider.minimumValue = 1
        daySlider.maximumValue = 10
        daySlider.minimumTrackTintColor = UIColor.blue
        daySlider.maximumTrackTintColor = UIColor.magenta
        daySlider.thumbTintColor = UIColor.white
        daySlider.isContinuous = true
        daySlider.isEnabled = true
        daySlider.addTarget(self, action: #selector(daySliderChanged(_sender:)), for: .valueChanged)
        
        view.addSubview(daySlider)
        
        //MARK: Period Label
        periodLabel.isHidden = false
        periodLabel.frame = CGRect(x: 2 * screenWidth/30, y: 5 * screenHeight / 20, width: 9 * screenWidth/30, height: 0.06 * screenHeight)
        periodLabel.backgroundColor = UIColor.clear
        periodLabel.text = "Period: 1"
        periodLabel.textAlignment = NSTextAlignment.left
        periodLabel.highlightedTextColor = UIColor.gray
        periodLabel.isHighlighted = true
        periodLabel.layer.masksToBounds = true
        periodLabel.layer.cornerRadius = 0.1 * periodLabel.bounds.size.width
        periodLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 0.05 * screenWidth)
        
        view.addSubview(periodLabel)
    
        //MARK: Period Slider
        periodSlider.isHidden = false
        periodSlider.frame = CGRect(x: 10 * screenWidth/30, y: 5 * screenHeight/20, width: screenWidth - 2 * screenWidth/30 - 10 * screenWidth/30, height: 0.06 * screenHeight)
        periodSlider.value = 1
        periodSlider.minimumValue = 1
        periodSlider.maximumValue = 7
        periodSlider.minimumTrackTintColor = UIColor.blue
        periodSlider.maximumTrackTintColor = UIColor.magenta
        periodSlider.thumbTintColor = UIColor.white
        periodSlider.isContinuous = true
        periodSlider.isEnabled = true
        periodSlider.addTarget(self, action: #selector(periodSliderChanged(_sender:)), for: .valueChanged)
        
        view.addSubview(periodSlider)
        
        //MARK: Search Text Field
        searchTF.isHidden = false
        searchTF.isEnabled = true
        searchTF.frame = CGRect(x: 2 * screenWidth/10, y: 7 * screenHeight/20, width: 6 * screenWidth/10, height: 0.06 * screenHeight)
        searchTF.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 0.05 * screenWidth)!])
        searchTF.textAlignment = NSTextAlignment.center
        searchTF.textColor = UIColor.white
        searchTF.backgroundColor = UIColor.black
        searchTF.layer.masksToBounds = true
        searchTF.layer.cornerRadius = 0.1 * searchTF.bounds.size.width
        searchTF.addTarget(self, action: #selector(searchTFAction(_sender:)), for: .editingDidEnd)
        
        view.addSubview(searchTF)
        
        //MARK: Teacher Picker
        teacherPicker.isHidden = false
        teacherPicker.isUserInteractionEnabled = true
        teacherPicker.frame = CGRect(x: screenWidth/10, y: 9 * screenHeight/20, width: 8 * screenWidth/10, height: 0.3 * screenHeight)
        
        view.addSubview(teacherPicker)
        
        //MARK: Availability Label
        
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
        return NSAttributedString(string: teachers[row], attributes: [NSFontAttributeName:UIFont(name: "Avenir", size: 15.0)!,NSForegroundColorAttributeName:UIColor.cyan])
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
