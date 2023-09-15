import express from 'express'
import { Request, Response } from 'express'
import UserController from './controllers/userController';
import MedicosController from './controllers/medicosController';

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger.json');

const routes = (server: express.Application): void => {
    server._router.get("/", (req: Request, res: Response) => {
        res.json({ message: "Hello world!" });
    });

    server.use('/user', new UserController().router);
    server.use('/medicos', new MedicosController().router);
    server.use('/api-docs', swaggerUi.serve);
    server.get('/api-docs', swaggerUi.setup(swaggerDocument));
};

export default routes