import json

def sistemaEspecialista():
    f = open('json/regras.json')
    regras = json.load(f)
    f = open('json/variaveis.json')
    variaveis = json.load(f)

    resposta = ''

    # aqui estamos percorrendo todas as variaveis e salvando o nome e os possiveis valores para gerar as perguntas
    for variavelAtual in variaveis:
        nomeVariavel = variavelAtual["nome"]
        mensagem = ''
        print(f"Qual a sua {nomeVariavel} alimentar?")
        for valores in variavelAtual["valores"]:
            mensagem += valores + " "
            
        valor = input("Valores possiveis: " + mensagem + ": ")
        
    # agora estamos comparando de acordo com as regras o que foi informado pelo usuario

        for regra in regras:
            if regra["variavel"] == nomeVariavel and regra["valor"] == valor:
                resposta += regra["resultado"]

    print("Recomendacao: " + resposta )