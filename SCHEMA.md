SCHEMA
====
```swift
class Story {

  static let type = "Story"

  var title: String
  var desc: String?
  var photoIds: [String]
  var hashtags: [String]
  var reminder: [String: AnyObject]?

  var interactionCount: Int
  var commentCount: Int

  var creatorId: String

  var createdAt: NSDate
  var updatedAt: NSDate?

  var photoCount: Int
}
```
```swift
class Photo {

  static let type = "Photo"

  var caption: String?
  var interactionCount: Int

  var storyId: String

  var createdAt: NSDate
  var creatorId: String

  var localPath
```
```

class User {

  static let type = "User"

  var username: String
  var email: String

  static let currentUserId = "really-unique-user-id"
}
```
```swift
class Interaction {

  enum Type {
    case SimpleSmile
    case ThumbUp
    case HeartEyes
  }

  var id: String
  var type: Type
  var createdAt: NSDate
  var createdBy: User
  var photoId: String?
  var storyId: String
}
```
```swift
class Comment {
  var id: String
  var content: String
  var createdAt: NSDate
  var createdBy: User
  var photoId: String?
  var storyId: String
}
```
