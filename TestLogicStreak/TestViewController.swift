//
//  TestViewController.swift
//  LearningEnglish
//
//  Created by Quoc Dat on 3/7/18.
//  Copyright © 2018 BigZero. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var chooseNextDayTextField: UITextField!
    @IBOutlet weak var lastDateTextField: UITextField!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var lastDateScoreLabel: UILabel!
    @IBOutlet weak var currentDateTextField: UITextField!
    var currentDateString: String?
    var lastDateString: String?
    var today : String!
    var lastScore: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        lastDateTextField.isEnabled = false
        pointLabel.text = "today score: \( DataService.shared.user.todayScore)"
        lastDateScoreLabel.text = "last score: \(lastScore)"
        streakLabel.text = "streak: \(DataService.shared.user.streak)"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lastDateBeginEndEdit(_ sender: UITextField) {
        creatDatePickerView(sender)
    }
    @IBAction func currentDateBeginEndEdit(_ sender: UITextField) {
        
        creatDatePickerView(sender)
    }
    
    @IBAction func chooseNextDayTextFieldBeginEdit(_ sender: UITextField) {
        creatDatePickerView(sender)
        
    }
    
    
    func compareDate(currentDateString: String, lastDateString: String) -> String
    {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMMM d, yyyy"
        let currentDate = dateFormater.date(from: currentDateString)
        let lastDate = dateFormater.date(from: lastDateString)
        let diff = Calendar.current.dateComponents([.day], from: lastDate!, to: currentDate!)
        if diff.day == 1 {
            return "yesterday"
        } else if diff.day == 0 { return "today"
            
        } else if diff.day! > 1 {
            return "more than 1 day"
        } else {
            return "\(diff)"
        }
    }
    
    @IBAction func updateDayButtonTapped(_ sender: Any) {
        if chooseNextDayTextField.text != currentDateTextField.text && chooseNextDayTextField.text != ""{
           
            
            lastDateString = currentDateTextField.text
            lastDateTextField.text = lastDateString
            
            currentDateString = chooseNextDayTextField.text
            currentDateTextField.text = currentDateString
            
            chooseNextDayTextField.text = ""
            
            lastScore = DataService.shared.user.todayScore
            DataService.shared.user.todayScore = 0
            pointLabel.text =  "today point: \(DataService.shared.user.todayScore)"
            lastDateScoreLabel.text = "\(lastDateTextField.text!) Score: \(lastScore)"
            let resultDifferent = compareDate(currentDateString: currentDateString!, lastDateString: lastDateString!)
            if resultDifferent == "yesterday" {
                if lastScore < 100 {
                    DataService.shared.removeStreak()
                    streakLabel.text = "streak: \(DataService.shared.user.streak)"
                }
            }
            if resultDifferent == "more than 1 day" {
                DataService.shared.removeStreak()
                streakLabel.text = "streak: \(DataService.shared.user.streak)"
            }
        }
    }
    
    @IBAction func plusPointButtonTapped(_ sender: UIButton) {
        // var todayScore = DataService.shared.user.todayScore
        DataService.shared.user.todayScore += 20
        DataService.shared.plusStreak()
        pointLabel.text = "score: \( DataService.shared.user.todayScore)"
        streakLabel.text = "streak: \(DataService.shared.user.streak)"
    }
    
}
extension TestViewController: UITextFieldDelegate {
    fileprivate func creatDatePickerView(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        if sender == lastDateTextField {
            datePickerView.addTarget(self, action: #selector(lastDatePickerValueChanged), for: UIControlEvents.valueChanged)
        } else if sender == currentDateTextField {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.long
            currentDateTextField.text = dateFormatter.string(from: datePickerView.date)
            datePickerView.addTarget(self, action: #selector(currentDatePickerValueChanged), for: UIControlEvents.valueChanged)
        } else if sender == chooseNextDayTextField {
            datePickerView.addTarget(self, action: #selector(chooseNextDayPickerValueChanged), for: UIControlEvents.valueChanged)
        }
    }
    @objc func currentDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        currentDateTextField.text = dateFormatter.string(from: sender.date)
        
    }
    
    @objc func chooseNextDayPickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        chooseNextDayTextField.text = dateFormatter.string(from: sender.date)
        
    }
    @objc func lastDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        lastDateTextField.text = dateFormatter.string(from: sender.date)
    }
}
