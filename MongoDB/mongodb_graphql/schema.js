import { makeExecutableSchema } from 'graphql-tools';
import { resolvers } from './resolvers'

const typeDefs = `
    type User {
        _id: ID!
        name: String!
        age: Int!
        gender: String!
    }

    type Query {
        getUser(_id: ID!): User
        allUser: [User]
    }

    input UserInput {
        name: String!
        age: Int!
        gender: String!
    }

    type Mutation {
        createUser(name: String, age: Int, gender: String): User
        updateUser(_id: ID!, input: UserInput): User
        deleteUser(_id: ID!): User
    }
`

const schema = makeExecutableSchema({
    typeDefs,
    resolvers
});

export default schema;