import Router from 'express'
import { Request, Response } from 'express'
import userController from './controllers/userController';
import jwt from "jsonwebtoken";
const routes = Router();

function checkToken(req, res, next) {
    const token = req.headers['authorization'];

    if (!token) return res.status(401).json({ msg: "Acesso negado!" }).end();

    try {
        const secret = process.env.SECRET;

        jwt.verify(token, secret);

        next();
    } catch (err) {
        res.status(400).json({ msg: "O Token é inválido!" }).end();
    }
}

routes.get("/", (req: Request, res: Response) => {
    res.json({ message: "Hello world!" });
});

routes.get("/auth", (req: Request, res: Response) => {
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

routes.post('/addUser', userController.addUser)
routes.post('/login', userController.login)
routes.post('/loginAdmin', userController.loginAdmin)

export default routes;
