import express, { Request, Response } from 'express'
import UserController from './controllers/userController';
import MedicosController from './controllers/medicosController';
import errorHandler from './lib/error.handler';
import AgendaController from './controllers/agendaController';

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./swagger.json');

const routes = (server: express.Application): void => {
    server._router.get("/", (req: Request, res: Response) => {
        res.json({ message: "Hello world!" });
    });

    server.use('/user', new UserController().router);
    server.use('/medicos', new MedicosController().router);
    server.use('/agenda', new AgendaController().router);
    server.use('/api-docs', swaggerUi.serve);
    server.get('/api-docs', swaggerUi.setup(swaggerDocument));

    server.use(errorHandler)

    server.use((req, res, next) => {
        res.status(404).json({ message: 'Caminho não encontrado!' });
    })
};

export default routes