//
//  MainScreenTableViewController.swift
//  Emotions
//
//  Created by Artem Khlevchuk on 07.04.2024.
//

import Foundation
import UIKit
import CoreData
import FirebaseAuth

class MainScreenTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var emotionArray = [Emotion]()
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let userEmail = Auth.auth().currentUser?.email

        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadEmotion()
            
            tableView.rowHeight = 80.0
            
            navigationItem.hidesBackButton = true
            

        }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller doesn't exist")}
        
        navBar.barTintColor = UIColor(red: 0.13, green: 0.32, blue: 0.58, alpha: 1.00)
                    
                  
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return emotionArray.count
            }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmotionListCell" , for: indexPath)
        
       
        cell.textLabel?.text = emotionArray[indexPath.row].name
       


        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        context.delete(emotionArray[indexPath.row])
        emotionArray.remove(at: indexPath.row)
        
        
        saveEmotion()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    


    
     
    func saveEmotion() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    
    }
        
    func loadEmotion(with request: NSFetchRequest<Emotion> = Emotion.fetchRequest()) {
            
        let predicate = NSPredicate(format: "mail MATCHES %@", userEmail!)
           
        request.predicate = predicate
        
            do {
                emotionArray = try context.fetch(request)
            } catch {
                print("Eror fetching data from context \(error)")
            }
            
            tableView.reloadData()
        }
    
    
    }
//MARK: - Searh bar methods

extension MainScreenTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let request : NSFetchRequest<Emotion> = Emotion.fetchRequest()
        
        request.predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        
        do {
            emotionArray = try context.fetch(request)
        } catch {
            print("Error fething data from context \(error)")
        }
        
        tableView.reloadData()
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadEmotion()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
    

