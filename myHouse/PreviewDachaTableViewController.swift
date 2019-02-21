//
//  PreviewDachaTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 08.05.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import SDWebImage

class PreviewDachaTableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var zg: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var trg: UILabel!
    @IBOutlet weak var full: UILabel!
    @IBOutlet weak var gaAr: UILabel!
    @IBOutlet weak var prop: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phones: UILabel!
    @IBOutlet weak var em: UILabel!
    @IBOutlet weak var ele: UILabel!
    @IBOutlet weak var typeUs: UILabel!
    @IBOutlet weak var typeDm: UILabel!
    @IBOutlet weak var vd: UILabel!
    @IBOutlet weak var gs: UILabel!
    @IBOutlet weak var posad: UILabel!
    @IBOutlet weak var banya: UILabel!
    @IBOutlet weak var tyalet: UILabel!
    @IBOutlet weak var garag: UILabel!
    @IBOutlet weak var tep: UILabel!
    @IBOutlet weak var avtb: UILabel!
    @IBOutlet weak var yrs: UILabel!
    
    var img: UIImage?
    var image: String!
    var prfImage: String!
    var zag = ""
    var prices = ""
    var tg = ""
    var fullArea = ""
    var gaArea = ""
    var property = ""
    var nameUser = ""
    var phone = ""
    var email = ""
    var el = ""
    var floorsHome = ""
    var typeUsers = ""
    var typeDacha = ""
    var vod = ""
    var gas = ""
    var posadki = ""
    var ban = ""
    var tyal = ""
    var garage = ""
    var tepl = ""
    var avt = ""
    var years = ""
    
    
    private let tableHeaderViewHeight: CGFloat = 300.0  // CODE CHALLENGE: make this height dynamic with the height of the VC - 3/4 of the height
    private let tableHeaderViewCutaway: CGFloat = 50.0
    
    var headerMaskLayer: CAShapeLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = zag
        
        _ = imageView.sd_setImage(with: URL(string: self.image), placeholderImage: UIImage(named: "user_placeholder.png"))
        _ = profileImage.sd_setImage(with: URL(string: self.prfImage), placeholderImage: UIImage(named: "user_placeholder.png"))
        
        price.text = prices
        zg.text = zag
        trg.text = tg
        full.text = fullArea
        gaAr.text = gaArea
        prop.text = property
        name.text = nameUser
        phones.text = phone
        em.text = email
        ele.text = el
        typeUs.text = typeUsers
        typeDm.text = typeDacha
        vd.text = vod
        gs.text = gas
        posad.text = posadki
        banya.text = ban
        tyalet.text = tyal
        garag.text = garage
        tep.text = tepl
        avtb.text = avt
        yrs.text = years
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableHeaderView = nil
        tableView.addSubview(imageView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderViewHeight + 64)
        
        // cut away the header view
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        imageView.layer.mask = headerMaskLayer
        
        let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        updateHeaderView()
    }
    
    func updateHeaderView()
    {
        let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderViewHeight)
        
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderViewCutaway/2
        }
        
        
        imageView.frame = headerRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - tableHeaderViewCutaway))
        
        headerMaskLayer?.path = path.cgPath
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}

