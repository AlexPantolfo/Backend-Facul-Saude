import { Request, Response, Router } from 'express'
import express from 'express'
import User from '../schemas/user'
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import * as dotenv from 'dotenv'
dotenv.config()
export default class UserController {

    public router: Router;

    constructor() {
        this.router = express.Router();
        this.registerRoutes();
    }

    protected registerRoutes(): void {
        this.router.post('/addUser', async (req: Request, res: Response) => {
            try {
                const user = await User.create(req.body);
                user.password = undefined;

                return res.send({ user }).end();
            } catch (err) {
                return res.status(400).send({ error: err }).end();
            }
        });

        this.router.post('/auth', async (req: Request, res: Response) => {
            const token = req.headers['authorization'];

            if (!token) return res.status(401).json({ msg: "Acesso negado!" }).end();

            try {
                const secret = process.env.SECRET;

                jwt.verify(token, secret);
                res.status(200).json({ msg: "O Token é valido!" }).end();

            } catch (err) {
                res.status(400).json({ msg: "O Token é inválido!" }).end();
            }
        });

        this.router.post('/login', async (req: Request, res: Response) => {
            const { email, password } = req.body;
            const secret = process.env.SECRET;

            try {
                const user = await User.findOne({ email: email });

                if (!user) {
                    return res.status(404).json({ msg: "Usuário não encontrado!" }).end();
                }

                const checkPassword = await bcrypt.compare(password, user.password);

                if (!checkPassword) {
                    return res.status(422).json({ msg: "Senha inválida" }).end();
                }

                user.password = undefined;
                const token = jwt.sign(
                    {
                        id: user._id,
                    },
                    secret, { expiresIn: 1800 }
                );

                res.status(200).json({ msg: "Autenticação realizada com sucesso!", token, user }).end();
            } catch (error) {
                res.status(500).json({ msg: error }).end();
            }
        });

        this.router.post('/loginAdmin', async (req: Request, res: Response) => {
            const { email, password } = req.body;
            const secret = process.env.SECRET;

            try {
                const user = await User.findOne({ email: email });

                if (!user) {
                    return res.status(404).json({ msg: "Usuário não encontrado!" }).end();
                }

                const checkPassword = await bcrypt.compare(password, user.password);

                if (!checkPassword && email === "admin@mail.com") {
                    return res.status(422).json({ msg: "Usuário ou senha inválidos" }).end();
                }

                user.password = undefined;
                const token = jwt.sign(
                    {
                        id: user._id,
                    },
                    secret, { expiresIn: 3600 }
                );

                res.status(200).json({ msg: "Autenticação realizada com sucesso!", token, user }).end();
            } catch (error) {
                res.status(500).json({ msg: error }).end();
            }
        });
    }
}