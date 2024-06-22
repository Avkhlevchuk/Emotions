//
//  EmotionsManager.swift
//  Emotions
//
//  Created by Artem Khlevchuk on 31.03.2024.
//

import Foundation

protocol EmotionsManagerDelegate {
    
}

struct EmotionsManager {
    var delegate: EmotionsManagerDelegate?
    
    let emotionsArray = ["Happiness", "Sadness", "Anger", "Fear", "Surprise",
                         "Disgust", "Excitement", "Love", "Joy", "Sorrow",
                         "Envy", "Guilt", "Shame", "Pride", "Confusion",
                         "Embarrassment", "Anxiety", "Contentment", "Frustration",
                         "Elation", "Boredom", "Compassion", "Jealousy",
                         "Regret", "Hope"]
}
