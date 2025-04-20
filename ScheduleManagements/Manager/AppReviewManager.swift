//
//  AppReviewManager.swift
//  ScheduleManagements
//
//  Created by Claude on 2024/07/23.
//

import Foundation
import StoreKit

/// アプリレビュー表示を管理するクラス
final class AppReviewManager: ObservableObject {
    // MARK: - Properties
    static let shared = AppReviewManager()
    
    // レビュー表示のトリガーとなる起動回数
    private let reviewTriggerCounts = [5, 10]
    
    // レビュー表示のトリガーとなる変更完了ボタン押下回数
    private let saveButtonTriggerCounts = [5, 25]
    
    // MARK: - Initialize
    private init() {}
    
    // MARK: - Methods
    
    /// アプリ起動時に呼び出し、カウンターを更新
    func incrementLaunchCount() {
        let currentCount = UserDefaults.standard.integer(forKey: AppConst.UserDefaultsKeys.launchCount)
        let newCount = currentCount + 1
        UserDefaults.standard.set(newCount, forKey: AppConst.UserDefaultsKeys.launchCount)
        
        // 5回目または10回目の起動時にレビューリクエストを表示
        checkAndRequestReview(for: newCount)
    }
    
    /// 変更完了ボタン押下時に呼び出し、カウンターを更新
    func incrementSaveButtonTapCount() {
        let currentCount = UserDefaults.standard.integer(forKey: AppConst.UserDefaultsKeys.saveButtonTapCount)
        let newCount = currentCount + 1
        UserDefaults.standard.set(newCount, forKey: AppConst.UserDefaultsKeys.saveButtonTapCount)
        
        // 5回目または25回目の変更完了ボタン押下時にレビューリクエストを表示
        checkAndRequestReviewForSaveButton(for: newCount)
    }
    
    /// 現在のカウントに基づいてレビューリクエストを表示するか判断
    private func checkAndRequestReview(for count: Int) {
        // カウントが5または10で、まだそのカウントでレビューをリクエストしていない場合
        if reviewTriggerCounts.contains(count) {
            let requestedCounts = UserDefaults.standard.array(forKey: AppConst.UserDefaultsKeys.reviewRequested) as? [Int] ?? []
            
            if !requestedCounts.contains(count) {
                // そのカウントでレビューをリクエスト済みとして記録
                var updatedRequestedCounts = requestedCounts
                updatedRequestedCounts.append(count)
                UserDefaults.standard.set(updatedRequestedCounts, forKey: AppConst.UserDefaultsKeys.reviewRequested)
                
                // レビューをリクエスト
                requestReview()
            }
        }
    }
    
    /// 変更完了ボタン押下回数に基づいてレビューリクエストを表示するか判断
    private func checkAndRequestReviewForSaveButton(for count: Int) {
        // カウントが5または25で、まだそのカウントでレビューをリクエストしていない場合
        if saveButtonTriggerCounts.contains(count) {
            let requestedCounts = UserDefaults.standard.array(forKey: AppConst.UserDefaultsKeys.reviewRequested) as? [Int] ?? []
            
            if !requestedCounts.contains(count) {
                // そのカウントでレビューをリクエスト済みとして記録
                var updatedRequestedCounts = requestedCounts
                updatedRequestedCounts.append(count)
                UserDefaults.standard.set(updatedRequestedCounts, forKey: AppConst.UserDefaultsKeys.reviewRequested)
                
                // レビューをリクエスト
                requestReview()
            }
        }
    }
    
    /// レビューリクエストを表示
    private func requestReview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    /// テスト用：保存されている起動回数をリセット
    func resetLaunchCount() {
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultsKeys.launchCount)
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultsKeys.reviewRequested)
    }
    
    /// テスト用：保存されている変更完了ボタン押下回数をリセット
    func resetSaveButtonTapCount() {
        UserDefaults.standard.removeObject(forKey: AppConst.UserDefaultsKeys.saveButtonTapCount)
    }
    
    /// 現在の起動回数を取得
    func getCurrentLaunchCount() -> Int {
        return UserDefaults.standard.integer(forKey: AppConst.UserDefaultsKeys.launchCount)
    }
    
    /// 現在の変更完了ボタン押下回数を取得
    func getCurrentSaveButtonTapCount() -> Int {
        return UserDefaults.standard.integer(forKey: AppConst.UserDefaultsKeys.saveButtonTapCount)
    }
} 