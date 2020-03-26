import User from './models/User';
export const resolvers = {
    Query: {
        async getUser(_, { _id }){
            return await User.findById(_id);
        },
        async allUser() {
            return await User.find();
        }
    },
    Mutation: {        
        createUser(_, {name, age, gender}) {
            return User.create({name, age, gender})
        },
        updateUser(_, { _id, input }) {
            return User.findOneAndUpdate(
                { _id }, 
                input,  
                { new: true }
            );
        }, 
        deleteUser(_, { _id }) {
            return User.findOneAndDelete({ _id });
        }        
    }        
}