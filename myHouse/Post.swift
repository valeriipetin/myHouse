//
//  Post.swift
//  myHouse
//
//  Created by Valera Petin on 18.02.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit

class Post: NSObject {

    var author: String!
    var likes: Int!
    var zg: String!
    var price: String!
    var pathToImage: String!
    var profileImage: String!
    var userID: String!
    var postID: String!
    
    //Продажа квартиры
    var tg: String!
    var fullArea: String!
    var livingArea: String!
    var kitchenArea: String!
    var property: String!
    var nameUser: String!
    var phone: String!
    var email: String!
    var number: String!
    var floor: String!
    var floorsHome: String!
    var typeHome: String!
    var typeUser: String!
    var plan: String!
    var bathroom: String!
    var rem: String!
    
    //Продажа дома
    var typeDom: String!
    var vod: String!
    var gas: String!
    var otop: String!
    var otopType: String!
    var can: String!
    var el: String!
    var mat: String!
    var gaArea: String!
    var years: String!
    
    //Продажа дачи
    var posadki: String!
    var ban: String!
    var garage: String!
    var tepl: String!
    var avt: String!
    
    //Аренда квартиры
    var time: String!
    var com: String!
    var wifi: String!
    var meb: String!
    var hol: String!
    
    var peopleWhoLike: [String] = [String]()
}
