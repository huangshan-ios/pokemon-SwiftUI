//
//  BaseHostingController.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 05/05/2022.
//

import SwiftUI

class BaseHostingController<ContentView: View>: UIHostingController<AnyView> {
    
    private var isHideNavigation: Bool = false

    public init(view: ContentView, isHideNavigation: Bool = false) {
        super.init(rootView: AnyView(view))
        
        self.isHideNavigation = isHideNavigation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(isHideNavigation, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(isHideNavigation, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(!isHideNavigation, animated: false)
    }

    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
