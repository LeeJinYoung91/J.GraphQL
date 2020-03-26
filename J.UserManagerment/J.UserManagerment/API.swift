//
//  API.swift
//  J.UserManagerment
//
//  Created by JinYoung Lee on 2020/02/28.
//  Copyright © 2020 JinYoung Lee. All rights reserved.
//

import Apollo

public final class AllUserQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
    """
    query UserList {
      allUser {
        __typename
        ...UserDetail
      }
    }
    """
    
    public let operationName: String = "UserList"
    
    public var queryDocument: String { return operationDefinition.appending(UserDetail.fragmentDefinition) }
    
    public init() {
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Query"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("allUser", type: .nonNull(.list(.nonNull(.object(User.selections))))),
        ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(users: [User]) {
            self.init(unsafeResultMap: ["__typename":"Query", "allUser": users.map { (value: User) -> ResultMap in value.resultMap }])
        }
        
        public var users: [User] {
            get {
                return (resultMap["allUser"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
            }
            set {
                resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "allUser")
            }
        }
        
        public struct User: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["User"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(UserDetail.self)
            ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var fragments: Fragments {
                get {
                    return Fragments(unsafeResultMap: resultMap)
                }
                set {
                    resultMap += newValue.resultMap
                }
            }
            
            public struct Fragments {
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public var userDetail: UserDetail {
                    get {
                        return UserDetail(unsafeResultMap: resultMap)
                    }
                    set {
                        resultMap += newValue.resultMap
                    }
                }
            }
        }
    }
}

public struct UserDetail: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
    """
    fragment UserDetail on User {
      _id
      name
      age
      gender
    }
    """
    
    public static let possibleTypes: [String] = ["User"]
    
    public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("age", type: .nonNull(.scalar(Int.self))),
        GraphQLField("gender", type: .scalar(String.self))
    ]
    
    public private(set) var resultMap: ResultMap
    
    public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
    }
    
    public init(id: String, name: String, age: Int, gender: String) {
        self.init(unsafeResultMap: ["__typename":"User", "_id": id, "name": name, "age": age, "gender": gender])
    }
    
    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }
    
    public var id: String {
        get {
            return resultMap["_id"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "_id")
        }
    }
    
    public var name: String {
        get {
            return resultMap["name"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "name")
        }
    }
    
    public var age: Int {
        get {
            return resultMap["age"]! as! Int
        }
        set {
            resultMap.updateValue(newValue, forKey: "age")
        }
    }
    
    public var gender: String {
        get {
            return resultMap["gender"]! as! String
        }
        set {
            resultMap.updateValue(newValue, forKey: "gender")
        }
    }
}

public final class CreateUserMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
    """
    mutation CreateUser($name: String, $age: Int, $gender: String) {
      createUser(name: $name, age: $age, gender: $gender) {
        __typename
        _id
        name
        age
        gender
      }
    }
    """
    
    public let operationName: String = "CreateUser"
    
    public var name: String
    public var age: Int
    public var gender: String
    
    public init(name: String, age: Int, gender: String) {
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    public var variables: GraphQLMap? {
        return ["name": name, "age": age, "gender": gender]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Mutation"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("createUser", arguments: ["name": GraphQLVariable("name"), "age": GraphQLVariable("age"), "gender":GraphQLVariable("gender")], type: .object(UserInput.selections)),
        ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(createUser: UserInput? = nil) {
            self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: UserInput) -> ResultMap in value.resultMap }])
        }
        
        public var createUser: UserInput? {
            get {
                return (resultMap["createUser"] as? ResultMap).flatMap { UserInput(unsafeResultMap: $0) }
            }
            set {
                resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
            }
        }
        
        
        
        public struct UserInput: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["User"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("age", type: .scalar(Int.self)),
                GraphQLField("gender", type: .scalar(String.self)),
            ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public init(name: String, age: Int, gender: String) {
                self.init(unsafeResultMap: ["__typename": "User", "name": name, "age": age, "gender": gender])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var age: Int {
                get {
                    return resultMap["age"]! as! Int
                }
                set {
                    resultMap.updateValue(newValue, forKey: "age")
                }
            }
            
            public var name: String {
                get {
                    return resultMap["name"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "name")
                }
            }
            
            public var gender: String {
                get {
                    return resultMap["gender"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "gender")
                }
            }
        }
    }
}

public final class DeleteUserMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
    """
    mutation DeleteUser($id: ID!) {
      deleteUser(_id: $id) {
          name
      }
    }
    """
    
    public let operationName: String = "DeleteUser"
    
    public var id: String
    
    public init(id: String!) {
        self.id = id
    }
    
    public var variables: GraphQLMap? {
        return ["id": id]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Mutation"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("deleteUser", arguments: ["id": GraphQLVariable("id")], type: GraphQLOutputType.scalar(String.self)),
        ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
    }
}
