//
//  ViewController.swift
//  NewNotifications
//
//  Created by Andrew Miller on 30/04/2018.
//  Copyright © 2018 Andrew Miller. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Request permission
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    @IBAction func notifyBtnPressed(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Notification access granted")
            } else {
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        //Only for Extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
        
    }
}

