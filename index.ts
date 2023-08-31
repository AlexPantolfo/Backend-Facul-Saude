import express from "express";
import mongoose from "mongoose";
import routes from "./src/routes";
import * as dotenv from 'dotenv'
const cors = require('cors');
const cron = require("node-cron");
const exec = require("child_process").exec;

dotenv.config()
const app = express();
var allowedDomains = ['http://127.0.0.1:5500'];
const dbUser = process.env.DB_USER;
const dbPass = process.env.DB_PASS;

const uri = `mongodb+srv://${dbUser}:${dbPass}@cluster0.7yvwjei.mongodb.net/?retryWrites=true&w=majority`;
mongoose.connect(uri)
mongoose.Promise = global.Promise;

cron.schedule('*/10 * * * * *', () => {
    console.log('mantendo o servidor vivo...', new Date());

    exec(`ping -n 1 -w 1000 backend-facul-saude.onrender.com`, (err, stdout, stderr) => {
        console.log(stdout);
    })
});


app.use(express.json());
app.use(cors())
// app.use(cors({
//     origin: function (origin, callback) {
//         if (!origin) return callback(null, true);

//         if (allowedDomains.indexOf(origin) === -1) {
//             var msg = `This site ${origin} does not have an access. Only specific domains are allowed to access it.`;
//             return callback(new Error(msg), false);
//         }
//         return callback(null, true);
//     }, credentials: true
// }))

app.set("port", process.env.PORT || 3000);
app.use(routes);

app.listen(app.get("port"), () => {
    console.log(`Server on http://localhost:${app.get("port")}/`);
});