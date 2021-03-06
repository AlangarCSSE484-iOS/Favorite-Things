//
//  ViewController.swift
//  Favorite Things
//
//  Created by CSSE Department on 4/5/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var docRef: DocumentReference!
    var favoriteThingsListener: ListenerRegistration!
    var favoriteNumber: Int = 3000
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        docRef = Firestore.firestore().collection("favoriteThings").document("myDocID")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteThingsListener = docRef.addSnapshotListener({ (documentSnapshot, error) in
            if let error = error {
                print ("Error fetching document. \(error.localizedDescription)")
                return
            }

            self.colorLabel.text = documentSnapshot!.get("color") as? String
            
            self.favoriteNumber = (documentSnapshot!.get("number") as? Int)!
            self.numberLabel.text = String(self.favoriteNumber)
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteThingsListener.remove()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressedRed(_ sender: Any) {
        docRef.updateData(["color": "red"])
    }
    
    @IBAction func pressedWhite(_ sender: Any) {
        docRef.updateData(["color": "WHITE"])
    }
    
    @IBAction func pressedBlue(_ sender: Any) {
        docRef.updateData(["color": "BLUEEEEEE"])
    }
    
    @IBAction func pressedFetchColorOnce(_ sender: Any) {
        //this isn't needed once we did viewWillAppear....how neat!
        docRef.getDocument { (documentSnapshot, error) in
            if let error = error {
                print ("Error fetching document. \(error.localizedDescription)")
                return
            }
            //you'll either get an error or a document snapshot
            //so at this point, we know we have a document snapshot
            self.colorLabel.text = documentSnapshot!.get("color") as? String
        }
    }
    
    @IBAction func pressedIncrement(_ sender: Any) {
        docRef.updateData(["number": favoriteNumber + 1])
    }
    
    @IBAction func pressedDecrement(_ sender: Any) {
        docRef.updateData(["number" : favoriteNumber - 1])
    }
    
    
}

