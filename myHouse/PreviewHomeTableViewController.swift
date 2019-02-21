//
//  PreviewHomeTableViewController.swift
//  myHouse
//
//  Created by Valera Petin on 08.05.17.
//  Copyright © 2017 Valery Petin. All rights reserved.
//

import UIKit
import SDWebImage

class PreviewHomeTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var zg: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var trg: UILabel!
    @IBOutlet weak var full: UILabel!
    @IBOutlet weak var living: UILabel!
    @IBOutlet weak var kitchen: UILabel!
    @IBOutlet weak var prop: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phones: UILabel!
    @IBOutlet weak var em: UILabel!
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var fl: UILabel!
    @IBOutlet weak var flo: UILabel!
    @IBOutlet weak var typ: UILabel!
    @IBOutlet weak var typD: UILabel!
    @IBOutlet weak var typeUs: UILabel!
    @IBOutlet weak var pl: UILabel!
    @IBOutlet weak var bat: UILabel!
    @IBOutlet weak var remont: UILabel!
    @IBOutlet weak var tim: UILabel!
    @IBOutlet weak var yrs: UILabel!
    @IBOutlet weak var mat: UILabel!
    @IBOutlet weak var cm: UILabel!
    @IBOutlet weak var wf: UILabel!
    @IBOutlet weak var mb: UILabel!
    @IBOutlet weak var hl: UILabel!
    
    var img: UIImage?
    var image: String!
    var prfImage: String!
    var zag = ""
    var prices = ""
    var tg = ""
    var fullArea = ""
    var livingArea = ""
    var kitchenArea = ""
    var property = ""
    var nameUser = ""
    var phone = ""
    var email = ""
    var number = ""
    var floor = ""
    var floorsHome = ""
    var typeHome = ""
    var typeUsers = ""
    var plan = ""
    var bathroom = ""
    var rem = ""
    var typeDom = ""
    var time = ""
    var years = ""
    var matr = ""
    var com = ""
    var wifi = ""
    var meb = ""
    var hol = ""
    
    
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
        living.text = livingArea
        kitchen.text = kitchenArea
        prop.text = property
        name.text = nameUser
        phones.text = phone
        em.text = email
        num.text = number
        fl.text = floor
        flo.text = floorsHome
        typ.text = typeHome
        typeUs.text = typeUsers
        pl.text = plan
        bat.text = bathroom
        remont.text = rem
        typD.text = typeDom
        tim.text = time
        yrs.text = years
        mat.text = matr
        cm.text = com
        wf.text = wifi
        mb.text = meb
        hl.text = hol
        
        
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
