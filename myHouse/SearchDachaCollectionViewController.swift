//
//  SearchDachaCollectionViewController.swift
//  myHouse
//
//  Created by Valera Petin on 06.05.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class SearchDachaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post]()
    var im = UIImage()
    var pathIm: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Складывающийся navigation bar
        //self.navigationController?.hidesBarsOnSwipe = true
        
        //Кнопка назад без названия
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        fetchPosts()
    }
    
    //Получить и запостить данные в пост
    func fetchPosts(){
        
        
        let ref = FIRDatabase.database().reference()
        
        if (FIRAuth.auth()?.currentUser?.uid) != nil{
            
            ref.child("Продажа").child("Дачный участок").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                
                let postsSnap = snap.value as! [String: AnyObject]
                
                for (_,post) in postsSnap {
                    
                    if let userID = post["userID"] as? String {
                        
                        let posst = Post()
                        if  let likes = post["likes"] as? Int,
                            let pathToImage = post["pathToImage"] as? String,
                            let profileImage = post["photoUser"] as? String,
                            let postID = post["postID"] as? String,
                        
                            let zg = post["Заголовок объявления"] as? String,
                            let price = post["Цена"] as? String,
                            let tg = post["Торг"] as? String,
                            let el = post["Электричество"] as? String,
                            let vod = post["Вода"] as? String,
                            let gas = post["Газ"] as? String,
                            let property = post["Описание"] as? String,
                            let nameUser = post["Контактное лицо"] as? String,
                            let phone = post["Телефон"] as? String,
                            let email = post["email"] as? String,
                            let posadki = post["Посадки"] as? String,
                            let ban = post["Баня"] as? String,
                            let can = post["Туалет"] as? String,
                            let typeHome = post["Тип"] as? String,
                            let typeUser = post["Тип пользователя"] as? String,
                            let garage = post["Гараж"] as? String,
                            let tepl = post["Теплица"] as? String,
                            let avt = post["Автобусная остановка"] as? String,
                            let years = post["Год постройки"] as? String,
                            let gaArea = post["Участок"] as? String,
                            let fullArea = post["Площадь дома"] as? String
                        
                        {
                            posst.likes = likes
                            posst.pathToImage = pathToImage
                            posst.profileImage = profileImage
                            posst.postID = postID
                            posst.userID = userID
                       
                            posst.zg = zg
                            posst.price = price
                            posst.tg = tg
                            posst.fullArea = fullArea
                            posst.gaArea = gaArea
                            posst.years = years
                            posst.property = property
                            posst.nameUser = nameUser
                            posst.phone = phone
                            posst.email = email
                            posst.el = el
                            posst.vod = vod
                            posst.gas = gas
                            posst.typeHome = typeHome
                            posst.typeUser = typeUser
                            posst.posadki = posadki
                            posst.ban = ban
                            posst.can = can
                            posst.garage = garage
                            posst.tepl = tepl
                            posst.avt = avt
                      
                            if let people = post["Добавили в избранное"] as? [String: AnyObject] {
                                
                                for(_,person) in people {
                                    posst.peopleWhoLike.append((person as! String))
                                }
                            }
                            
                            self.posts.append(posst)
                        }
                        
                        self.collectionView.reloadData()
                    }
                }
            })
        }
        ref.removeAllObservers()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellKupitDach", for: indexPath) as! PostKupitDachCell
        
        //creating the cell
        
        cell.postImage.sd_setImage(with: URL(string: self.posts[indexPath.row].pathToImage), placeholderImage: UIImage(named: "user_placeholder.png"))
        cell.zgLabel.text = self.posts[indexPath.row].zg
        cell.priceLabel.text = self.posts[indexPath.row].price
        cell.postID = self.posts[indexPath.row].postID
    
        cell.profileImage = self.posts[indexPath.row].profileImage
        cell.tg = self.posts[indexPath.row].tg
        cell.fullArea = self.posts[indexPath.row].fullArea
        cell.gaArea = self.posts[indexPath.row].gaArea
        cell.years = self.posts[indexPath.row].years
        cell.property = self.posts[indexPath.row].property
        cell.nameUser = self.posts[indexPath.row].nameUser
        cell.phone = self.posts[indexPath.row].phone
        cell.email = self.posts[indexPath.row].email
        cell.el = self.posts[indexPath.row].el
        cell.vod = self.posts[indexPath.row].vod
        cell.gas = self.posts[indexPath.row].gas
        cell.typeHome = self.posts[indexPath.row].typeHome
        cell.typeUser = self.posts[indexPath.row].typeUser
        cell.posadki = self.posts[indexPath.row].posadki
        cell.ban = self.posts[indexPath.row].ban
        cell.can = self.posts[indexPath.row].can
        cell.garage = self.posts[indexPath.row].garage
        cell.tepl = self.posts[indexPath.row].tepl
        cell.avt = self.posts[indexPath.row].avt
     
        
        for person in self.posts[indexPath.row].peopleWhoLike {
            
            if person == FIRAuth.auth()!.currentUser!.uid {
                
                cell.likeBtn.isHidden = true
                cell.unlikeBtn.isHidden = false
                break
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier:"showDetailKupitDach", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailKupitDach" {
            if let vc = segue.destination as? PreviewDachaTableViewController {
                
                let indexPaths = self.collectionView!.indexPathsForSelectedItems!
                let indexPath = indexPaths[0] as NSIndexPath
                
                vc.prices = self.posts[indexPath.row].price
                vc.zag = self.posts[indexPath.row].zg
                vc.tg = self.posts[indexPath.row].tg
                vc.fullArea = self.posts[indexPath.row].fullArea
                vc.gaArea = self.posts[indexPath.row].gaArea
                vc.property = self.posts[indexPath.row].property
                vc.nameUser = self.posts[indexPath.row].nameUser
                vc.phone = self.posts[indexPath.row].phone
                vc.email = self.posts[indexPath.row].email
                vc.el = self.posts[indexPath.row].el
                vc.typeDacha = self.posts[indexPath.row].typeHome
                vc.typeUsers = self.posts[indexPath.row].typeUser
                vc.vod = self.posts[indexPath.row].vod
                vc.gas = self.posts[indexPath.row].gas
                vc.posadki = self.posts[indexPath.row].posadki
                vc.ban = self.posts[indexPath.row].ban
                vc.garage = self.posts[indexPath.row].garage
                vc.tepl = self.posts[indexPath.row].tepl
                vc.tyal = self.posts[indexPath.row].can
                vc.avt = self.posts[indexPath.row].avt
                vc.years = self.posts[indexPath.row].years
                
                vc.image = self.posts[indexPath.row].pathToImage
                vc.prfImage = self.posts[indexPath.row].profileImage
                
            }
        }
    }
 
}
