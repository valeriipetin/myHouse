//
//  PostKupitDomCell.swift
//  myHouse
//
//  Created by Valera Petin on 04.05.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase

class PostKupitDomCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var zgLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var unlikeBtn: UIButton!
    
    //Продажа квартиры
    var profileImage: String!
    var postID: String!
    var tg: String!
    var fullArea: String!
    var livingArea: String!
    var kitchenArea: String!
    var property: String!
    var nameUser: String!
    var phone: String!
    var email: String!
    var number: String!
    var floorsHome: String!
    var typeUser: String!
    var plan: String!
    var bathroom: String!
    
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
    
    
    @IBAction func likePressed(_ sender: Any) {
        
        self.likeBtn.isEnabled = false
        
        let ref = FIRDatabase.database().reference()
        
        let keyToPost = ref.child("Продажа").child("Дома").childByAutoId().key
        
        ref.child("Продажа").child("Дома").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil {
                
                let updateLikes: [String : Any] = ["Добавили в избранное/\(keyToPost)" : FIRAuth.auth()!.currentUser!.uid]
                
                ref.child("Продажа").child("Дома").child(self.postID).updateChildValues(updateLikes, withCompletionBlock: { (error, reff) in
                    
                    if error == nil {
                        
                        ref.child("Продажа").child("Дома").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                            
                            if let properties = snap.value as? [String : AnyObject] {
                                
                                if let likes = properties["Добавили в избранное"] as? [String : AnyObject] {
                                    
                                    let count = likes.count
                                    
                                    let update = ["likes" : count]
                                    ref.child("Продажа").child("Дома").child(self.postID).updateChildValues(update)
                                    
                                    
                                    self.likeBtn.isHidden = true
                                    self.unlikeBtn.isHidden = false
                                    self.likeBtn.isEnabled = true
                                    
                                }
                            }
                        })
                    }
                })
            }
        })
        ref.removeAllObservers()
    }
    
    
    
    @IBAction func unlikePressed(_ sender: Any) {
        
        self.unlikeBtn.isEnabled = false
        
        let ref = FIRDatabase.database().reference()
        
        
        ref.child("Продажа").child("Дома").child(self.postID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let properties = snapshot.value as? [String : AnyObject] {
                
                if let peopleWhoLike = properties["Добавили в избранное"] as? [String : AnyObject] {
                    
                    for (id,person) in peopleWhoLike {
                        
                        if person as? String == FIRAuth.auth()!.currentUser!.uid {
                            
                            ref.child("Продажа").child("Дома").child(self.postID).child("Добавили в избранное").child(id).removeValue(completionBlock: { (error, reff) in
                                
                                if error == nil {
                                    
                                    ref.child("Продажа").child("Дома").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                                        
                                        if let prop = snap.value as? [String : AnyObject] {
                                            
                                            if let likes = prop["Добавили в избранное"] as? [String : AnyObject] {
                                                
                                                let count = likes.count
                                                ref.child("Продажа").child("Дома").child(self.postID).updateChildValues(["likes" : count])
                                                
                                            }else {
                                                
                                                ref.child("Продажа").child("Дома").child(self.postID).updateChildValues(["likes" : 0])
                                            }
                                        }
                                    })
                                }
                            })
                            
                            self.likeBtn.isHidden = false
                            self.unlikeBtn.isHidden = true
                            self.unlikeBtn.isEnabled = true
                            break
                            
                        }
                    }
                }
            }
        })
        ref.removeAllObservers()
    }
}
