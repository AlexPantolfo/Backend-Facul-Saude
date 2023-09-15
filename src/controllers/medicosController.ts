import { Router } from 'express'
import express from 'express'
import MedicosDTO from '../dto/medicos.dto';
import { NotFoundError } from '../lib/errors';
import Medicos from '../schemas/medicos'
import { validateObjectId } from '../middlewares/validation';

export default class MedicosController {

    public router: Router;
    private medicosDTO: MedicosDTO = new MedicosDTO();

    constructor() {
        this.router = express.Router();
        this.registerRoutes();
    }

    protected registerRoutes(): void {
        this.router.get('/medicos-disponiveis', async (req, res, next) => {
            try {
                /* const {  page = 1, limit = 10 } = req.query; */
                const [medicos, count] = await Promise.all([
                    Medicos.find({ isDeleted: false }),
                    Medicos.count({ isDeleted: false }),
                ]);
                res.json(
                    this.medicosDTO.getMedicoResponseDTO(medicos, count)
                );
            } catch (error) {
                next(error);
            }
        });

        this.router.get('/medico-especialidade-:especialidade', async (req, res, next) => {
            try {
                const especialidade = req.params.especialidade;
                const [medicos] = await Promise.all([
                    Medicos.find({ isDeleted: false, especialidade: especialidade }),
                ]);
                if (!medicos) {
                    throw new NotFoundError('Especialidade não encontrada');
                }
                res.json(
                    this.medicosDTO.getMedicoByEspecialidadeDTO(medicos)
                );
            } catch (error) {
                next(error);
            }
        });

        this.router.get('/medico-id-:id', validateObjectId, async (req, res, next) => {
            try {
                const id = req.params.id;
                const medicos = await Medicos.findOne({ _id: id, isDeleted: false });
                if (!medicos) {
                    throw new NotFoundError('ID nao encontrado');
                }
                res.json(
                    this.medicosDTO.getMedicoByIdResponseDTO(medicos)
                );
            } catch (err) {
                next(err);
            }
        });

        this.router.post('/novo-medico', async (req, res, next) => {
            try {
                const medico = await Medicos.create({
                    nome: req.body.nome,
                    especialidade: req.body.especialidade,
                    CRM: req.body.CRM,
                    email: req.body.email,
                    foto: req.body.foto
                });
                res.json(this.medicosDTO.getCreateMedicoResponseDTO(medico));
            } catch (error) {
                next(error);
            }
        });

        this.router.post('/atualiza-medico-id-:id', validateObjectId, async (req, res, next) => {
            try {
                const toUpdate: any = {};
                const { nome, especialidade, CRM, email, foto } = req.body;
                if (nome) toUpdate.nome = nome;
                if (especialidade) toUpdate.especialidade = especialidade;
                if (CRM) toUpdate.CRM = CRM;
                if (email) toUpdate.email = email;
                if (foto) toUpdate.foto = foto;
                const updated = await Medicos.findOneAndUpdate(
                    { _id: req.params.id, isDeleted: false },
                    toUpdate,
                    { new: true }
                );
                if (!updated) {
                    throw new NotFoundError('Medico não foi atualizado, verifique os parametros enviados');
                }
                res.json(this.medicosDTO.getUpdateMedicoResponseDTO(updated));
            } catch (error) {
                next(error);
            }
        });

        this.router.delete('/exclui-medico-id-:id', validateObjectId, async (req, res, next) => {
            try {
                const deleted = await Medicos.findOneAndUpdate(
                    { _id: req.params.id, isDeleted: false },
                    { isDeleted: true }
                );
                if (!deleted) {
                    throw new NotFoundError('Médico não encontrado');
                }
                res.json(this.medicosDTO.getDeleteMedicoResponseDTO(deleted));
            } catch (error) {
                next(error);
            }
        });
    }
}