//
//  RoomNodeType.swift
//  Lair Tour
//
//  Created by Jamie Chen on 2021-04-30.
//

import Foundation

enum RoomNodeType: String {
    case doorway = "Doorway"
    case coatRoom = "Coat Room"
    case library = "Library"
    case diningRoom = "Dining Room"
    case stairUp = "To Upper Floor"
    case secretPassage = "Secret Passage"
    case kitchen = "Kitchen"
    case bedRoom = "Bed Room"
    case bathRoom = "Bath Room"
    case dungeon = "Dungeon"
    case labratory = "Labratory"
    case mysteriousLake = "Mysterious Lake"
    case backPorch = "Back Porch"
    case generator = "Generator"
    case cursedChalice = "Cursed Chalice"
    
    var nextRooms: [RoomNodeType]? {
        switch self {
        case .doorway:
            return [.coatRoom]
        case .coatRoom:
            return [.library, .diningRoom, .stairUp]
        case .library:
            return [.secretPassage]
        case .diningRoom:
            return [.kitchen]
        case .stairUp:
            return [.bedRoom, .bathRoom]
        case .kitchen:
            return [.backPorch]
        case .secretPassage:
            return [.dungeon, .labratory, .mysteriousLake]
        case .labratory:
            return [.generator]
        case .mysteriousLake:
            return [.cursedChalice]
        default:
            return nil
        }
    }
    
    var imageName: String {
        switch self {
        case .doorway:
            return "front_door"
        case .backPorch:
            return "back_porch"
        case .bathRoom:
            return "bathroom"
        case .bedRoom:
            return "bedroom"
        case .coatRoom:
            return "coat_room"
        case .cursedChalice:
            return "cursed_chalice"
        case .diningRoom:
            return "dining_room"
        case .dungeon:
            return "dungeon"
        case .generator:
            return "generator"
        case .kitchen:
            return "kitchen"
        case .labratory:
            return "labratory"
        case .library:
            return "library"
        case .mysteriousLake:
            return "mysterious_lake"
        case .secretPassage:
            return "secret_passage"
        case .stairUp:
            return "stairs_up"
        }
    }
}
