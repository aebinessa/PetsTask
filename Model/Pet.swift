//
//  Pet.swift
//  PetsTask
//
//  Created by Abdullah Bin Essa on 3/4/24.
//

import Foundation

struct Pet: Codable{
    let id: Int?
    let name: String
    let adopted: Bool
    let image: String
    let age: Int
    let gender: String
}
