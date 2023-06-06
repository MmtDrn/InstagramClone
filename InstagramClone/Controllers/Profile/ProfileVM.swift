//
//  ProfileVM.swift
//  InstagramClone
//
//  Created by mehmet duran on 4.06.2023.
//

import UIKit

enum ProfileVMStateFullVM: StateChange {
    case showAlert(String)
    case setPostModelsSuccess
}

class ProfileVM: StatefulVM<ProfileVMStateFullVM> {
    
    let dataSource = ProfilDS()
    var postModels = [PostModel]()
    
    func getPostData() {
        guard let uid = Defs.shared.userModel?.uuid else { return }
        self.postModels.removeAll()
        FirebasePostManager.shared.getPostData(uid: uid) { [weak self] (models, error) in
            guard let self else { return }
            if let error {
                print(error.localizedDescription)
            } else {
                guard let models else { return }
                for model in models {
                    self.postModels.append(model)
                }
                self.dataSource.postModels = self.postModels.sorted { (model1, model2) -> Bool in
                    guard let date1 = model1.date?.toDate(), let date2 = model2.date?.toDate() else {
                        return false
                    }
                    return date1 > date2
                }
                self.emit(.setPostModelsSuccess)
            }
        }
    }
    
    public func logOut() {
        FirebaseAuthManager.shared.logOut { [weak self] result in
            guard let self else { return }
            switch result {
                
            case .success(_):
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                      let window = sceneDelegate.window else { return }
                let controller = UINavigationController(rootViewController: LoginVC())
                window.rootViewController = controller
            case .failure(let error):
                self.emit(.showAlert(error.localizedDescription))
            }
        }
    }
}
