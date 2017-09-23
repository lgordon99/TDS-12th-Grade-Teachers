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
    //var teachers: [String] = ["Ms. Ioppolo", "Mr. Moonga", "Ms. Rosenblatt", "Dr. Henry", "Ms. Spalding", "Mr. Tarbath"]
    var teachers: [String] = []
    var day = "A"
    var period = "1"
    var time = "A1"
    var teacher = "Ms. Ioppolo"
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var csvData = ""
    var teacherCSV = ""
    var csvRows = [[]]
    
    //MARK: Permanent Variable Declarations
    let ioppolo: [String] = ["A1", "A3", "A5", "A6", "A7", "B1", "B2", "B4", "B5", "C2", "C3", "C5", "C6", "C7", "D3", "D5", "D6", "D7", "E2", "E3", "E5", "E7", "F1", "F2", "F3", "F5", "F6", "F7", "G1", "G5", "G6", "H1", "H2", "I1", "I3", "I4", "I5", "I7", "J3", "J4", "J5", "J6", "J7"]
    let moonga: [String] = ["A2", "A3", "A4", "A5", "A6", "B1", "B5", "B6", "C1", "C2", "C3", "C5", "C7", "D1", "D2", "D3", "D4", "E2", "E3", "E4", "E6", "E7", "F1", "F3", "F6", "G1", "G2", "G3", "G4", "G5", "H1", "H2", "H3", "H5", "H6", "H7", "I3", "I6", "I7", "J2", "J4", "J6", "J7"]
    let rosenblatt: [String] = ["A3", "A4", "A5", "A7", "B1", "B4", "B5", "B7", "C1", "C5", "C7", "D2", "D3", "D4", "D5", "D7", "E2", "E5", "E6", "E7", "F3", "F5", "F7", "G1", "G3", "G4", "G5", "H1", "H4", "H5", "H7", "I3", "I4", "I5", "I7", "J1", "J2", "J5", "J6", "J7"]
    let henry: [String] = ["A1", "A2", "A3", "A5", "A6", "A7", "B1", "B3", "B6", "B7", "C2", "C5", "C6", "C7", "D1", "D3", "D4", "D5", "E2", "E4", "E5", "E7", "F1", "F3", "F4", "F5", "F6", "G1", "G2", "G4", "G5", "H1", "H3", "H4", "H5", "H6", "H7", "I2", "I3", "I5", "I6", "J1", "J3", "J5", "J6", "J7"]
    let spalding: [String] = ["A2", "A3", "A4", "A5", "A6", "A7", "B1", "B6", "B7", "C1", "C2", "C7", "D1", "D2", "D3", "D4", "D5", "D7", "E4", "E5", "E6", "E7", "F1", "F3", "F5", "F7", "G1", "G2", "G3", "G4", "G5", "H3", "H4", "H5", "H6", "H7", "I3", "I5", "I6", "I7", "J1", "J2", "J3", "J5", "J7"]
    let tarbath: [String] = ["A1", "A3", "A4", "A5", "A7", "B1", "B3", "B4", "B5", "B7", "C4", "C5", "C6", "C7", "D2", "D3", "D5", "D7", "E1", "E2", "E3", "E5", "E7", "F3", "F4", "F5", "F6", "F7", "G1", "G3", "G7", "H1", "H2", "H4", "H7", "I2", "I3", "I4", "I5", "I7", "J1", "J5", "J6", "J7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvData = readDataFromCSV(fileName: "Teacher Schedules", fileType: "csv")
        csvData = cleanRows(file: csvData)
        //csvRows = csv(data: csvData)
        //print(csvRows)
        //print(csvData)
        
        teacherCSV = readDataFromCSV(fileName: "Teacher Names", fileType: "csv")
        teacherCSV = cleanRows(file: teacherCSV)
        while teacherCSV.contains("\"") {
            teacherCSV.remove(at: teacherCSV.index(of: "\"")!)
        }
        while let rangeToReplace = teacherCSV.range(of: "\n") {
            teacherCSV.replaceSubrange(rangeToReplace, with: " ")
        }
        //print(teacherCSV)
        //var teacherArray = String(describing: teacherCSV.split(separator: " "))
        var teacherArray = teacherCSV.components(separatedBy: " ")
        
        var i = 0
        for element in teacherArray {
            if element == "" {
                teacherArray.remove(at: i)
            } else {
                i += 1
            }
        }
        //print(teacherArray)
        
        for teacher in teacherArray {
            if teacher.contains(",") {
                let newTeacher = teacher.substring(to: teacher.index(of: ",")!)
                teacherArray.remove(at: teacherArray.index(of: teacher)!)
                teacherArray.append(newTeacher)
            }
        }
        
        teachers = teacherArray
        
        //print(teacherArray)
        
        screenWidth = view.frame.size.width
        screenHeight = view.frame.size.height
        
        self.teacherPicker.delegate = self
        self.teacherPicker.dataSource = self
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //MARK: Title Label
        titleLabel.isHidden = false
        titleLabel.frame = CGRect(x: screenWidth/9, y: screenHeight/30, width: 7 * screenWidth/9, height: 0.07 * screenHeight)
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
        dayLabel.frame = CGRect(x: 2 * screenWidth/30, y: 3 * screenHeight/20, width: 6 * screenWidth/30, height: 0.06 * screenHeight)
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
        periodSlider.maximumValue = 8
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
        teacherPicker.frame = CGRect(x: screenWidth/10, y: 8 * screenHeight/20, width: 8 * screenWidth/10, height: 6 * screenHeight/20)
        
        view.addSubview(teacherPicker)
        
        //MARK: Availability Label
        availabilityLabel.isHidden = false
        availabilityLabel.frame = CGRect(x: screenWidth/10, y: 14 * screenHeight / 20, width: 8 * screenWidth/10, height: 5 * screenHeight/20)
        availabilityLabel.backgroundColor = UIColor.blue
        availabilityLabel.text = "Ms. Ioppolo is available to meet A1!"
        availabilityLabel.textAlignment = NSTextAlignment.center
        availabilityLabel.highlightedTextColor = UIColor.white
        availabilityLabel.numberOfLines = 0
        availabilityLabel.isHighlighted = true
        availabilityLabel.layer.masksToBounds = true
        availabilityLabel.layer.cornerRadius = 0.1 * availabilityLabel.bounds.size.width
        availabilityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 0.05 * screenWidth)
        
        view.addSubview(availabilityLabel)
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
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
        if Int(periodSlider.value) < 5 {
            let currentValue = Int(periodSlider.value)
            periodLabel.text = "Period: \(currentValue)"
            period = String(currentValue)
        } else if Int(periodSlider.value) > 6 {
            let currentValue = Int(periodSlider.value - 1)
            periodLabel.text = "Period: \(currentValue)"
            period = String(currentValue)
        } else if Int(periodSlider.value) == 5 {
            periodLabel.text = "Period: 5a"
            period = "5a"
        } else {
            periodLabel.text = "Period: 5b"
            period = "5b"
        }
        updateText()
    }
    
    func searchTFAction(_sender: AnyObject){
        let input = searchTF.text?.lowercased()
        for tea in teachers {
            let nameIndex = tea.lowercased().startIndex
            
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
        availabilityLabel.text = ""
        time = day + period
        
        var teacherLN = ""
        var startPos = 0
        var endPos = 0
        
        teacherLN = String(teacher.dropFirst(4))
 
        if let range = csvData.range(of: teacherLN){
             startPos = csvData.distance(from: csvData.startIndex, to: range.lowerBound)
             endPos = csvData.distance(from: csvData.startIndex, to: range.upperBound)
        }
        
        let startIndex = csvData.index(csvData.startIndex, offsetBy: startPos)
        let endIndex = csvData.index(csvData.startIndex, offsetBy: startPos + teacherLN.characters.count + 250)
        let range = startIndex..<endIndex
        
        let teacherData = String(csvData.substring(with: range))!

        let aIndex = teacherData.distance(from: teacherData.startIndex, to: teacherData.index(of: "A")!)
        //print(aIndex)
        
        let justSchedule = String(teacherData.dropFirst(aIndex))
        //print(justSchedule)
        
        let quoteIndex = justSchedule.distance(from: justSchedule.startIndex, to: justSchedule.index(of: "\"")!)
        let withoutLetters = String(justSchedule.dropFirst(quoteIndex))
        print(withoutLetters)
        
        let free = getFree(schedule: withoutLetters, day: day, period: period)
        
        if free {
            availabilityLabel.text = "\(teacher) is available to meet \(time)!"
        } else {
            availabilityLabel.text = "\(teacher) is not available \(time)."
        }
    }
    
    func getFree(schedule: String, day: String, period: String) -> Bool{
        var indexes: [Int] = []
        var searchRange = schedule.startIndex..<schedule.endIndex
        let lettersToNumbers: [String: Int] = ["A": 1, "B": 2, "C": 3, "D": 4, "E": 5, "F": 6, "G": 7, "H": 8, "I": 9, "J": 10]
        let dayNumber = lettersToNumbers[day]
        let periodToNumber: [String: Int] = ["1": 1, "2": 2, "3": 3, "4": 4, "5a": 5, "5b": 6, "6": 7, "7": 8]
        let periodNumber = periodToNumber[period]
        
        while let range = schedule.range(of: ",", options: .caseInsensitive, range: searchRange) {
            searchRange = range.upperBound..<searchRange.upperBound
            let index = schedule.distance(from: schedule.startIndex, to: range.lowerBound)
            indexes.append(index)
        }
        
        let commaNumber = 10 * (periodNumber! - 1) + (dayNumber! - 1)
        let charIndex = indexes[commaNumber]
        print(indexes)
        print(commaNumber)
        print(charIndex)
        let ind = schedule.index(schedule.startIndex, offsetBy: charIndex + 1)
        let char = String(schedule[ind])
        print("char = " + char)
        
        if char == "," {
            return true
        } else {
            return false
        }
    }
    
    func updateText2(){
        availabilityLabel.isHidden = false
        availabilityLabel.text = ""
        time = day + period
        
        if teacher == "Ms. Ioppolo" {
            for item in ioppolo {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        } else if teacher == "Mr. Moonga" {
            for item in moonga {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        } else if teacher == "Ms. Spalding" {
            for item in spalding {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        } else if teacher == "Ms. Rosenblatt" {
            for item in rosenblatt {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        } else if teacher == "Dr. Henry" {
            for item in henry {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        } else if teacher == "Ms. Spalding" {
            for item in spalding {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        } else if teacher == "Mr. Tarbath" {
            for item in tarbath {
                if time == item {
                    availabilityLabel.text = "\(teacher) is available to meet \(time)!"
                    
                    break
                } else {
                    availabilityLabel.text = "\(teacher) is not available \(time)."
                }
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
