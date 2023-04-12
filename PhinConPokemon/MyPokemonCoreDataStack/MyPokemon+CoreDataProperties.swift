//
//  MyPokemon+CoreDataProperties.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//
//

import Foundation
import CoreData


extension MyPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPokemon> {
        return NSFetchRequest<MyPokemon>(entityName: "MyPokemon")
    }

    @NSManaged public var id: Int32
    @NSManaged public var pokemonName: String?
    @NSManaged public var pokemonNickname: String?
    @NSManaged public var pokemonUrlDetail: String?
    @NSManaged public var pokemonUrlImage: String?
    @NSManaged public var renameCount: Int32
    
}

extension MyPokemon : Identifiable {

}
