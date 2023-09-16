export default class MedicosDTO {

  constructor() {
  }

  private getMedicoDTO = (medico) => ({
    ID: medico._id,
    nome: medico.nome,
    especialidade: medico.especialidade,
    CRM: medico.CRM,
    email: medico.email,
    foto: medico.foto,
  });

  public getMedicoResponseDTO = (medicos, count) => ({
    Dados: medicos.map(this.getMedicoDTO),
    Quantidade: count,
  });

  public getMedicoByIdResponseDTO = (medico) => ({
    Dados: this.getMedicoDTO(medico),
  });

  public getMedicoByEspecialidadeDTO = (medicos) => ({
    Dados: medicos.map(this.getMedicoDTO),
  });

  public getCreateMedicoResponseDTO = (medico) => ({
    message: 'Médico criado com sucesso',
    nome: medico.nome,
    ID: medico._id,
  });

  public getDeleteMedicoResponseDTO = (medico) => ({
    message: 'Médico excluído com sucesso',
    nome: medico.nome,
    ID: medico._id,
  });

  public getUpdateMedicoResponseDTO = (medico) => ({
    message: 'Médico atualizado com sucesso',
    ID: medico._id,
    nome: medico.nome,
    especialidade: medico.especialidade,
    CRM: medico.CRM,
    email: medico.email,
    foto: medico.foto,
  });
}