//
//  ViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-16.
//

import UIKit

class ViewController: UIViewController {
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(systemName: "paperplane")
        return imageView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(logoImageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3){
//            let homeVC = HomeVC(nibName: "HomeVC", bundle: nil)
//            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        logoImageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0){
            self.animate()
        }
    }
    
    private func animate(){
        
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 2
            let diffx = size - self.view.frame.size.width
            let diffy = self.view.frame.size.height - size
            
            self.logoImageView.frame = CGRect(x: -(diffx/2), y: diffy/2, width: size, height: size)
            
            self.logoImageView.alpha = 0
        }
    }
}

