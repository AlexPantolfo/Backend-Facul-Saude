import { UserModel } from '../models/userModel';
import mongoose from "mongoose";
/*import bcrypt from "bcrypt";*/

const UserSchema = new mongoose.Schema({
	 nome: {
   	  type: String,
   	  required: [true, "Nome é obrigatório"],
    },
    email: {
        type: String,
        unique: true,
        require: [true, "Email é obrigatório"],
    },
    password: {
        type: String,
        require: [true, "Senha obrigatória"],
    },
    dataNascimento: {
        type: String,
        require: [true, "DataNascimento obrigatória"],
    },
    dependentes: [{
        nome: String,
        email: String,
        dataNascimento: String
    }]
    /* Se estiver dificil de validar esse array nas responses/dto
       Usar dependente como usuário normal e adicionar os campos
       isDependente (boolean, required) e idTitular (ObjectID) ao schema
    */
});

UserSchema.pre('save', async function (next) {
   /* const salt = await bcrypt.genSalt(12);
    const hash = await bcrypt.hash(this.password, salt);
    this.password = hash;*/
    next();
})

export default mongoose.model<UserModel>('User', UserSchema);