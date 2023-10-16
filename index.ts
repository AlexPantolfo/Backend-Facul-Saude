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
        this.app.use(cors())

        routes(this.app);
    }

    public async start(): Promise<void> {
        const connectionString = `mongodb+srv://${this.dbUser}:${this.dbPass}@cluster0.7yvwjei.mongodb.net/?retryWrites=true&w=majority`;
        mongoose.set("strictQuery", false);
        mongoose.connect(connectionString)
        mongoose.Promise = global.Promise;

        this.app.listen(this.app.get('port'), () => {
            console.log('Server listening in port 3000');
        });
    }
}

const server = new Server();
server.start();