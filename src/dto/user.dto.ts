export default class UserDTO {

  constructor() {
  }

  private getUserDTO = (user) => ({
    ID: user._id,
    nome: user.nome,
    email: user.email,
    dependentes: user.dependentes,
    dataNascimento: user.dataNascimento,
  });

  public getUserResponseDTO = (user) => ({
    Dados: user.map(this.getUserDTO),
  });

  public getUserByIdResponseDTO = (user) => ({
    Dados: this.getUserDTO(user),
  });

  public getUserByDependentesDTO = (user) => ({
    Dados: user.map(this.getUserDTO),
  });

  public getCreateUserResponseDTO = (user) => ({
    message: 'Usuário criado com sucesso',
    nome: user.nome,
    ID: user._id,
  });

  public getDeleteUserResponseDTO = (user) => ({
    message: 'Usuário excluído com sucesso',
    nome: user.nome,
    ID: user._id,
  });

  public getUpdateUserResponseDTO = (user) => ({
    message: 'Usuário atualizado com sucesso',
    ID: user._id,
    nome: user.nome,
    dependentes: user.dependentes,
    email: user.email,
    dataNascimento: user.dataNascimento,
  });
}