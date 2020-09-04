//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/21/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {

   static let identifier = "IGFeedPostHeaderTableViewCell"

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style:style,reuseIdentifier:reuseIdentifier)
       contentView.backgroundColor = .systemBlue
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
   public func configure(){
       //configure cell
   }
   
   override func layoutSubviews() {
       super.layoutSubviews()
   }

}
