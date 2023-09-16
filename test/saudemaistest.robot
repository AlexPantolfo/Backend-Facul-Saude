*** Settings ***
Library         REST

*** Variables ***

${url_dev}      http://localhost:3000
${url_prd}      https://backend-facul-saude.onrender.com
${id_valido_dev}     64ff4b2be5bc25b31f14604a
${id_valido_prd}     6504b2bb5cc3fae1728e10e6
${ambiente}

*** Test Cases ***

GET medicos disponiveis status:200
	[Tags]   Medico   Sucesso    /medicos-disponiveis
	GET    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Integer    response status    200
	Integer    response body Quantidade

POST medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	POST    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Integer    response status    404

PUT medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	PUT    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Integer    response status    404

PATCH medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	PATCH    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Integer    response status    404

DELETE medicos disponiveis status:404
	[Tags]   Medico   Falha    /medicos-disponiveis
	DELETE    ${url_${ambiente}}/medicos/medicos-disponiveis    timeout=20
	Integer    response status    404

GET medico id status:200
	[Tags]   Medico   Sucesso    /medico-id
	GET    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Integer    response status    200
	Expect Response Body    {"Dados": {"ID": "6504b2bb5cc3fae1728e10e6","nome": "Medico teste","especialidade": "especialidade teste","email": "teste@2gmail.com","foto": "foto teste"}}

GET medico id invalido status:404
	[Tags]   Medico   Falha    /medico-id
	GET    ${url_${ambiente}}/medicos/medico-id-123123123123    timeout=20
	Integer    response status    404

POST medico id status:404
	[Tags]   Medico   Falha    /medico-id
	POST    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Integer    response status    404

PUT medico id status:404
	[Tags]   Medico   Falha    /medico-id
	PUT    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Integer    response status    404

PATCH medico id status:404
	[Tags]   Medico   Falha    /medico-id
	PATCH    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Integer    response status    404

DELETE medico id status:404
	[Tags]   Medico   Falha    /medico-id
	DELETE    ${url_${ambiente}}/medicos/medico-id-${id_valido_${ambiente}}    timeout=20
	Integer    response status    404

GET medico especialidade status:200
	[Tags]   Medico   Sucesso    /medico-especialidade
	GET    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Integer    response status    200
	Array    response body Dados
	String    $..especialidade    Ortopedia

GET medico especialidade invalida status:200
	[Tags]   Medico   Sucesso    /medico-especialidade
	GET    ${url_${ambiente}}/medicos/medico-especialidade-especialidadeinvalida    timeout=20
	Integer    response status    200
	Expect Response Body    {"Dados": []}

POST medico especialidade status:404
	[Tags]   Medico   Falha    /medico-especialidade
	POST    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Integer    response status    404

PUT medico especialidade status:404
	[Tags]   Medico   Falha    /medico-especialidade
	PUT    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Integer    response status    404

PATCH medico especialidade status:404
	[Tags]   Medico   Falha    /medico-especialidade
	PATCH    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Integer    response status    404

DELETE medico especialidade status:404
	[Tags]    Medico   Falha    /medico-especialidade
	DELETE    ${url_${ambiente}}/medicos/medico-especialidade-Ortopedia    timeout=20
	Integer    response status    404

POST novo medico status:200
	#TODO - Quando receber json como response, armazenar id como variavel global para deletar depois
	[Tags]   Medico   Sucesso    /novo-medico
	POST    ${url_${ambiente}}/medicos/novo-medico    ${EXECDIR}/test/resources/medico.json     timeout=20

GET novo medico status:404
	[Tags]   Medico   Falha    /novo-medico
	GET    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Integer    response status    404

PUT novo medico status:404
	[Tags]   Medico   Falha    /novo-medico
	PUT    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Integer    response status    404

PATCH novo medico status:404
	[Tags]   Medico   Falha    /novo-medico
	PATCH    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Integer    response status    404

DELETE novo medico status:404
	[Tags]    Medico   Falha   /novo-medico
	DELETE    ${url_${ambiente}}/medicos/novo-medico    timeout=20
	Integer    response status    404





