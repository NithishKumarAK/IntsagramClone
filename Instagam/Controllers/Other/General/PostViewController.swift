//
//  PostViewController.swift
//  Instagam
//
//  Created by Akhadjon Abdukhalilov on 8/17/20.
//  Copyright © 2020 Akhadjon Abdukhalilov. All rights reserved.
//

import UIKit

/*
   Section
   - Header model
   Section
   - Post cell model
   Secton
   - action buttons cells models
   Section
   - n number of general tab model for comments

 */
///States of rendered cell
enum PostRenderType{
    case header(provider:User)
    case primaryContent(provider:UserPost) //post
    case actions(provider:String) // like , comment, share
    case comments(comments:[PostComment])
}

///Model of rendered post
struct PostRenderViewModel{
   let renderType:PostRenderType
}


class PostViewController: UIViewController {

    private let model :UserPost?
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        
        //Register Cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    //MARK:- Init
    init(model:UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func  configureModels(){
        
        guard let userPostModel = self.model else {
            return
        }
        //Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        //Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        //Comments
        var comments = [PostComment]()
        for x in 1..<4{
            comments.append(PostComment(identifier: "123_\(x)", userName: "@dave", text: "Great Post", createdDate: Date(), likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}
extension PostViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType{
        case .actions(_): return 1
        case .comments(let comments):  return comments.count>4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        }
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType{
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                      return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                      return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                      return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType{
        case .actions(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableView.with
        case .header(let user): return 70
           
        }
    }
}
