import { Request, Response, Router } from 'express'
import express from 'express'
import * as dotenv from 'dotenv'
import Agenda from '../schemas/agenda';
import { validateObjectId } from '../middlewares/validation';
import { NotFoundError } from '../lib/errors';
import UserDTO from '../dto/user.dto';
import User from '../schemas/user'
import MedicosDTO from '../dto/medicos.dto';
import Medicos from '../schemas/medicos'

dotenv.config()
export default class AgendaController {

    public router: Router;

    constructor(
        private userDTO: UserDTO = new UserDTO(),
        private medicosDTO: MedicosDTO = new MedicosDTO()
    ) {
        this.router = express.Router();
        this.registerRoutes();
    }

    protected registerRoutes(): void {
        this.router.post('/addAgenda', async (req: Request, res: Response, next) => {
            try {

                const medico = await this.recuperaMedico(req.body.medicoId);
                const user = await this.recuperaUsuario(req.body.pacienteId);

                const agendamento = await Agenda.create({
                    medicoId: req.body.medicoId,
                    medicoNome: medico.Dados.nome,
                    pacienteId: req.body.pacienteId,
                    pacienteNome: user.Dados.nome,
                    dataConsulta: req.body.dataConsulta,
                });

                res.status(200).json({ msg: "Agendamento criado com sucesso", agendamento }).end();
            } catch (err) {
                next(err);
            }
        });

        this.router.get('/getAgendaByMedicoId/:id', validateObjectId, async (req: Request, res: Response, next) => {
            try {
                const medicoId = req.params.id;
                const agendamentosMedico = await Agenda.find({ medicoId: medicoId, isCancelled: false });
                if (!agendamentosMedico) {
                    throw new NotFoundError('ID do medico nao encontrado');
                }
                res.status(200).json({ msg: "Agendamentos do medico recuperados com sucesso", agendamentosMedico }).end();
            } catch (err) {
                next(err);
            }
        });

        this.router.get('/getAgendaByPacienteId/:id', validateObjectId, async (req: Request, res: Response, next) => {
            try {
                const pacienteId = req.params.id;
                const agendamentosPaciente: any = await Agenda.find({ pacienteId: pacienteId, isCancelled: false });
                if (!agendamentosPaciente || !agendamentosPaciente.length) {
                    throw new NotFoundError('ID do paciente nao encontrado');
                }
                res.status(200).json({ msg: "Agendamentos do paciente recuperados com sucesso", agendamentosPaciente }).end();
            } catch (err) {
                next(err);
            }
        });

        this.router.post('/editByIdAgendamento/:id', validateObjectId, async (req, res, next) => {
            try {
                const toUpdate: any = {};
                const dataConsulta = req.body.dataConsulta;
                if (dataConsulta) toUpdate.dataConsulta = dataConsulta;

                const updated = await Agenda.findOneAndUpdate(
                    { _id: req.params.id, isCancelled: false },
                    toUpdate,
                    { new: true }
                );
                if (!updated) {
                    throw new NotFoundError('Agendamento não atualizado, verifique os parametros enviados');
                }
                res.status(200).json({ msg: "Agendamento atualizado com sucesso", updated }).end();
            } catch (error) {
                next(error);
            }
        });


        this.router.delete('/cancelaByAgendamentoId/:id', validateObjectId, async (req, res, next) => {
            try {
                const deleted = await Agenda.findOneAndUpdate(
                    { _id: req.params.id, isCancelled: false },
                    { isCancelled: true }
                );
                if (!deleted) {
                    throw new NotFoundError('Agendamento não encontrado');
                }
                res.status(200).json({ msg: "Agendamento cancelado com sucesso" }).end();
            } catch (error) {
                next(error);
            }
        });
    }

    private async recuperaMedico(id: any) {
        const medico = await Medicos.findOne({ _id: id, isDeleted: false });
        if (!medico) {
            throw new NotFoundError('Medico nao encontrado');
        }

        return this.medicosDTO.getMedicoByIdResponseDTO(medico)
    }

    private async recuperaUsuario(id: any) {
        const user = await User.findOne({ _id: id });
        if (!user) {
            throw new NotFoundError('User nao encontrado');
        }

        return this.userDTO.getUserByIdResponseDTO(user)
    }
}