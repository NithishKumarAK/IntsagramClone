//
//  UserFollowTableViewCell.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/25/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

protocol UserFollowTableViewCellDelegate :AnyObject{
    func didTapFollowUnfollowButton(model:UserRelationship)
}

enum FollowState{
    case following , not_following
}
struct UserRelationship{
    let userName:String
    let name:String
    let type:FollowState
}
 
class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    weak var delegate:UserFollowTableViewCellDelegate?
    private var model:UserRelationship?
    
    private let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel:UILabel={
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Joe"
        return label
    }()
    
    
    private let userNameLabel:UILabel={
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@joe"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowButton(){
        guard let model = model else { return }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    public func configure(with model:String){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        let buttonWidth = contentView.with > 500 ? 220.0 : contentView.with/3
        let labelHeight = contentView.height/2
        
        followButton.frame = CGRect(x:contentView.with - 5 - buttonWidth, y: 15, width: buttonWidth, height: 40)
        nameLabel.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.with - 8 - profileImageView.with - buttonWidth, height: labelHeight)
        userNameLabel.frame = CGRect(x: profileImageView.right + 5, y:nameLabel.bottom, width: contentView.with - 8 - profileImageView.with - buttonWidth, height: labelHeight)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:UserRelationship){
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.userName
        switch model.type {
        case .following:
            //Show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 1
        }
    
   }
}
