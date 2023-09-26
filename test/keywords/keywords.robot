*** Settings ***
Library     String

*** Keywords ***

Gera CRM aleatório
	${crm}     Evaluate  random.sample(range(100000, 999999),1)   random
	${crm}   Convert To Integer    ${crm}[0]
	Set Global Variable    ${crm}

Gera Email aleatorio
	${email}    Generate Random String
	${email}    Catenate    SEPARATOR=  ${email}    @email.com
	Set Global Variable    ${email}