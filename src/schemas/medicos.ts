import { MedicosModel } from '../models/medicosModel';
import mongoose from "mongoose";

const MedicosSchema = new mongoose.Schema(
	{
		nome:
		{
			type: String,
			required: [true, "Nome é obrigatório"],
		},
		especialidade:
		{
			type: String,
			required: [true, "Especialidade é obrigatória"],
		},
		CRM:
		{
			type: Number,
			unique: [true, "CRM já cadastrado"],
			min: [100000, "CRM inválido"],
			max: [999999, "CRM inválido"],
			required: [true, "CRM é obrigatório"],
		},
		email:
		{
			type: String,
			required: [true, "Email é obrigatório"],
		},
		foto:
		{
			type: String,
			required: [true, "Foto é obrigatória"],
		},
		descricao:
		{
			type: String,
			required: false,
		},
		isDeleted:
		{
			type: Boolean,
			default: false,
		},
	},
	{ timestamps: true }
);

export default mongoose.model<MedicosModel>('Medicos', MedicosSchema);