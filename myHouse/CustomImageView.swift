//
//  CustomImageView.swift
//  
//
//  Created by Valera Petin on 12.02.17.
//
//

import UIKit

//Круглое фото в профиле
@IBDesignable class CustomImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet{
            
            layer.cornerRadius = cornerRadius
        }
    }

    
    @IBInspectable var borderWidht: CGFloat = 0 {
        
        didSet{
            
            layer.borderWidth = borderWidht
        }
    }
}
