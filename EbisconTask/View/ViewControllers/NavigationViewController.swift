//
//  NavigationViewController.swift
//  EbisconTask
//
//  Created by SELCUK YILDIZ on 07.02.23.
//

import UIKit

class NavigationViewController: UINavigationController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
                
      let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 36, weight: .light)]
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: (navigationBar.frame.width), height: 300)

        appearance.configureWithTransparentBackground()
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactScrollEdgeAppearance = appearance

        // Do any additional setup after loading the view.
    }
    

}


import SwiftUI

struct AppView : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> NavigationViewController {
        NavigationViewController(rootViewController: DiscoveryViewController())
    }
    
    func updateUIViewController(_ uiViewController: NavigationViewController, context: Context) {
        
    }
    
}


struct AppXPreview : PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
