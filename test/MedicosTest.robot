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

############ MÉDICOS ################

GET medicos disponiveis status:200
	[Tags]   Medico   Sucesso    /medicos-disponiveis
	GET    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Output Schema     response body
	Integer    response status    200
	Integer    response body Quantidade

POST medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	POST    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!


PUT medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	PUT    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	PATCH    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	DELETE    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

GET medico id status:200
	[Tags]   Medico   Sucesso    /medico-id
	GET    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Output Schema     response body
	Integer    response status    200
	Expect Response Body    {"Dados": {"ID": "6504b2bb5cc3fae1728e10e6","nome": "Medico teste","especialidade": "especialidade teste","email": "teste@2gmail.com","foto": "foto teste"}}

GET medico id invalido status:404
	[Tags]   Medico   Falha    /medico-id
	GET    ${url_${ambiente}}/medicos/medico-id-123123123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String    response body message  ID nao encontrado

POST medico id status:404
	[Tags]   Medico   Falha    /medico-id
	POST    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT medico id status:404
	[Tags]   Medico   Falha    /medico-id
	PUT    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH medico id status:404
	[Tags]   Medico   Falha    /medico-id
	PATCH    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE medico id status:404
	[Tags]   Medico   Falha    /medico-id
	DELETE    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

GET medico especialidade status:200
	[Tags]   Medico   Sucesso    /medico-especialidade
	GET    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Output Schema     response body
	Integer    response status    200
	Array    response body Dados
	String    $..especialidade    Ortopedia

GET medico especialidade invalida status:200
	[Tags]   Medico   Sucesso    /medico-especialidade
	GET    ${url_${ambiente}}/medicos/medico-especialidade-especialidadeinvalida    timeout=20
	Output Schema     response body
	Integer    response status    200
	Expect Response Body    {"Dados": []}

POST medico especialidade status:404
	[Tags]   Medico   Falha    /medico-especialidade
	POST    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT medico especialidade status:404
	[Tags]   Medico   Falha    /medico-especialidade
	PUT    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH medico especialidade status:404
	[Tags]   Medico   Falha    /medico-especialidade
	PATCH    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE medico especialidade status:404
	[Tags]    Medico   Falha    /medico-especialidade
	DELETE    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST novo medico status:200
	[Tags]   Medico   Sucesso    /novo-medico
	Gera CRM aleatório
	${json}  Load JSON from file    ${EXECDIR}/test/resources/medico.json
	Update value to JSON    ${json}    CRM    ${crm}
	POST    ${url_${ambiente}}/medicos/novo-medico    ${json}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body message     Médico criado com sucesso
	${id_medico_criado}  Output      response body ID
	Set Global Variable    ${id_medico_criado}

POST novo medico CRM duplicado status:500
	[Tags]   Medico   Falha    /novo-medico
	Gera CRM aleatório
	${json}  Load JSON from file    ${EXECDIR}/test/resources/medico.json
	Update value to JSON    ${json}    CRM    222222
	POST    ${url_${ambiente}}/medicos/novo-medico    ${json}    timeout=20
	Output Schema     response body
	Integer    response status    500
	String    response body message     E11000 duplicate key error collection: test.medicos index: CRM_1 dup key: { CRM: 222222 }

POST novo medico nome vazio status:500
	[Tags]   Medico   Falha    /novo-medico
	Gera CRM aleatório
	${json}  Load JSON from file    ${EXECDIR}/test/resources/medico.json
	Update value to JSON    ${json}    nome    ${EMPTY}
	POST    ${url_${ambiente}}/medicos/novo-medico    ${json}    timeout=20
	Output Schema     response body
	Integer    response status    500
	String    response body message     Medicos validation failed: nome: Nome é obrigatório

POST novo medico especialidade vazia status:500
	[Tags]   Medico   Falha    /novo-medico
	Gera CRM aleatório
	${json}  Load JSON from file    ${EXECDIR}/test/resources/medico.json
	Update value to JSON    ${json}    especialidade    ${EMPTY}
	POST    ${url_${ambiente}}/medicos/novo-medico    ${json}    timeout=20
	Output Schema     response body
	Integer    response status    500
	String    response body message     Medicos validation failed: especialidade: Especialidade é obrigatória

POST novo medico email vazio status:500
	[Tags]   Medico   Falha    /novo-medico
	Gera CRM aleatório
	${json}  Load JSON from file    ${EXECDIR}/test/resources/medico.json
	Update value to JSON    ${json}    email    ${EMPTY}
	POST    ${url_${ambiente}}/medicos/novo-medico    ${json}    timeout=20
	Output Schema     response body
	Integer    response status    500
	String    response body message     Medicos validation failed: email: Email é obrigatório

POST novo medico foto vazio status:500
	[Tags]   Medico   Falha    /novo-medico
	Gera CRM aleatório
	${json}  Load JSON from file    ${EXECDIR}/test/resources/medico.json
	Update value to JSON    ${json}    foto    ${EMPTY}
	POST    ${url_${ambiente}}/medicos/novo-medico    ${json}    timeout=20
	Output Schema     response body
	Integer    response status    500
	String    response body message     Medicos validation failed: foto: Foto é obrigatória

GET novo medico status:404
	[Tags]   Medico   Falha    /novo-medico
	GET    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT novo medico status:404
	[Tags]   Medico   Falha    /novo-medico
	PUT    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH novo medico status:404
	[Tags]   Medico   Falha    /novo-medico
	PATCH    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE novo medico status:404
	[Tags]    Medico   Falha   /novo-medico
	DELETE    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST atualiza medico id status:200
	[Tags]   Medico   Sucesso    /atualiza-medico-id
	POST    ${url_${ambiente}}/medicos/atualiza-medico-id-${id_medico_criado}    {"nome": "Medice teste editado", "especialidade": "Cardiologia"}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body message     Médico atualizado com sucesso
	String    response body ID    ${id_medico_criado}
	String    response body nome  Medice teste editado
	String    response body especialidade  Cardiologia

POST atualiza medico id ID invalido status:400
	[Tags]   Medico   Falha    /atualiza-medico-id
	POST    ${url_${ambiente}}/medicos/atualiza-medico-id-123123    {"nome": "Medice teste editado", "especialidade": "Cardiologia"}    timeout=20
	Output Schema     response body
	Integer    response status    400
	String    response body message  ID invalido

GET atualiza medico id status:404
	[Tags]   Medico   Falha    /atualiza-medico-id
	GET    ${url_${ambiente}}/medicos/atualiza-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT atualiza medico id status:404
	[Tags]   Medico   Falha    /atualiza-medico-id
	PUT    ${url_${ambiente}}/medicos/atualiza-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH atualiza medico id status:404
	[Tags]   Medico   Falha    /atualiza-medico-id
	PATCH    ${url_${ambiente}}/medicos/atualiza-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE atualiza medico id status:404
	[Tags]    Medico   Falha  /atualiza-medico-id
	DELETE    ${url_${ambiente}}/medicos/atualiza-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE exclui medico id status:200
	[Tags]   Medico   Sucesso    /exclui-medico-id
	DELETE    ${url_${ambiente}}/medicos/exclui-medico-id-${id_medico_criado}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String     response body message  Médico excluído com sucesso
	String     response body nome    Medice teste editado
	String     response body ID      ${id_medico_criado}

DELETE exclui medico id invalido status:404
	[Tags]   Medico   Falha    /exclui-medico-id
	DELETE    ${url_${ambiente}}/medicos/exclui-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    400
	String    response body message  ID invalido

GET exclui medico id status:404
	[Tags]   Medico   Falha    /exclui-medico-id
	GET    ${url_${ambiente}}/medicos/exclui-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST exclui medico id status:404
	[Tags]   Medico   Falha    /exclui-medico-id
	POST    ${url_${ambiente}}/medicos/exclui-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT exclui medico id status:404
	[Tags]   Medico   Falha    /exclui-medico-id
	PUT    ${url_${ambiente}}/medicos/exclui-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH exclui medico id status:404
	[Tags]   Medico   Falha    /exclui-medico-id
	PATCH    ${url_${ambiente}}/medicos/exclui-medico-id-123123    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!
