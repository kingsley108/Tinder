

import Foundation
import UIKit

extension HomeController: SaveSettingsNotifier {
    
    func didSaveRequests() {
        DispatchQueue.main.async {
            self.fetchUsers()
        }
    }
    
}

extension HomeController: HomeControllerUserRequest {
    func newUserRefetching() {
        self.fetchCurrentUser()
    }
}

extension HomeController: HomeUserDetailsTransition {
    func transitionToUserDetails() {
        let userDetailsPage = UserDetailsController()
        userDetailsPage.modalPresentationStyle = .fullScreen
        present(userDetailsPage, animated: true)
    }
    
    
}
