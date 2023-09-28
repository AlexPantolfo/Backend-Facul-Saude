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

POST add User status:200
	[Tags]   User     Sucesso     /addUser
	Gera Email aleatorio
	${json}  Load JSON from file    ${EXECDIR}/test/resources/user.json
	Update value to JSON    ${json}    email    ${email}
	POST    ${url_${ambiente}}/user/addUser   ${json}     timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body user email   ${email}
	${id_user_criado}  Output      response body user _id
	Set Global Variable    ${id_user_criado}

POST add User nome vazio status:400
	[Tags]   User     Falha     /addUser
	${json}  Load JSON from file    ${EXECDIR}/test/resources/user.json
	Update value to JSON    ${json}    nome    ${EMPTY}
	POST    ${url_${ambiente}}/user/addUser   ${json}     timeout=20
	Output Schema     response body
	Integer    response status    400
	String    response body error errors nome message   Nome é obrigatório

GET add User status:404
	[Tags]   User   Falha    /addUser
	GET    ${url_${ambiente}}/user/addUser   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT add User status:404
	[Tags]   User   Falha    /addUser
	PUT    ${url_${ambiente}}/user/addUser   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH add User status:404
	[Tags]   User   Falha    /addUser
	PATCH    ${url_${ambiente}}/user/addUser   {"email": "teste123", "password": "lalala"}   timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE add User status:404
	[Tags]    User   Falha  /addUser
	DELETE    ${url_${ambiente}}/user/addUser   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST login status:200
	[Tags]   User     Sucesso     /login
	${json}  Load JSON from file    ${EXECDIR}/test/resources/user.json
	Update value to JSON    ${json}    email    ${email}
	POST    ${url_${ambiente}}/user/login   ${json}     timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg   Autenticação realizada com sucesso!
	${token_usr}   Output   response body token
	Set Global Variable    ${token_usr}

POST login senha invalida status:422
	[Tags]   User     Falha     /login
	POST    ${url_${ambiente}}/user/login  {"email": "admin@mail.com", "password": "lalala"}     timeout=20
	Output Schema     response body
	Integer    response status    422
	String    response body msg   Senha inválida

GET login status:404
	[Tags]   User   Falha    /login
	GET    ${url_${ambiente}}/user/login   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT login status:404
	[Tags]   User   Falha    /login
	PUT    ${url_${ambiente}}/user/login   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH login status:404
	[Tags]   User   Falha    /login
	PATCH    ${url_${ambiente}}/user/logim   {"email": "teste123", "password": "lalala"}   timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE login status:404
	[Tags]    User   Falha  /login
	DELETE    ${url_${ambiente}}/user/login   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST login admin status:200
	[Tags]   User     Sucesso     /loginAdmin
	Builtin.Set Log Level    NONE
	${json}  Load JSON from file    ${EXECDIR}/test/resources/userAdmin.json
	Builtin.Set Log Level    INFO
	POST    ${url_${ambiente}}/user/loginAdmin   ${json}     timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg   Autenticação realizada com sucesso!
	${token_adm}   Output   response body token
	Set Global Variable    ${token_adm}

POST login admin senha invalida status:422
	[Tags]   User     Falha     /loginAdmin
	POST    ${url_${ambiente}}/user/loginAdmin   {"email": "admin@mail.com", "password": "lalala"}     timeout=20
	Output Schema     response body
	Integer    response status    422
	String    response body msg   Usuário ou senha inválidos

POST login admin email invalido status:404
	[Tags]   User     Falha     /loginAdmin
	POST    ${url_${ambiente}}/user/loginAdmin   {"email": "admi123n@mail.com", "password": "lalala"}     timeout=20
	Output Schema     response body
	Integer    response status    404
	String    response body msg   Usuário não encontrado!

GET login admin status:404
	[Tags]   User   Falha    /loginAdmin
	GET    ${url_${ambiente}}/user/loginAdmin   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT login admin status:404
	[Tags]   User   Falha    /loginAdmin
	PUT    ${url_${ambiente}}/user/loginAdmin   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH login admin status:404
	[Tags]   User   Falha    /loginAdmin
	PATCH    ${url_${ambiente}}/user/loginAdmin   {"email": "teste123", "password": "lalala"}   timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE login admin status:404
	[Tags]    User   Falha  /loginAdmin
	DELETE    ${url_${ambiente}}/user/loginAdmin   {"email": "teste123", "password": "lalala"}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST auth admin status:200
	[Tags]   User     Sucesso     /auth
	Set Headers    { "authorization": "${token_adm}"}
	POST    ${url_${ambiente}}/user/auth    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg   O Token é valido!

POST auth status:200
	[Tags]   User     Sucesso     /auth
	Set Headers    { "authorization": "${token_usr}"}
	POST    ${url_${ambiente}}/user/auth    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body msg   O Token é valido!

POST auth token invalido status:400
	[Tags]   User     Falha     /auth
	Set Headers    { "authorization": "123123"}
	POST    ${url_${ambiente}}/user/auth    timeout=20
	Output Schema     response body
	Integer    response status    400
	String    response body msg   O Token é inválido!

GET auth status:404
	[Tags]   User   Falha    /auth
	Set Headers    { "authorization": "123123"}
	GET    ${url_${ambiente}}/user/auth     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT auth status:404
	[Tags]   User   Falha    /auth
	PUT    ${url_${ambiente}}/user/auth      timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH auth status:404
	[Tags]   User   Falha    /auth
	PATCH    ${url_${ambiente}}/user/auth     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE auth status:404
	[Tags]    User   Falha  /auth
	DELETE    ${url_${ambiente}}/user/auth     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

GET todos usuários status:200
	[Tags]   User   Sucesso    /userAll
	GET    ${url_${ambiente}}/user/userAll    timeout=20
	Output Schema     response body
	Integer    response status    200
	Integer    response body Quantidade

POST todos usuários status:404
	[Tags]   User   Falha    /userAll
	POST    ${url_${ambiente}}/user/userAll    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!


PUT todos usuários status:404
	[Tags]   User   Falha    /userAll
	PUT    ${url_${ambiente}}/user/userAll    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH todos usuários status:404
	[Tags]   User   Falha    /userAll
	PATCH    ${url_${ambiente}}/user/userAll    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE todos usuários status:404
	[Tags]   User   Falha    /userAll
	DELETE    ${url_${ambiente}}/user/userAll    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

GET usuário id status:200
	[Tags]   User   Sucesso    /user-id
	GET    ${url_${ambiente}}/user/user-id-${id_user_criado}    timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body Dados ID      ${id_user_criado}

POST usuário id status:404
	[Tags]   User   Falha    /user-id
	POST    ${url_${ambiente}}/user/user-id-${id_user_criado}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT usuário id status:404
	[Tags]   User   Falha    /user-id
	PUT    ${url_${ambiente}}/user/user-id-${id_user_criado}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH usuário id status:404
	[Tags]   User   Falha    /user-id
	PATCH    ${url_${ambiente}}/user/user-id-${id_user_criado}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE usuário id status:404
	[Tags]   User   Falha    /user-id
	DELETE    ${url_${ambiente}}/user/user-id-${id_user_criado}    timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST atualiza usuário status:200
	[Tags]   User     Sucesso     /atualiza-user-id
	${json}  Load JSON from file    ${EXECDIR}/test/resources/userEditado.json
	POST    ${url_${ambiente}}/user/atualiza-user-id-${id_user_criado}   ${json}     timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body message   Usuário atualizado com sucesso
	String    response body ID        ${id_user_criado}
	String    response body nome   usuario teste editado

POST atualiza usuário id invalido status:400
	[Tags]   User     Falha     /atualiza-user-id
	${json}  Load JSON from file    ${EXECDIR}/test/resources/userEditado.json
	POST    ${url_${ambiente}}/user/atualiza-user-id-123123bc   ${json}     timeout=20
	Output Schema     response body
	Integer    response status    400
	String    response body message  ID invalido

GET atualiza usuário id status:404
	[Tags]   User   Falha    /atualiza-user-id
	Set Headers    { "authorization": "123123"}
	GET    ${url_${ambiente}}/user/atualiza-user-id-123123bc     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT atualiza usuário id status:404
	[Tags]   User   Falha    /atualiza-user-id
	PUT    ${url_${ambiente}}/user/atualiza-user-id-123123bc      timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH atualiza usuário id status:404
	[Tags]   User   Falha    /atualiza-user-id
	PATCH    ${url_${ambiente}}/user/atualiza-user-id-123123bc     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE atualiza usuário id status:404
	[Tags]    User   Falha  /atualiza-user-id
	DELETE    ${url_${ambiente}}/user/atualiza-user-id-123123bc     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

DELETE exclui usuário id status:200
	[Tags]   User     Sucesso     /exclui-user-id
	DELETE    ${url_${ambiente}}/user/exclui-user-id-${id_user_criado}      timeout=20
	Output Schema     response body
	Integer    response status    200
	String    response body message   Usuário excluído com sucesso
	String    response body ID        ${id_user_criado}

DELETE exclui usuário id invalido status:400
	[Tags]   User     Sucesso     /exclui-user-id
	DELETE    ${url_${ambiente}}/user/exclui-user-id-123123bc      timeout=20
	Output Schema     response body
	Integer    response status    400
	String    response body message  ID invalido

GET exclui usuário id status:404
	[Tags]   User   Falha    /exclui-user-id
	GET    ${url_${ambiente}}/user/exclui-user-id-123123bc     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PUT exclui usuário id status:404
	[Tags]   User   Falha    /exclui-user-id
	PUT    ${url_${ambiente}}/user/exclui-user-id-123123bc      timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

PATCH exclui usuário id status:404
	[Tags]   User   Falha    /exclui-user-id
	PATCH    ${url_${ambiente}}/user/exclui-user-id-123123bc     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!

POST exclui usuário id status:404
	[Tags]    User   Falha  /exclui-user-id
	POST    ${url_${ambiente}}/user/exclui-user-id-123123bc     timeout=20
	Output Schema     response body
	Integer    response status    404
	String     response body message  Caminho não encontrado!
