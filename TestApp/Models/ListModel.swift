//
//  ListModel.swift
//  TestApp
//
//  Created by ICS on 21/05/21.
//

import UIKit
import RealmSwift
//Realm database models (repersent as a table stucture)
class UserList: Object,Decodable {
    @objc var id: Int
    @objc var name: String!
    @objc var username: String
    @objc var email: String
    @objc var phone: String
    @objc var website: String
    @objc var company: Company?
    @objc var address: AddressData?
    
    //Setting primary key
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Company: Object,Codable {
    @objc var name: String?
    @objc var catchPhrase: String?
    @objc var bs: String?
}

class AddressData: Object, Codable {
    @objc var street: String?
    @objc var suite: String?
    @objc var city: String?
    @objc var zipcode: String?
    @objc  var geo: Geo?
}

class Geo: Object, Codable {
    @objc var lat: String?
    @objc var lng: String?
}

