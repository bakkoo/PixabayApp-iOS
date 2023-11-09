//MARK: - Image Model

struct ImageModel: Codable {
    let total: Int
    let totalHits: Int
    let hits: [Hit]
}

// MARK: - Hit

struct Hit: Codable {
    let id: Int
    let pageURL: String
    let type, tags: String
    let previewURL: String
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL: String
    let fullHDURL: String?
    let imageURL: String?
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, likes, comments, userID: Int
    let user: String
    let userImageURL: String

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, fullHDURL, imageURL, imageWidth, imageHeight, imageSize, views, downloads, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}
