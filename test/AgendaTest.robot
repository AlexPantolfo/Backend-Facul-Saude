*** Settings ***
Library        REST
Library        RPA.JSON
Resource       keywords/keywords.robot

*** Variables ***

${url_dev}      http://localhost:3000
${url_prd}      https://backend-facul-saude.onrender.com
${id_valido_dev}     64ff4b2be5bc25b31f14604a
${id_valido_prd}     6505eb9521fd9a4972464d4a
${ambiente}
#robot -d test/log -v ambiente:prd test

*** Test Cases ***


POST add agenda status:200
	[Tags]   Agenda   Sucesso    /getAgendaByPacienteId
	POST    ${url_${ambiente}}/agenda/addAgenda     {"medicoId": "650f02d17e3d7126ea75882f","pacienteId": "6513565ff82f74bee22d38e6","dataConsulta": "2022-12-23"}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg      Agendamento criado com sucesso
	${id_agenda_criada}     Output      response body agendamento _id
	Set Global Variable    ${id_agenda_criada}

GET add agenda status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	GET    ${url_${ambiente}}/agenda/addAgenda     {"medicoId": "650f02d17e3d7126ea75882f","pacienteId": "6513565ff82f74bee22d38e6","dataConsulta": "2022-12-23"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String    response body message      Caminho não encontrado!

PUT add agenda status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	PUT    ${url_${ambiente}}/agenda/addAgenda     {"medicoId": "650f02d17e3d7126ea75882f","pacienteId": "6513565ff82f74bee22d38e6","dataConsulta": "2022-12-23"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String    response body message      Caminho não encontrado!

PATCH add agenda status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	PATCH    ${url_${ambiente}}/agenda/addAgenda     {"medicoId": "650f02d17e3d7126ea75882f","pacienteId": "6513565ff82f74bee22d38e6","dataConsulta": "2022-12-23"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String    response body message      Caminho não encontrado!

DELETE add agenda status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	DELETE    ${url_${ambiente}}/agenda/addAgenda     {"medicoId": "650f02d17e3d7126ea75882f","pacienteId": "6513565ff82f74bee22d38e6","dataConsulta": "2022-12-23"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String    response body message      Caminho não encontrado!

GET agenda medico id status:200
	[Tags]   Agenda   Sucesso    /getAgendaByMedicoId
	GET    ${url_${ambiente}}/agenda/getAgendaByMedicoId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg      Agendamentos do medico recuperados com sucesso

POST agenda medico id status:404
	[Tags]   Agenda   Falha    /getAgendaByMedicoId
	POST    ${url_${ambiente}}/agenda/getAgendaByMedicoId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PATCH agenda medico id status:404
	[Tags]   Agenda   Falha    /getAgendaByMedicoId
	PATCH    ${url_${ambiente}}/agenda/getAgendaByMedicoId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PUT agenda medico id status:404
	[Tags]   Agenda   Falha    /getAgendaByMedicoId
	PUT    ${url_${ambiente}}/agenda/getAgendaByMedicoId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

DELETE agenda medico id status:404
	[Tags]   Agenda   Falha    /getAgendaByMedicoId
	DELETE    ${url_${ambiente}}/agenda/getAgendaByMedicoId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

GET agenda paciente id status:200
	[Tags]   Agenda   Sucesso    /getAgendaByPacienteId
	GET    ${url_${ambiente}}/agenda/getAgendaByPacienteId/6513565ff82f74bee22d38e6    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg      Agendamentos do paciente recuperados com sucesso

POST agenda paciente id status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	POST    ${url_${ambiente}}/agenda/getAgendaByPacienteId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PATCH agenda paciente id status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	PATCH    ${url_${ambiente}}/agenda/getAgendaByPacienteId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PUT agenda paciente id status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	PUT    ${url_${ambiente}}/agenda/getAgendaByPacienteId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

DELETE agenda paciente id status:404
	[Tags]   Agenda   Falha    /getAgendaByPacienteId
	DELETE    ${url_${ambiente}}/agenda/getAgendaByPacienteId/650f02d17e3d7126ea75882f   timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

POST edita agenda status:200
	[Tags]   Agenda   Sucesso    /editByIdAgendamento
	POST    ${url_${ambiente}}/agenda/editByIdAgendamento/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg      Agendamento atualizado com sucesso

GET edita agenda status:404
	[Tags]   Agenda   Falha    /editByIdAgendamento
	GET    ${url_${ambiente}}/agenda/editByIdAgendamento/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PATCH edita agenda status:404
	[Tags]   Agenda   Falha    /editByIdAgendamento
	PATCH    ${url_${ambiente}}/agenda/editByIdAgendamento/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PUT edita agenda status:404
	[Tags]   Agenda   Falha    /editByIdAgendamento
	PUT    ${url_${ambiente}}/agenda/editByIdAgendamento/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

DELETE edita agenda status:404
	[Tags]   Agenda   Falha    /editByIdAgendamento
	DELETE    ${url_${ambiente}}/agenda/editByIdAgendamento/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

DELETE cancela agenda id status:200
	[Tags]   Agenda   Sucesso    /cancelaByAgendamentoId
	DELETE    ${url_${ambiente}}/agenda/cancelaByAgendamentoId/${id_agenda_criada}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg      Agendamento cancelado com sucesso

GET cancela agenda id status:404
	[Tags]   Agenda   Falha    /cancelaByAgendamentoId
	GET    ${url_${ambiente}}/agenda/cancelaByAgendamentoId/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PATCH cancela agenda id status:404
	[Tags]   Agenda   Falha    /cancelaByAgendamentoId
	PATCH    ${url_${ambiente}}/agenda/cancelaByAgendamentoId/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

PUT cancela agenda id status:404
	[Tags]   Agenda   Falha    /cancelaByAgendamentoId
	PUT    ${url_${ambiente}}/agenda/cancelaByAgendamentoId/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!

POST cancela agenda id status:404
	[Tags]   Agenda   Falha    /cancelaByAgendamentoId
	POST    ${url_${ambiente}}/agenda/cancelaByAgendamentoId/${id_agenda_criada}     {"dataConsulta": "2023-02-11"}    timeout=20
	Output Schema     response body
	Integer    response status    404
   String    response body message      Caminho não encontrado!