//
//  DiaryCoreDataManager.swift
//  TeamProject
//
//  Created by 박채운 on 2023/05/27.
//


import UIKit
import CoreData

final class DiaryCoreDataManager {
    
    static let shared = DiaryCoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    
    let modelName: String = "DiaryCoreData"
    
    func getDiaryListFromCoreData() -> [DiaryCoreData] {
        var diaryList: [DiaryCoreData] = []
        
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기
            let dateOrder = NSSortDescriptor(key: "dDate", ascending: false)
            request.sortDescriptors = [dateOrder]
            do {
                // 임시저장소에서 (요청서를 통해서) 데이터 가져오기 (fetch메서드)
                if let fetchedDiaryList = try context.fetch(request) as? [DiaryCoreData] {
                    diaryList = fetchedDiaryList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return diaryList
    }
    
    
    func saveDiaryData(dtitle: String?, dcontent: String?, dphoto: Data? , completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let diaryData = NSManagedObject(entity: entity, insertInto: context) as? DiaryCoreData {
                    
                    diaryData.dTitle = dtitle
                    diaryData.dContent = dcontent
                    diaryData.dDate = Date()
                    diaryData.dPhoto = dphoto
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
    
    
    
    func deleteDiary(data: DiaryCoreData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = data.dDate else {
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
                if let fetchedDiaryList = try context.fetch(request) as? [DiaryCoreData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetDiary = fetchedDiaryList.first {
                        context.delete(targetDiary)
                        
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
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateDiary(newDiaryCoreData: DiaryCoreData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newDiaryCoreData.dDate else {
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
                if let fetchedDiaryList = try context.fetch(request) as? [DiaryCoreData] {
                    
                    // 배열의 첫번째
                    if var targetDiary = fetchedDiaryList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetDiary = newDiaryCoreData
                        
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
    
