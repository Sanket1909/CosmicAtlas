//
//  UserProfile.swift
//  CosmicAtlas
//
//  Created by Sanket Patel  on 2023-09-15.
//

import Foundation
import FirebaseFirestoreSwift

struct UserProfile: Identifiable, Codable {
    @DocumentID var id: String?
    var fullName: String
    var email: String
    var phoneNumber: String
}

