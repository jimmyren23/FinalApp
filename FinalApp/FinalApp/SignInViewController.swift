//
//  ViewController.swift
//  FinalApp
//
//  Created by Jimmy Ren on 11/20/20.
//

import UIKit

class SignInViewController: UIViewController, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
    
    private let SpotifyClientID = "4a5ae094e4e34f31bb6bcbf25f5ab3b4"
    private var SpotifyClientIDSecret = "c89ef520d15e456a849e100e14037455"
    private let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!
    var signedIn = false;
    
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var SignInButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.text = "Waiting for Username..."
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignIn(_ sender: Any) {
        signedIn = true
        UserName.text = "hello"
        let scope: SPTScope = [.appRemoteControl, .userReadEmail, .userTopRead]
        
       if #available(iOS 11, *) {
           // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
           sessionManager.initiateSession(with: scope, options: .clientOnly)
            //UserName.text = lastPlayerState?.description

       } else {
           // Use this on iOS versions < 11 to use SFSafariViewController
           sessionManager.initiateSession(with: scope, options: .clientOnly, presenting: self)
       }
        
    }
    
    private var lastPlayerState: SPTAppRemotePlayerState?
    
    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
    
    
    func update(playerState: SPTAppRemotePlayerState) {
        lastPlayerState = playerState
    }

    
    lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: self)
        return manager
    }()

    lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = self
        return appRemote
    }()
    

    // MARK: - SPTSessionManagerDelegate
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        presentAlertController(title: "Authorization Failed", message: error.localizedDescription, buttonTitle: "Bummer")
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        presentAlertController(title: "Session Renewed", message: session.description, buttonTitle: "Sweet")
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        appRemote.connectionParameters.accessToken = session.accessToken
        appRemote.connect()
    }

    // MARK: - SPTAppRemoteDelegate
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe(toPlayerState: { (success, error) in
            if let error = error {
                print("Error subscribing to player state:" + error.localizedDescription)
            }
        })
        
        fetchPlayerState()
    }

    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState({ [weak self] (playerState, error) in
            if let error = error {
                print("Error getting player state:" + error.localizedDescription)
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                self?.update(playerState: playerState)
            }
        })
    }
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        //updateViewBasedOnConnected()
        lastPlayerState = nil
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        //updateViewBasedOnConnected()
        lastPlayerState = nil
    }

    // MARK: - SPTAppRemotePlayerAPIDelegate
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        update(playerState: playerState)
    }

    // MARK: - Private Helpers
    private func presentAlertController(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            controller.addAction(action)
            self.present(controller, animated: true)
        }
    }

}

