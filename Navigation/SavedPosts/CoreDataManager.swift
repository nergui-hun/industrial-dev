//
//  CoreDataManager.swift
//  Navigation
//
//  Created by M M on 2/25/23.
//

import Foundation
import StorageService
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    // MARK: - Values

    var posts: [SavedPosts] = []
    private lazy var context = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
        })
            return container
    } ()

    //MARK: - Core Data Saving support

    func saveContext() {

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unsolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func reloadPosts() {
        let fetchRequest = SavedPosts.fetchRequest()
        posts = (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? []
    }

    func getContext() {
        do {
            posts = try context.fetch(SavedPosts.fetchRequest())
            reloadPosts()
        } catch {

        }
    }

    func addPost(post: Post) {
        if isPostUnique(post: post) {
            persistentContainer.performBackgroundTask { context in

                let newPost = SavedPosts(context: context)
                newPost.author = post.author
                newPost.postText = post.postText
                newPost.image = post.image
                newPost.likes = Int16(post.likes)
                newPost.views = Int16(post.views)

                do {
                    try context.save()
                    print("Post added")
                } catch {
                    print("CoreData error: \(error)")
                }
            }
        } else {
            print("CoreDataManager | addPost | post isn't unique")
        }
    }

    func getPost(id: Int) {

    }

    func deletePost(post: SavedPosts) {
                context.delete(post)
                saveContext()
                reloadPosts()
    }
    
    func isPostUnique(post: Post) -> Bool {
        let fetchRequest = SavedPosts.fetchRequest()
        do {
            if (try context.fetch(fetchRequest).first(where: {
                $0.author == post.author && $0.image == post.image &&
                $0.postText == post.postText })) != nil {
                return false
            }
        } catch {
            print("CoreData error: \(error)")
        }
        return true
    }
}
