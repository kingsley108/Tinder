

import Foundation
import UIKit

extension HomeController: SaveSettingsNotifier {
    
    func didSaveRequests() {
        DispatchQueue.main.async {
            self.fetchUsers()
        }
    }
    
}
