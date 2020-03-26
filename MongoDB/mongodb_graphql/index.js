import express from 'express';
import mongoose from 'mongoose';
import graphlHTTP from 'express-graphql';
import schema from './schema';

const app = express();
const dbName = "User"
const port = 3000
const uri = `mongodb://localhost:27017/${dbName}?readPreference=primary&appname=MongoDB%20Compass&ssl=false`

mongoose.Promise = global.Promise;
mongoose.connect(uri, {
    useNewUrlParser: true,
    useUnifiedTopology: true });

app.listen(port, () => {
        console.log(`서버 실행!! 포트는? ${port}`);
});

app.use(`/graphql`, graphlHTTP({
    schema: schema,
    graphiql: true
}));