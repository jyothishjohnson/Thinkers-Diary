//
//  DrawingDataManager.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 11/01/21.
//

import Foundation
import PencilKit

class DrawingDataManager {
    
    static let shared = DrawingDataManager()
    
    private let serializationQueue = DispatchQueue(label: "SerializationQueue", qos: .background)
    
    func updateDrawingForNote(id : String, data: PKDrawing){
        serializationQueue.async {
            do {
                let encoder = PropertyListEncoder()
                let encodedData = try encoder.encode(data)
            }catch {
                print("error while encoding PKDrawing: \(error.localizedDescription)")
            }
        }
    }
}
