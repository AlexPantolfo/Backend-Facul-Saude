import { Request, Response, Router } from 'express'
import express from 'express'
import User from '../schemas/user'
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import * as dotenv from 'dotenv'
import { NotFoundError } from '../lib/errors';
import { validateObjectId } from '../middlewares/validation';
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
        this.router.get('/userAll', async (req, res, next) => {
            try {
                const [user, count] = await Promise.all([
                    User.find(),
                    User.count(),
                ]);
                res.json(
                    this.userDTO.getUserResponseDTO(user, count)
                );
            } catch (error) {
                next(error);
            }
        });
        this.router.get('/user-id-:id', validateObjectId, async (req, res, next) => {
            try {
                const id = req.params.id;
                const user = await User.findOne({ _id: id });
                if (!user) {
                    throw new NotFoundError('ID nao encontrado');
                }
                res.json(
                    this.UserDTO.getUserByIdResponseDTO(user)
                );
            } catch (err) {
                next(err);
            }
        });
        this.router.delete('/exclui-user-id-:id', validateObjectId, async (req, res, next) => {
            try {
                const deleted = await User.findOneAndUpdate(
                    { _id: req.params.id}
                );
                if (!deleted) {
                    throw new NotFoundError('Usuário não encontrado');
                }
                res.json(this.userDTO.getDeleteUserResponseDTO(deleted));
            } catch (error) {
                next(error);
            }
        });
    /* TODO - Update User (atenção em como vai ficar a request para casos com mais de 1 dependente)
              Add dependente
				  Favor fazer pelo menos uma chamada de cada endpoint para validar se está funcionando
				  backend-facul-saude.onrender.com/user/Endpoint
	 */
    }
}