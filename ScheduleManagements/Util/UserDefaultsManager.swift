//
//  UserDefaultsManager.swift
//  ScheduleManagements
//
//  Created by Claude on 2024/07/23.
//

import Foundation
import SwiftUI
import StoreKit

/// UserDefaultsを使用してアプリの起動回数などを管理するクラス
final class UserDefaultsManager {
    // MARK: - Properties
    static let shared = UserDefaultsManager()
    
    // MARK: - Initialize
    private init() {}
    
    // MARK: - Methods
    
    /// アプリの起動回数を1増やす
    func incrementLaunchCount() {
        let count = getLaunchCount() + 1
        UserDefaults.standard.set(count, forKey: AppConst.UserDefaultsKeys.launchCount)
    }
    
    /// 現在の起動回数を取得
    func getLaunchCount() -> Int {
        return UserDefaults.standard.integer(forKey: AppConst.UserDefaultsKeys.launchCount)
    }
    
    /// 起動回数をリセット
    func resetLaunchCount() {
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultsKeys.launchCount)
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultsKeys.reviewRequested)
    }
    
    /// レビュー依頼を表示すべきかどうか判断
    func shouldShowReviewPrompt() -> Bool {
        let count = getLaunchCount()
        let reviewedCounts = UserDefaults.standard.array(forKey: AppConst.UserDefaultsKeys.reviewRequested) as? [Int] ?? []
        
        // 5回目と10回目の起動でレビュー依頼を表示
        if (count == 5 || count == 10) && !reviewedCounts.contains(count) {
            // この起動回数でレビューを表示済みとして記録
            var updatedReviewedCounts = reviewedCounts
            updatedReviewedCounts.append(count)
            UserDefaults.standard.set(updatedReviewedCounts, forKey: AppConst.UserDefaultsKeys.reviewRequested)
            return true
        }
        return false
    }
    
    /// アプリ内でレビューダイアログを表示
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
} 