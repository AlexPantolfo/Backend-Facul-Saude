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