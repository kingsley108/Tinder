

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
    func transitionToUserDetails(cardModel: CardViewModel) {
        let userDetailsPage = UserDetailsController()
        userDetailsPage.cardModel = cardModel
        userDetailsPage.modalPresentationStyle = .fullScreen
        present(userDetailsPage, animated: true)
    }
}
