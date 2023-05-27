//
//  MemoCoreDataManager.swift
//  TeamProject
//
//  Created by 박채운 on 2023/05/27.
//
import UIKit
import CoreData

final class MemoCoreDataManager {
    
    static let shared = MemoCoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    
    let modelName: String = "MemoCoreData"
    
    func getMemoListFromCoreData() -> [MemoCoreData] {
        var memoList: [MemoCoreData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "mDate", ascending: false)
            request.sortDescriptors = [dateOrder]
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedMemoList = try context.fetch(request) as? [MemoCoreData] {
                    memoList = fetchedMemoList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return memoList
    }
    
    
    func saveMemoData(mtitle: String?, mcontent: String?, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let memoData = NSManagedObject(entity: entity, insertInto: context) as? MemoCoreData {
                    
                    memoData.mTitle = mtitle
                    memoData.mContent = mcontent
                    memoData.mDate = Date()
                    
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
            
        }
        completion()
    }
    
    
    
    func deleteMemo(data: MemoCoreData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = data.mDate else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedMemoList = try context.fetch(request) as? [MemoCoreData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetMemo = fetchedMemoList.first {
                        context.delete(targetMemo)
                        
                       
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateMemo(newMemoCoreData: MemoCoreData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newMemoCoreData.mDate else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "dDate = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedMemoList = try context.fetch(request) as? [MemoCoreData] {
                    
                    // 배열의 첫번째
                    if var targetMemo = fetchedMemoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetMemo = newMemoCoreData
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    
}
    
