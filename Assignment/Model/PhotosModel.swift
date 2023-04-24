//
//  PhotosModel.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import Foundation

// MARK: - TransactionModelElement
struct PhotosModel:Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?
}
