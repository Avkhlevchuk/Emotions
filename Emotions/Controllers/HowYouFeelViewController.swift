//
//  HowYouFeelViewController.swift
//  Emotions
//
//  Created by Artem Khlevchuk on 31.03.2024.
//

import Foundation
import UIKit
import CoreData
import FirebaseAuth

class HowYouFeelViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var emotionManager = EmotionsManager()
    
    let userName = Auth.auth().currentUser?.email
    
   

    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectEmotion: String?
    
    @IBOutlet weak var currentEmotions: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentEmotions.dataSource = self
        currentEmotions.delegate = self
        textField.delegate = self

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
     
        
    }
    
    func saveEmotion() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    
    }

    
    @IBAction func savePressed(_ sender: UIButton) {
        
        
        let currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        let dateTimeString = formatter.string(from: currentDate)
        
        let newEmotions = Emotion(context: context)
    
        
        newEmotions.name = selectEmotion
        newEmotions.date = dateTimeString
        newEmotions.comment = textField.text
        newEmotions.mail = userName
        
        
        
        saveEmotion()
        
        performSegue(withIdentifier: "GoToMainScreen", sender: self)
        
        
        
    }
    
    
    
}

//MARK: - UIPickerViewDataSource

extension HowYouFeelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emotionManager.emotionsArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension HowYouFeelViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emotionManager.emotionsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectEmotion = emotionManager.emotionsArray[row]
        
       
    
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


