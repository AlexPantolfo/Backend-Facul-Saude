import { Request, Response } from 'express'
import User from '../schemas/user'
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import * as dotenv from 'dotenv'
dotenv.config()
class UserController {

    async addUser(req: Request, res: Response) {
        {
            try {
                const user = await User.create(req.body);
                user.password = undefined;

                return res.send({ user }).end();
            } catch (err) {
                return res.status(400).send({ error: err }).end();
            }
        }
    }

    async login(req: Request, res: Response) {
        {
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
        }
    }


    async loginAdmin(req: Request, res: Response) {
        {
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
        }
    }
}

export default new UserController;