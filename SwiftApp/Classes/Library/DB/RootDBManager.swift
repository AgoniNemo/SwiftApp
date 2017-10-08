//
//  RootDBManager.swift
//  IM
//
//  Created by Mjwon on 2017/7/19.
//  Copyright © 2017年 Nemo. All rights reserved.
//

import UIKit
import FMDB

class RootDBManager: NSObject {
    
    var queue:FMDatabaseQueue? = nil;
    
    func rootDataBaseManagerForQueue(queue:FMDatabaseQueue) -> AnyObject {
        
        let db = RootDBManager.self();
        db.queue = queue;
        
        return db;
        
    }
    
    func creatTabelWithKeys(keys:Array<Any>,tableName:String) -> Bool {
        
        return self.creatTabelKeys(keys:keys,b:true,tableName:tableName);
    }
    
    private func creatTabelKeys(keys:Array<Any>,b:Bool,tableName:String) -> Bool {
        var Id:String = "";
        
        if b == true {
            Id = "id integer primary key autoincrement,";
        }
        
        var sql = "create table if not exists \(tableName)( \(Id)";
        let def = "varchar(10) default ''";//设置默认值（空字符串）
        
        var sentence = String.init();
        
        let typeStr = "text \(def)";
        
        for (idx, value) in keys.enumerated() {
            
            let symbol = (idx == keys.count-1) ? ")" : ",";
            let ap = "\(value) \(typeStr) \(symbol)";
            sentence.append(ap);
            
        }
        sql.append(sentence as String)
        
        var a:Bool = false;
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            
            db.open();
            a = db.executeUpdate(sql, withArgumentsIn: []);
            
        })

        
        return a;
    }
    
    private func updateSQLForDict(dict:Dictionary<String, String>,condition:Array<Any>,overlook:Array<String>,tableName:String) -> String {
        var sql = "update \(tableName) set ";
        
        let keys = dict.keys;
        for (idx, key) in keys.enumerated() {
            let value:String = dict[key]!;
            
            if !overlook.contains(key){
                let s = (idx == 0) ? "" : " ";
                let tag = (idx > 0) ? "," : s;
                let str = "\(key) = '\(value)'";
                sql = sql.appendingFormat("%@%@",tag,str)
            }
        }
        // 生成条件语句
        let string = self.getCondition(array: condition, dict: dict);
        
        sql = sql.appendingFormat(" where %@",string)
        
        return sql;
    }
    
    func updateDataWithDict(dict:Dictionary<String,String>,condition:Array<Any>,overlook:Array<String>,tableName:String) -> Bool {
        
        let sql = self.updateSQLForDict(dict:dict,condition:condition,overlook:overlook,tableName:tableName);
        
        var b = false;
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            b = db.executeUpdate(sql, withArgumentsIn: []);
            
        })
        
        return b;
    }
    
    func updateDataWithArray(array:Array<Dictionary<String,String>>,condition:Array<Any>,overlook:Array<String>,tableName:String) -> Bool {
        
        var transactionSql = Array<String>.init();
        
        for (_,dict) in array.enumerated() {
            let sql = self.updateSQLForDict(dict: dict, condition: condition,overlook:overlook, tableName: tableName);
            transactionSql.append(sql);
        }
        
        return self.tarrayForArray(array: transactionSql, asyncName: "RootDataBaseManagerUpateNewsDataWithArray");
        
    }
    
    // TODO: 插入数据（单个数据）
    func insertData(ForDict dict:Dictionary<String,String>, tableName:String) -> Bool {
        
        var b = false;
        if dict.count == 0 {
            return b
        }
        
        let sql = self.insertSQLForDict(dict: dict, tableName: tableName);
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            
            b = db.executeUpdate(sql, withArgumentsIn: []);
        })
        return b;
    }
    
    // TODO: 插入数据（批量数据）
    func insertData(ForArray array:Array<Dictionary<String,String>>,tableName:String) -> Bool {
        
        var transactionSql = Array<String>.init();
        
        for (_,dict) in array.enumerated() {
            let sql = self.insertSQLForDict(dict: dict, tableName: tableName);
            transactionSql.append(sql);
            
        }
        return self.tarrayForArray(array: transactionSql, asyncName: "RootDataBaseManagerInsertNewsDataWithArray");
    }
    
    private func tarrayForArray(array:Array<String>,asyncName name:String) -> Bool {
        
        let queue:DispatchQueue = DispatchQueue(label:name,attributes:.concurrent);
        
        var b = false;
        
        queue.async {
            self.queue?.inDatabase({ (db:FMDatabase) in
                
                for (_,sql) in array.enumerated(){
                
                    db.open();
                    
                    let res = db.executeUpdate(sql, withArgumentsIn: []);
                    
                    if res == true{
                       
                        b = res;

                    }else{
                        assert(res, "批量插入失败！");
                    }
                }
            })
        }
        
        
        return b;
    }
    
    private func insertSQLForDict(dict:Dictionary<String,String>,tableName:String) -> String {
        
        let format = "insert into \(tableName) (";
        var valuesFlag = "values (";
        
        var sql = String.init();
        
        let keys = dict.keys;
        
        for (i,key) in keys.enumerated() {
            
            var value = dict[key];
            
            if value!.contains("'") == true {
                let range = value?.range(of: "'");
                
                value?.insert("'", at: range!.lowerBound)
            }
            
            let b = (i == keys.count-1);
            let str = b ? ")":",";
            sql = sql.appendingFormat("%@%@",key,str);
            valuesFlag = valuesFlag.appendingFormat("'%@'%@",value!,str);

        }
        sql = sql.appending(valuesFlag);
        
        return "\(format) \(sql)";
    }
    
    
    func verifyDataWithDict(dict:Dictionary<String,String>,relationship:Array<String>,tableName:String) -> Bool {
        
        assert((relationship.count + 1 == dict.count), "数据与关系不一致！")
        
        let keys = dict.keys;
        var vk = String.init();
        
        for (i ,key) in keys.enumerated() {
            let value = "\(dict[key]!)";
            vk = vk.appendingFormat("%@ = '%@'",key,value)
            
            if i % 2 == 0 && keys.count > 1 && i > 0 {
                vk = vk.appendingFormat("%@",relationship[i-1])
            }
        }
        let sql = "select count(*) from \(tableName) where \(vk)";
        var b = false;
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            let result = db.executeQuery(sql, withArgumentsIn: []);
            while(result!.next()){
                let r = result?.int(forColumnIndex: 0);
                
                if r! > 0{
                    b = true;
                }
            }
        })
        
        return b;
    }
    
    func carryForOutsql(sql:String,tableName:String) -> Array<String> {
        
        var dataArray = Array<String>.init();
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            
            let res = db.executeQuery(sql, withArgumentsIn: []);
            
            while (res?.next())!{
                let v:String = res!.string(forColumn: "userId")!;
                if(v.isEmpty == false){
                    dataArray.append(v);
                }
            }
        })
        
        return dataArray;
    }
    
    
    func carryOutsql(sql:String,tableName:String) -> Array<Dictionary<String,Any>> {
    
        var dataArray = Array<Dictionary<String,Any>>.init();
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            
            let result = db.executeQuery(sql, withArgumentsIn: []);
            
            while (result?.next())! {
                let dict:Dictionary = result!.resultDictionary!;
                dataArray.append(dict as! [String : Any]);
            }
        })
        return dataArray;
    }
    
    
    func getData(condition:String,conditionBack:String,order:String,tableName:String) -> Array<Dictionary<String,Any>> {
        
        var str = conditionBack;
        
        if str.isEmpty {
            str = "*";
        }
        
        let sql = "select \(str) from \(tableName) where \(condition) \(order)";
        var dataArray = Array<Dictionary<String,Any>>.init();
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            let result = db.executeQuery(sql, withArgumentsIn: []);
            
            while (result?.next())! {
                let dict:Dictionary = result!.resultDictionary!;
                dataArray.append(dict as! [String : Any]);
            }
            
        })
        
        return dataArray;
    }
    
    func getAllDataTableName(order:String,tableName:String) -> Array<Dictionary<String,Any>> {
        
        let sql = "select * from \(tableName) \(order)";
        
        var dataArray = Array<Dictionary<String,Any>>.init();
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            let result = db.executeQuery(sql, withArgumentsIn: []);
            
            while (result?.next())! {
                let dict:Dictionary = result!.resultDictionary!;
                dataArray.append(dict as! [String : Any]);
            }
        })
        
        return dataArray;
    }
    
    private func getCondition(array:Array<Any>,dict:Dictionary<String,String>) -> String {
        
        var string = String.init();
        
        for (_,value) in array.enumerated() {
            
            if value is String {
                let s:String = value as! String;
                
                if s.lowercased() == "or" || s.lowercased() == "and"  {
                    string.append(" \(value) ")
                }else{
                    /**
                    let k = dict.first?.key ?? String();
                    let v = dict.first?.value ?? String();
                    string.append("\(k) = '\(v)'");
                     */
                    debugPrint(value,dict)
                    let k:String = value as! String
                    let v:String = dict[k]!;
                    string.append("\(value) = '\(v)'");
                }
            }else{
                if value is [[String:String]] {
                    let array = value as! [[String:String]]
                    let dic = array.first!;
                    let k = dic.first?.key ?? String();
                    let v = dic.first?.value ?? String();
                    string.append("\(k) = '\(v)'");
                    
                }else{
                    let k = dict.first?.key ?? String();
                    let v = dict.first?.value ?? String();
                    assert(!v.isEmpty, "value为空");
                    assert(!k.isEmpty, "key为空");
                    
                    string.append("\(k) = '\(v)'");
                }
            }
        }
        return string;
        
    }
    
    // MARK: - 查询数据
    /// parameter array:需要查询的多个条件 格式为[["key":"value"],"or",["key":"value"],"and",["key":"value"]]
    /// parameter tableName：表名字
    func inquireData(WithArray array:Array<Any>,tableName:String) -> Array<Dictionary<String,String>> {
        
        let  condition = self.getCondition(array: array,dict:[:]);
        
        let sql = "select * from \(tableName) where \(condition)"
        
        var dataArray:[[String:String]] = Array.init();
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            let result = db.executeQuery(sql, withArgumentsIn: []);
            
            while (result?.next())! {
                let dict:[String:Any] = result!.resultDictionary! as! [String : Any];
                
                dataArray.append(self.chengeDict(dict: dict));
            }
        })
        
        return dataArray;
        
    }
    
    private func chengeDict(dict:[String:Any]) -> [String:String]{
        
        var d:[String:String] = Dictionary();
        
        for (_,v) in dict.enumerated() {
            debugPrint(v)
            d[v.key] = v.value as? String
        }
        
        return d
    }
    
    // TODO: 检查数据库字段是否存在，不存在就添加
    func isExistDataByArray(array:Array<String>,tableName:String) -> Bool {
        
        var a = false;
        
        for (_,name) in array.enumerated() {
            
            let b = self.isExistDataByString(name: name, tableName: tableName);
            
            if b == false {
                a = self.addDataByString(name: name, tableName: tableName);
            }
        }
        
        return a;
    }
    
    func isExistDataByString(name:String,tableName:String) -> Bool {
        
        
        var b = false;
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            
            b = db.columnExists(name, inTableWithName: tableName)
        })
        
        return b;
    }
    
    
    func getData(ForSQL sql:String) -> Array<Dictionary<String,Any>> {
        
        var array:Array = Array<Dictionary<String,Any>>.init();
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            
            let result = db.executeQuery(sql, withArgumentsIn: []);
            
            while (result!.next()){
                let dict = result?.resultDictionary;
                
                array.append(dict as! [String : Any]);
            }
        })
        
        return array;
    }
    
    func addDataByString(name:String,tableName:String) -> Bool {
        
        let sql = "ALTER TABLE \(tableName) ADD \(name) text";
        
        var b = false;
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            //与OC的不一样
            b = db.executeUpdate(sql, withArgumentsIn: []);
        })
        
        return b;
    }
    
    func delete(ForTableName name:String ) -> Bool {
        
        let sql = "delete from \(name)"
        
        var b = false;
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            b = db.executeUpdate(sql, withArgumentsIn: []);
        })
        
        return b;
    }
    
    func delete(dict:[String:String],name:String) -> Bool {
        
        let condition = self.getCondition(array: [dict], dict: dict)
        let sql = "delete from \(name) where \(condition)"
        
        var b = false;
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            b = db.executeUpdate(sql, withArgumentsIn: []);
        })
        
        return b;
    }
    
    func sqlStatements(sql:String) -> Bool {
        
        var b = false;
        
        self.queue?.inDatabase({ (db:FMDatabase) in
            db.open();
            
            b = db.executeStatements(sql);
        })
        
        return b;
    }
    
}
