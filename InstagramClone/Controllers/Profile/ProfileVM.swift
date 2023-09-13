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
    var following: [String]?
    var follower: [String]?
    var profilType: ProfilType?
    var userName: String?
    var fullName: String?
    var pfURL: String?
    
    func getPostData() {
        guard let profilType else { return }

        switch profilType {

        case .oneself:
            if let pfImageString = Defs.shared.userModel?.profilImageURL { self.pfURL = pfImageString }
            if let following = Defs.shared.userModel?.followingUID { self.following = following }
            if let follower = Defs.shared.userModel?.followerUID { self.follower = follower }
            guard let uid = Defs.shared.userModel?.uuid else { return }
            self.getPostsService(uid: uid)
        case .anyone(let uid):
            FirebaseUserDataManager.shared.getUserdata(userDataType: .userName, uid: uid) { [weak self] (data: String?, error) in
                guard let self, let data else { return }
                self.userName = data
                self.getPostsService(uid: uid)
            }
            
            FirebaseUserDataManager.shared.getUserdata(userDataType: .fullName, uid: uid) { [weak self] (data:String?, error) in
                guard let self, let data else { return }
                self.fullName = data
            }
            
            FirebaseUserDataManager.shared.getUserdata(userDataType: .profilImageUrl, uid: uid) { [weak self] (data: String?, error) in
                guard let self else { return }
                if error == nil {
                    guard let data else { return }
                    self.pfURL = data
                }
            }
            
            FirebaseUserDataManager.shared.getUserdata(userDataType: .followers, uid: uid) { [weak self] (data: [String]?, error) in
                guard let self else { return }
                if error == nil {
                    guard let data else { return }
                    self.follower = data
                }
            }
            
            FirebaseUserDataManager.shared.getUserdata(userDataType: .followed, uid: uid) { [weak self] (data: [String]?, error) in
                guard let self else { return }
                if error == nil {
                    guard let data else { return }
                    self.following = data
                }
            }
        }
    }
    
    private func getPostsService(uid: String) {
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
    
    public func checkFollowStatus(uid: String) -> Bool {
        guard let followed = Defs.shared.userModel?.followingUID else { return false }
        return followed.contains(uid)
    }
}
