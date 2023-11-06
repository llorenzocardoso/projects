from tkinter import *
import json

respostas_usuario = {}

def voltar_para_principal(janela_atual):
    janela_atual.destroy()  # Fecha a janela atual
    janela.deiconify()  # Exibe a janela principal novamente

def adicionar_regra(variavel, valor, resultado):
    with open('json/regras.json') as json_file:
        data = json.load(json_file)
        data.append({
            'variavel': variavel,
            'valor': valor,
            'resultado': resultado
        })
    with open('json/regras.json', 'w') as json_file:
        json.dump(data, json_file)

def adicionar_variavel(nome, valores):
    with open('json/variaveis.json') as json_file:
        data = json.load(json_file)
        data.append({
            'nome': nome,
            'valores': valores
        })
    with open('json/variaveis.json', 'w') as json_file:
        json.dump(data, json_file)

def exibir_proxima_pergunta(indice, variaveis, janela_anterior):
    if indice < len(variaveis):
        nomeVariavel = variaveis[indice]["nome"]
        mensagem = ''

        def resposta_escolhida(valor, variavel, proximo_indice):
            respostas_usuario[variavel] = valor
            exibir_proxima_pergunta(proximo_indice, variaveis, janela_variavel)

        for valores in variaveis[indice]["valores"]:
            mensagem += valores + " "

        janela_variavel = Tk()
        janela_variavel.title(f"Pergunta - {nomeVariavel}")
        janela_variavel.geometry("+100+100")  # Definindo a posição da nova janela

        for idx, valor in enumerate(variaveis[indice]["valores"]):
            botao = Button(janela_variavel, text=valor, command=lambda v=valor, var=nomeVariavel, i=indice+1: resposta_escolhida(v, var, i))
            botao.pack()

        botao_voltar = Button(janela_variavel, text="Voltar", command=lambda: voltar_para_principal(janela_variavel))
        botao_voltar.pack()

        janela_anterior.withdraw()
        janela_variavel.mainloop()
    else:
        obter_recomendacao()
        janela_anterior.destroy()  # Fecha a janela atual após a última pergunta

def sistemaEspecialista():
    with open('json/variaveis.json') as json_file:
        variaveis = json.load(json_file)
        exibir_proxima_pergunta(0, variaveis, janela)

def abrir_pagina_adicionar_regra():
    janela.withdraw()  # Esconde a janela principal
    janela_adicionar_regra = Tk()
    janela_adicionar_regra.title("Adicionar Regra")
    janela_adicionar_regra.geometry("+100+100")  # Definindo a posição da nova janela

    f = open('json/variaveis.json')
    variaveis = json.load(f)
    variaveis_nomes = [variavel["nome"] for variavel in variaveis]

    label_variavel = Label(janela_adicionar_regra, text="Variável:")
    label_variavel.pack()
    variavel_selecionada = StringVar(janela_adicionar_regra)
    variavel_selecionada.set(variaveis_nomes[0])  # Valor padrão
    dropdown_variavel = OptionMenu(janela_adicionar_regra, variavel_selecionada, *variaveis_nomes)
    dropdown_variavel.pack()

    label_valor = Label(janela_adicionar_regra, text="Valor:")
    label_valor.pack()
    entrada_valor = Entry(janela_adicionar_regra, width=30)
    entrada_valor.pack()

    label_resultado = Label(janela_adicionar_regra, text="Resultado:")
    label_resultado.pack()
    entrada_resultado = Entry(janela_adicionar_regra, width=30)
    entrada_resultado.pack()

    def adicionar_regra_interface():
        variavel = variavel_selecionada.get()
        valor = entrada_valor.get()
        resultado = entrada_resultado.get()
        adicionar_regra(variavel, valor, resultado)

    botao_adicionar = Button(janela_adicionar_regra, text="Adicionar Regra", command=adicionar_regra_interface)
    botao_adicionar.pack()

    botao_voltar = Button(janela_adicionar_regra, text="Voltar", command=lambda: voltar_para_principal(janela_adicionar_regra))
    botao_voltar.pack()

    janela_adicionar_regra.mainloop()

def abrir_pagina_adicionar_variavel():
    janela.withdraw()  # Esconde a janela principal
    janela_adicionar_variavel = Tk()
    janela_adicionar_variavel.title("Adicionar Variável")
    janela_adicionar_variavel.geometry("+100+100")  # Definindo a posição da nova janela

    label_nome = Label(janela_adicionar_variavel, text="Nome:")
    label_nome.pack()
    entrada_nome = Entry(janela_adicionar_variavel, width=30)
    entrada_nome.pack()

    campos_valores = []

    def adicionar_campo():
        campo = Entry(janela_adicionar_variavel, width=30)
        campo.pack()
        campos_valores.append(campo)

    def adicionar_variavel_interface():
        nome = entrada_nome.get()
        valores = [campo.get() for campo in campos_valores]
        adicionar_variavel(nome, valores)

    botao_adicionar_campo = Button(janela_adicionar_variavel, text="Adicionar Campo de Valor", command=adicionar_campo)
    botao_adicionar_campo.pack()

    botao_adicionar = Button(janela_adicionar_variavel, text="Adicionar Variável", command=adicionar_variavel_interface)
    botao_adicionar.pack()

    botao_voltar = Button(janela_adicionar_variavel, text="Voltar", command=lambda: voltar_para_principal(janela_adicionar_variavel))
    botao_voltar.pack()

    janela_adicionar_variavel.mainloop()
    
def obter_recomendacao():
    with open('json/regras.json') as json_file:
        regras = json.load(json_file)
        resposta = ''

        for regra in regras:
            if regra["variavel"] in respostas_usuario and regra["valor"] == respostas_usuario[regra["variavel"]]:
                resposta += regra["resultado"]

        print("Recomendacao: " + resposta)

janela = Tk()
janela.title("Sistema Especialista - Recomendações Nutricionais")
janela.geometry("+100+100")  # Definindo a posição da janela principal

texto_orientacao = Label(janela, text="Clique na opção desejada")
texto_orientacao.grid(column=0, row=0)

botao1 = Button(janela, text="Adicionar Regra", command=abrir_pagina_adicionar_regra)
botao1.grid(column=0, row=1)
botao2 = Button(janela, text="Adicionar Variável", command=abrir_pagina_adicionar_variavel)
botao2.grid(column=0, row=2)
botao3 = Button(janela, text="Acessar Sistema", command=sistemaEspecialista)
botao3.grid(column=0, row=3)

janela.mainloop()
