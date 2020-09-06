//
//  IGFeedPostTableViewCell.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/21/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

///Cell for primary cell content
final class IGFeedPostTableViewCell: UITableViewCell {
    
    private let postImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player:AVPlayer?
    private var playerLayer = AVPlayerLayer()
    static let identifier = "IGFeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        contentView.addSubview(postImageView)
        contentView.layer.addSublayer(playerLayer)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(post:UserPost){
        postImageView.image = UIImage(named: "test")
        return
        switch post.postType {
        case .photo:
            //Show image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video: break
        //load play video
        player = AVPlayer(url: post.postURL)
        playerLayer.player?.volume = 0
        playerLayer.player?.play()
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
}
