//
//  SpotifyInfo.swift
//  FinalApp
//
//  Created by Jimmy Ren on 12/3/20.
//

import Foundation


struct Constants {
    let SpotifyClientID = "4a5ae094e4e34f31bb6bcbf25f5ab3b4"
    let SpotifyRedirectURL = URL(string: "spotify-ios-quick-start://spotify-login-callback")!

    lazy var configuration = SPTConfiguration(
      clientID: SpotifyClientID,
      redirectURL: SpotifyRedirectURL
    )
}
