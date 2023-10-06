//
//  Extension.swift
//  Lexik1
//
//  Created by Алибек Баймурат on 09.08.2023.
//

import Foundation

class Extension: ObservableObject {
    @Published var data = ""
    
    init() {
        self.load(file: "lorem_ipsum")
    }
    
    func load(file: String) {
        if let filepath = Bundle.main.path(forResource: file, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                DispatchQueue.main.async {
                    self.data = contents
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("File not found")
        }
    }
}
