//
//  ViewController.swift
//  GLTrashAnimation
//
//  Created by grenlight on 15/4/1.
//  Copyright (c) 2015年 grenlight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var trashOpened: Bool = false;
    var trashView: GLTrashAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        if trashView == nil {
            var centerX: CGFloat = (UIScreen.mainScreen().bounds.size.width - 40) / 2.0
            trashView = GLTrashAnimationView(frame: CGRectMake(centerX, 120, 40, 70))
        }
        self.view.addSubview(trashView!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func animateTrash(sender: UIButton) {
        if trashOpened {
            trashView?.closeCover()
        }
        else {
            trashView?.openCover()
        }
        trashOpened = !trashOpened
    }

}

