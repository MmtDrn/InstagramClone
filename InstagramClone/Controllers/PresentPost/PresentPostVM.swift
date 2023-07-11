//
//  PresentPostVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 9.06.2023.
//

import UIKit

enum PresentPostVMStateChange: StateChange {
    
}

class PresentPostVM: StatefulVM<PresentPostVMStateChange> {
    
    let dataSource = PresentPostDS()
    var scrollIndex: Int?
    var presentType: PresentPostType?
}
