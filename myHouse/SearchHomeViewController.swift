//
//  SearchHomeViewController.swift
//  myHouse
//
//  Created by Valera Petin on 08.05.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class SearchHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post]()
    var im = UIImage()
    var pathIm: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Прячущийся navigation bar
        //self.navigationController?.hidesBarsOnSwipe = true
        
        //Кнопка назад без названия
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        fetchPosts()
    }
    
    //Получить и запостить данные в пост
    func fetchPosts(){
        
        
        let ref = FIRDatabase.database().reference()
        
        if (FIRAuth.auth()?.currentUser?.uid) != nil{
            
            ref.child("Аренда").child("Квартиры").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                
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
                            let fullArea = post["Общая площадь"] as? String,
                            let livingArea = post["Жилая площадь"] as? String,
                            let kitchenArea = post["Кухня"] as? String,
                            let property = post["Описание"] as? String,
                            let nameUser = post["Контактное лицо"] as? String,
                            let phone = post["Телефон"] as? String,
                            let email = post["email"] as? String,
                            let number = post["Кол-во комнат"] as? String,
                            let floor = post["Этаж"] as? String,
                            let floorsHome = post["Этажей в доме"] as? String,
                            let typeHome = post["Тип квартиры"] as? String,
                            let typeUser = post["Тип пользователя"] as? String,
                            let plan = post["Планировка"] as? String,
                            let bathroom = post["Санузел"] as? String,
                            let rem = post["Ремонт"] as? String,
                            let time = post["Срок аренды"] as? String,
                            let typeDom = post["Тип дома"] as? String,
                            let years = post["Год постройки"] as? String,
                            let mat = post["Материал дома"] as? String,
                            let com = post["Коммунальные платежи"] as? String,
                            let wifi = post["Интернет"] as? String,
                            let meb = post["Мебель"] as? String,
                            let hol = post["Холодильник"] as? String
 
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
                            posst.livingArea = livingArea
                            posst.kitchenArea = kitchenArea
                            posst.property = property
                            posst.nameUser = nameUser
                            posst.phone = phone
                            posst.email = email
                            posst.number = number
                            posst.floor = floor
                            posst.floorsHome = floorsHome
                            posst.typeHome = typeHome
                            posst.typeUser = typeUser
                            posst.plan = plan
                            posst.bathroom = bathroom
                            posst.rem = rem
                            posst.time = time
                            posst.typeDom = typeDom
                            posst.years = years
                            posst.mat = mat
                            posst.com = com
                            posst.wifi = wifi
                            posst.meb = meb
                            posst.hol = hol
 
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellSnyatHome", for: indexPath) as! PostSnyatHomeCell
        
        //creating the cell
        
        cell.postImage.sd_setImage(with: URL(string: self.posts[indexPath.row].pathToImage), placeholderImage: UIImage(named: "user_placeholder.png"))
        cell.zgLabel.text = self.posts[indexPath.row].zg
        cell.priceLabel.text = self.posts[indexPath.row].price
        cell.postID = self.posts[indexPath.row].postID
        
        cell.profileImage = self.posts[indexPath.row].profileImage
        cell.tg = self.posts[indexPath.row].tg
        cell.fullArea = self.posts[indexPath.row].fullArea
        cell.livingArea = self.posts[indexPath.row].livingArea
        cell.kitchenArea = self.posts[indexPath.row].kitchenArea
        cell.property = self.posts[indexPath.row].property
        cell.nameUser = self.posts[indexPath.row].nameUser
        cell.phone = self.posts[indexPath.row].phone
        cell.email = self.posts[indexPath.row].email
        cell.number = self.posts[indexPath.row].number
        cell.floor = self.posts[indexPath.row].floor
        cell.floorsHome = self.posts[indexPath.row].floorsHome
        cell.typeHome = self.posts[indexPath.row].typeHome
        cell.typeUser = self.posts[indexPath.row].typeUser
        cell.plan = self.posts[indexPath.row].plan
        cell.bathroom = self.posts[indexPath.row].bathroom
        cell.rem = self.posts[indexPath.row].rem
        cell.time = self.posts[indexPath.row].time
        cell.typeDom = self.posts[indexPath.row].typeDom
        cell.years = self.posts[indexPath.row].years
        cell.mat = self.posts[indexPath.row].mat
        cell.com = self.posts[indexPath.row].com
        cell.wifi = self.posts[indexPath.row].wifi
        cell.meb = self.posts[indexPath.row].meb
        cell.hol = self.posts[indexPath.row].hol
 
        
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
        self.performSegue(withIdentifier:"showDetailSnyatHome", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSnyatHome" {
            if let vc = segue.destination as? PreviewHomeTableViewController {
                
                let indexPaths = self.collectionView!.indexPathsForSelectedItems!
                let indexPath = indexPaths[0] as NSIndexPath
                
                vc.prices = self.posts[indexPath.row].price
                vc.zag = self.posts[indexPath.row].zg
                vc.tg = self.posts[indexPath.row].tg
                vc.fullArea = self.posts[indexPath.row].fullArea
                vc.livingArea = self.posts[indexPath.row].livingArea
                vc.kitchenArea = self.posts[indexPath.row].kitchenArea
                vc.property = self.posts[indexPath.row].property
                vc.nameUser = self.posts[indexPath.row].nameUser
                vc.phone = self.posts[indexPath.row].phone
                vc.email = self.posts[indexPath.row].email
                vc.number = self.posts[indexPath.row].number
                vc.floor = self.posts[indexPath.row].floor
                vc.floorsHome = self.posts[indexPath.row].floorsHome
                vc.typeHome = self.posts[indexPath.row].typeHome
                vc.typeUsers = self.posts[indexPath.row].typeUser
                vc.plan = self.posts[indexPath.row].plan
                vc.bathroom = self.posts[indexPath.row].bathroom
                vc.rem = self.posts[indexPath.row].rem
                vc.time = self.posts[indexPath.row].time
                vc.typeDom = self.posts[indexPath.row].typeDom
                vc.years = self.posts[indexPath.row].years
                vc.matr = self.posts[indexPath.row].mat
                vc.com = self.posts[indexPath.row].com
                vc.wifi = self.posts[indexPath.row].wifi
                vc.meb = self.posts[indexPath.row].meb
                vc.hol = self.posts[indexPath.row].hol
                
                vc.image = self.posts[indexPath.row].pathToImage
                vc.prfImage = self.posts[indexPath.row].profileImage
                
            }
        }
    }
 
}
