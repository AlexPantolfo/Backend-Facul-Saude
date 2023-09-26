export default class UserDTO {

  constructor() {
  }

  private getUserDTO = (user) => ({
    ID: user._id,
    nome: user.nome,
    email: user.email,
    dataNascimento: user.dataNascimento,
    dependentes: user.dependentes,
  });

  public getUserResponseDTO = (user, count) => ({
    Dados: user.map(this.getUserDTO),
    Quantidade: count,
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
    email: user.email,
    dataNascimento: user.dataNascimento,
    dependentes: user.dependentes,
  });
}