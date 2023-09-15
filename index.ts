import express from "express";
import mongoose from "mongoose";
import routes from "./src/routes";
import * as dotenv from 'dotenv'
const cors = require('cors');

dotenv.config()

class Server {
    public app: express.Application;
    private dbUser = process.env.DB_USER;
    private dbPass = process.env.DB_PASS;

    constructor() {
        this.app = express();
        this.config();
    }

    public config(): void {
        this.app.set('port', 3000);
        this.app.use(express.json());
        routes(this.app);
    }

    public async start(): Promise<void> {
        const connectionString = `mongodb+srv://${this.dbUser}:${this.dbPass}@cluster0.7yvwjei.mongodb.net/?retryWrites=true&w=majority`;
        mongoose.set("strictQuery", false);
        mongoose.connect(connectionString)
        mongoose.Promise = global.Promise;

        const allowedDomains = ['http://127.0.0.1:5500'];
        this.app.use(cors())
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

        this.app.listen(this.app.get('port'), () => {
            console.log('Server listening in port 3000');
        });
    }
}

const server = new Server();
server.start();