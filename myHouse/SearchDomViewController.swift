//
//  SearchDomViewController.swift
//  myHouse
//
//  Created by Valera Petin on 04.05.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class SearchDomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts = [Post]()
    var im = UIImage()
    var pathIm: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Скрывающийся navigation bar
        //self.navigationController?.hidesBarsOnSwipe = true
        
        //Кнопка назад без названия
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        fetchPosts()
    }
    
    //Получить и запостить данные в пост
    func fetchPosts(){
        
        
        let ref = FIRDatabase.database().reference()
        
        if (FIRAuth.auth()?.currentUser?.uid) != nil{
            
            ref.child("Продажа").child("Дома").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snap) in
                
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
                            let gaArea = post["Участок"] as? String,
                            let typeDom = post["Тип объекта"] as? String,
                            let vod = post["Водоснабжение"] as? String,
                            let gas = post["Газоснабжение"] as? String,
                            let otop = post["Отопление"] as? String,
                            let otopType = post["Тип отопления"] as? String,
                            let can = post["Канализация"] as? String,
                            let mat = post["Материал дома"] as? String,
                            let el = post["Электроснабжение"] as? String,
                            let years = post["Год постройки"] as? String,
                            let property = post["Описание"] as? String,
                            let nameUser = post["Контактное лицо"] as? String,
                            let phone = post["Телефон"] as? String,
                            let email = post["email"] as? String,
                            let number = post["Комнат"] as? String,
                            let floorsHome = post["Этажей в доме"] as? String,
                            let typeUser = post["Тип пользователя"] as? String,
                            let plan = post["Планировка"] as? String,
                            let bathroom = post["Санузел"] as? String
                        
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
                            posst.gaArea = gaArea
                            posst.typeDom = typeDom
                            posst.vod = vod
                            posst.gas = gas
                            posst.otop = otop
                            posst.otopType = otopType
                            posst.can = can
                            posst.mat = mat
                            posst.el = el
                            posst.years = years
                            posst.property = property
                            posst.nameUser = nameUser
                            posst.phone = phone
                            posst.email = email
                            posst.number = number
                            posst.floorsHome = floorsHome
                            posst.typeUser = typeUser
                            posst.plan = plan
                            posst.bathroom = bathroom
                       
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCellKupitDom", for: indexPath) as! PostKupitDomCell
        
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
        cell.gaArea = self.posts[indexPath.row].gaArea
        cell.typeDom = self.posts[indexPath.row].typeDom
        cell.vod = self.posts[indexPath.row].vod
        cell.gas = self.posts[indexPath.row].gas
        cell.otop = self.posts[indexPath.row].otop
        cell.otopType = self.posts[indexPath.row].otopType
        cell.can = self.posts[indexPath.row].can
        cell.mat = self.posts[indexPath.row].mat
        cell.el = self.posts[indexPath.row].el
        cell.years = self.posts[indexPath.row].years
        cell.property = self.posts[indexPath.row].property
        cell.nameUser = self.posts[indexPath.row].nameUser
        cell.phone = self.posts[indexPath.row].phone
        cell.email = self.posts[indexPath.row].email
        cell.number = self.posts[indexPath.row].number
        cell.floorsHome = self.posts[indexPath.row].floorsHome
        cell.typeUser = self.posts[indexPath.row].typeUser
        cell.plan = self.posts[indexPath.row].plan
        cell.bathroom = self.posts[indexPath.row].bathroom
    
       
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
        self.performSegue(withIdentifier:"showDetailKupitDom", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailKupitDom" {
            if let vc = segue.destination as? PreviewDomTableViewController {
                
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
                vc.floorsHome = self.posts[indexPath.row].floorsHome
                vc.typeUsers = self.posts[indexPath.row].typeUser
                vc.typeDom = self.posts[indexPath.row].typeDom
                vc.plan = self.posts[indexPath.row].plan
                vc.bathroom = self.posts[indexPath.row].bathroom
                vc.vod = self.posts[indexPath.row].vod
                vc.gas = self.posts[indexPath.row].gas
                vc.otop = self.posts[indexPath.row].otop
                vc.otopType = self.posts[indexPath.row].otopType
                vc.can = self.posts[indexPath.row].can
                vc.el = self.posts[indexPath.row].el
                vc.mat = self.posts[indexPath.row].mat
                vc.gaArea = self.posts[indexPath.row].gaArea
                vc.years = self.posts[indexPath.row].years

                
                vc.image = self.posts[indexPath.row].pathToImage
                vc.prfImage = self.posts[indexPath.row].profileImage
            
            }
        }
    }
}
