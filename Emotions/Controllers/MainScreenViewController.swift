//
//  MainScreenViewController.swift
//  Emotions
//
//  Created by Artem Khlevchuk on 31.03.2024.
//

import Foundation
import UIKit
import CoreData

class MainScreenViewController: UIViewController {
    
    var emotionArray = [Emotion]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEmotion()
        
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return emotionArray.count
//        }
    
    func loadEmotion() {
        let request: NSFetchRequest<Emotion> = Emotion.fetchRequest()
       
        do {
            emotionArray = try context.fetch(request)
        } catch {
            print("Eror fetching data from context \(error)")
        }
    }
}
