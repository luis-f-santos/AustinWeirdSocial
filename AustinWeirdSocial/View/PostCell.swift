//
//  PostCell.swift
//  AustinWeirdSocial
//
//  Created by Luis Santos on 9/25/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            
            //coming from cache
            self.postImg.image = img
            
        } else {
            
            //Need to download from web
            let ref = Storage.storage().reference(forURL: post.imageUrl)
            
            //maxSize = 2Mb
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                
                if error != nil {
                    print("LUIS: Unable to download image from FirebaseStorage")
                } else {
                    
                    print("LUIS: Successfull Downloaded from firebase storage")
                    
                    if let imgData = data {
                        if let img = UIImage(data: imgData){
                            self.postImg.image = img
                            FeedViewController.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                            
                        }
                    }
                    
                    
                }
                
            })
        }
    }

}
