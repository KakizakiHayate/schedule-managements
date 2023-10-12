//
//  RealmCRUD.swift
//  ScheduleManagements
//
//  Created by 柿崎逸 on 2023/10/08.
//

import Foundation
import RealmSwift

/// Realmの共通CRUD
public class RealmCRUD {}

extension RealmCRUD {
    // MARK: - Methods
    class func realmAdd<T: Object>(weekModel: T) {
        guard let localRealm = try? Realm() else { return }
        do {
            try localRealm.write {
                localRealm.add(weekModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    class func realmUpdate<T: WeekDay>(weekModel: inout T,
                                                subjects: [String],
                                                trainTime: Date
    ) {
        guard let localRealm = try? Realm() else { return }
        do {
            try localRealm.write {
                (0 ..< subjects.count).forEach {
                    weekModel.scheduleList[$0] = subjects[$0]
                }
                weekModel.trainTime = trainTime
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    class func realmDelete<T: Object>(weekModel: T.Type) {
        guard let localRealm = try? Realm() else { return }
        let allObjct = localRealm.objects(weekModel)
        do {
            try localRealm.write {
                localRealm.delete(allObjct)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    class func realmRead<T: Object>(weekModel: T.Type) -> T? {
        guard let localRealm = try? Realm() else { return nil }
        guard let lastObject = localRealm.objects(weekModel).last else { return nil }

        return lastObject
    }
}
