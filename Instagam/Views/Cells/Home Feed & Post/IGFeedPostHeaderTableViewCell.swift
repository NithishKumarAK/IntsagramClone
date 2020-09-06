//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/21/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import SDWebImage
import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate:AnyObject {
    func didTapMorebutton()
}
class IGFeedPostHeaderTableViewCell: UITableViewCell {

   static let identifier = "IGFeedPostHeaderTableViewCell"
   weak var delegate:IGFeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let userNameLabel:UILabel={
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight:.medium)
        return label
    }()
    
    private let moreButton:UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style:style,reuseIdentifier:reuseIdentifier)
    
    contentView.addSubview(profilePhotoImageView)
    contentView.addSubview(userNameLabel)
    contentView.addSubview(moreButton)
    moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
   }
    
    @objc func didTapButton(){
        delegate?.didTapMorebutton()
    }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   
    public func configure(with model:User){
        userNameLabel.text = model.userName
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
        //profielPhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
   }
   
   override func layoutSubviews() {
       super.layoutSubviews()
    let size = contentView.height - 4
    profilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
    profilePhotoImageView.layer.cornerRadius = size/2
    moreButton.frame = CGRect(x: contentView.with-size, y: 2, width: size, height: size)
    userNameLabel.frame = CGRect(x: profilePhotoImageView.right+10, y: 2, width: contentView.with-(size*2)-15, height: contentView.height - 4)
    
   }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profilePhotoImageView.image = nil
        userNameLabel.text = nil
    }

}
