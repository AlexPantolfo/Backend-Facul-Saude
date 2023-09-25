import mongoose, { Schema } from "mongoose";
import { AgendaModel } from '../models/agendaModel';

const AgendaSchema = new mongoose.Schema({
    medicoId: {
        type: Schema.Types.ObjectId,
        require: [true, "Campo medicoId é obrigatório"]
    },
    pacienteId: {
        type: Schema.Types.ObjectId,
        require: [true, "Campo pacienteId é obrigatório"],
    },
    dataConsulta: {
        type: String,
        require: [true, "Campo data é obrigatório"],
    },
    isCancelled:
    {
        type: Boolean,
        default: false,
    },
});


export default mongoose.model<AgendaModel>('Agenda', AgendaSchema);