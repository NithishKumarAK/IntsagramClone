//
//  ViewController.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/17/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header:PostRenderViewModel
    let post:PostRenderViewModel
    let action:PostRenderViewModel
    let comments:PostRenderViewModel
}
class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView:UITableView={
        let tableView = UITableView()
        //Register Cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        craeteMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func craeteMockModels(){
        
        let user = User(userName: "joe ", bio: "", name: (first:"", last:""), profilePhoto: URL(string: "https://www.google.com")!, birthDate: Date(), gender: .male, count: UserCount(following: 1, follower: 1, post: 1), joinedDate: Date())
        
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL:  URL(string: "https://www.google.com")!, caption: nil , likeCount: [], comment: [], craetedDate: Date(), taggedUser: [],owner: user)
        
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)", userName: "@jenny", text: "This is the best post I have ever seen ", createdDate: Date(), likes: []))
        }
        
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    action: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func handleNotAuthenticated(){
        //Check Auth status
        if Auth.auth().currentUser == nil{
            //Show LoginVC
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC,animated: false)
            
        }
    }
    
    
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model:HomeFeedRenderViewModel
        if x==0{
            model = feedRenderModels[0]
        }
        else{
            let position = x%4 == 0 ? x/4:((x-(x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subsection = x % 4
        if subsection == 0 {
            //header
            return 1
        }
        else if subsection == 1{
            //post
            return 1
        }
        else if subsection == 2{
            //action
            return 1
        }
        else if subsection == 3{
            //comments
            let coomentsModel = model.comments
            switch coomentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2:comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model:HomeFeedRenderViewModel
        if x==0{
            model = feedRenderModels[0]
        }
        else{
            let position = x%4 == 0 ? x/4:((x-(x%4))/4)
            model = feedRenderModels[position]
        }
        
        
        
        let subsection = x % 4
        if subsection == 0 {
            //header
            switch model.header.renderType{
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subsection == 1{
            //post
            switch model.post.renderType{
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
             case .comments, .actions, .header: return UITableViewCell()
            }
        }
        else if subsection == 2{
            //action
            switch model.action.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath)
                return cell
            case .comments, .header, .primaryContent :  return UITableViewCell()
            }
        }
        else if subsection == 3{
            //comments
            switch model.comments.renderType{
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath)
                return cell
            case .actions, .header, .primaryContent:return UITableViewCell()
            }
        }
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection = indexPath.section % 4
        if subsection == 0 {
            //Header
            return 70
        }
        else if subsection == 1{
            //Post
            return tableView.with
        }
        else if subsection == 2 {
            //Actions
            return 60
        }
        else if subsection == 3 {
            //Comment row
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section%4
        return subsection == 3 ? 70:0
    }
    
}
