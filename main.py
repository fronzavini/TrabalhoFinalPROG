from datetime import datetime, timedelta
import mysql.connector
from classes import *


conexao = mysql.connector.connect(
    host = 'localhost' ,
    user = 'root' ,
    password = 'root',
    database = 'trabalhoFinal',
)


def vazio(dado):
    if dado == "":
        dado = None




def sistema_login():
    print("Bem-vindo ao sistema de login!")
    cursor = conexao.cursor()

    tentativas = 3
    while tentativas > 0:
        usuario = input("Usuário: ")
        senha = input("Senha: ")
        try:
            cursor = conexao.cursor()
            query = "SELECT senha, tipo, id FROM USUARIO WHERE usuario = %s"
            cursor.execute(query, (usuario,))
            informacoes = cursor.fetchone()  # Use fetchone() para obter apenas um registro.

            if informacoes:
                global id_usuario
                senha_correta, tipo_usuario, id_usuario = informacoes
                if senha == senha_correta:
                    print(f"Bem-vindo, {usuario}!")
                    if tipo_usuario.lower() == "funcionario":
                        menu_funcionario()
                    elif tipo_usuario.lower() == "cliente":
                        menu_cliente()
                    return  # Encerrar o login ao acessar o menu.
                else:
                    print("Senha incorreta. Tente novamente.")
            else:
                print("Usuário não encontrado.")

            tentativas -= 1
            print(f"Você ainda tem {tentativas} tentativa(s).")
        except mysql.connector.Error as e:
            print(f"Erro ao fazer login: {e}")
            conexao.rollback()
        finally:
            if 'cursor' in locals():  # Verifica se o cursor foi inicializado
                cursor.close()  
    print("Número de tentativas excedido. Encerrando o sistema.")
    return False


def menu_funcionario():
    while True:
        print("\nMenu Funcionário: ")
        print("1 - Sair")
        print("2 - Clientes")
        print("3 - Livros")
        print("4 - Empréstimos")
        print("5 - Funcionários")
        
        escolha_principal = int(input("Digite o número da opção desejada: "))

        if escolha_principal == 1:
            print("Saindo do sistema.")
            break
        elif escolha_principal == 2:
            menu_clientes()
        elif escolha_principal == 3:
            menu_livros()
        elif escolha_principal == 4:
            menu_emprestimos()
        elif escolha_principal == 5:
            menu_funcionarios()
        else:
            print("Opção inválida. Tente novamente.")

def menu_clientes():
    while True:
        print("\nEdição de Clientes:")
        print("1 - Voltar")
        print("2 - Cadastrar cliente")
        print("3 - Editar cliente")
        print("4 - Deletar cliente")
        print("5 - Listar cliente")
        escolha_usuarios = int(input("Digite o número da opção desejada: "))

        if escolha_usuarios == 1:
            print("Voltando ao menu inicial.")
            menu_funcionario()
        elif escolha_usuarios == 2:
            print("Preencha as informações abaixo para realizar o cadastro: ")
            usuario = input("Informe o nome de usuário para ser utilizado: ")
            senha = input("Infomre a senha que será utilizada: ")
            while True:
                    try:
                        cpf = input('Digite o CPF: ')
                        verificar_cpf(cpf)  # Verifica se o CPF é válido
                        print("CPF válido!")  # Se o CPF for válido, sai do laço
                        break  # Encerra o laço e segue para o restante do cadastro
                    except ValueError as e:
                        print(f"Erro: {e}. Tente novamente.")

            primeiro_nome = input("Informe o primeiro nome do cliente: ")
            sobrenome = input("Informe o sobrenome do cliente: ")
            Funcionario.cadastrar_cliente(usuario, senha, cpf, primeiro_nome, sobrenome)
        elif escolha_usuarios == 3:
                    id = int(input("Informe o ID do cliente que deseja alterar suas informações: "))
                    print("Preencha as informações abaixo que deseja alterar (caso não seja alterada aperte a tecla ENTER, pulando aquele dado): ")
                    usuario = input("Informe o novo nome de usuário para ser utilizado: ")
                    vazio(usuario)
                    senha = input("Infomre a nova senha que será utilizada: ")
                    vazio(senha)
                    cpf = input("Informe o novo cpf do cliente: ")
                    vazio(cpf)
                    primeiro_nome = input("Informe o novo primeiro nome do cliente: ")
                    vazio(primeiro_nome)
                    sobrenome = input("Informe o novo sobrenome do cliente: ")
                    vazio(sobrenome)
                    Funcionario.editar_cliente(id, usuario or None, senha or None, cpf or None, primeiro_nome or None, sobrenome or None)

        elif escolha_usuarios == 4:
                id = int(input("Informe o ID do cliente que deseja deletar: "))
                verificar = input("Você tem certeza que deseja excluir esse cliente?(sim/nao): ")
                if verificar.lower() == ("sim"):
                    Funcionario.excluir_cliente(id)
                elif verificar.lower() == "nao":
                    menu_clientes()
        elif escolha_usuarios == 5:
            Funcionario.listar_clientes()
        else:
            print("Opção inválida. Tente novamente.")

def menu_livros():
    while True:
        print("\nMenu Livros:")
        print("1 - Voltar")
        print("2 - Cadastrar Livro")
        print("3 - Editar Livro")
        print("4 - Deletar Livro")
        print("5 - Listar Livros")
        escolha_livros = int(input("Digite o número da opção desejada: "))

        if escolha_livros == 1:
            menu_funcionario()
        elif escolha_livros == 2:
            print("Preencha as informações abaixo para adicionar o livro: ")
            isbn = input("Informe o ISBN do livro: ")
            nome = input("Informe o nome do livro: ")
            autor = input("Informe o autor do livro: ")
            edicao = input("Informe a edicao do livro: ")
            quantidade = input("Informe a quantidade de livros: ")
            Livro.adicionar_livro(isbn, nome, autor, edicao, quantidade)
        elif escolha_livros == 3:
                    id = input("Informe o ID cadastrado do livro que deseja editar: ")
                    print("Preencha as informações abaixo que deseja alterar (caso não seja alterada aperte a tecla ENTER, pulando aquele dado): ")
                    isbn = input("Informe o novo ISBN do livro: ")
                    vazio(isbn)
                    nome = input("Infomre o novo nome que será utilizada: ")
                    vazio(nome)
                    autor = input("Informe o novo autor do livro: ")
                    vazio(autor)
                    edicao = input("Informe o nova edicao do livro: ")
                    vazio(edicao)
                    quantidade = input("Informe a nova quantidade de livros: ")
                    vazio(quantidade)
                    Livro.editar_livro(id,isbn, nome, autor, edicao, quantidade)

        elif escolha_livros == 4:
            id = input("Informe o ID do livro que deseja deletar: ")
            Livro.excluir_livro(id)
        elif escolha_livros == 5:
            Cliente.ver_livros()
        else:
            print("Opção inválida. Tente novamente.")

def menu_emprestimos():
    while True:
        print("\nMenu Empréstimos:")
        print("1 - Voltar")
        print("2 - Realizar Empréstimo")
        print("3 - Devolver Livro")
        escolha_emprestimos = int(input("Digite o número da opção desejada: "))

        if escolha_emprestimos == 1:
            print("Voltando ao menu anterior: ")
            menu_funcionario()
        elif escolha_emprestimos == 2:
            livro = input("Informe o ID do livro que será emprestado: ")
            cliente = input("Informe o ID do cliente que irá pegar o livro: ")
            funcionario = input("Informe o ID do funcionário que auxiliou no empréstimo: ")
            Emprestimo.realizar_emprestimo(cliente,livro,funcionario)
        elif escolha_emprestimos == 3:
                id_emprestimo = input("Digite o ID do empréstimo: ")
                Emprestimo.realizar_devolucao(id_emprestimo)
        else:
            print("Opção inválida. Tente novamente.")

def menu_funcionarios():
    while True:
        print("\nMenu Funcionários:")
        print("1 - Voltar")
        print("2 - Cadastrar Funcionário")
        print("3 - Editar Funcionário")
        print("4 - Deletar Funcionário")
        print("5 - Listar Funcionários")
        escolha_funcionarios = int(input("Digite o número da opção desejada: "))

        if escolha_funcionarios == 1:
            print("Voltando ao menu anterior.")
            menu_funcionario()  # Chama o menu de funcionário principal.
        elif escolha_funcionarios == 2:
            print("Preencha as informações abaixo para cadastrar o funcionário: ")
            usuario = input("Informe o nome de usuário para o funcionário: ")
            senha = input("Informe a senha para o funcionário: ")
            cpf = input("Digite o CPF do funcionário: ")
            primeiro_nome = input("Informe o primeiro nome do funcionário: ")
            sobrenome = input("Informe o sobrenome do funcionário: ")
            email = input("Informe o email do funcionário: ")
            funcao = input("Informe a função do funcionário (primeira letra maiúscula): ")
            Funcionario.cadastrar_funcionario(usuario, senha, cpf, primeiro_nome, sobrenome, email, funcao)
        elif escolha_funcionarios == 3:
                    id = input("Digite o ID do funcionário que deseja alterar: ")
                    print("Preencha as informações abaixo para alterar (caso não queira alterar, pressione ENTER): ")
                    usuario = input("Informe o novo nome de usuário: ")
                    vazio(usuario)
                    senha = input("Informe a nova senha: ")
                    vazio(senha)
                    cpf = input("Informe o novo CPF: ")
                    vazio(cpf)
                    primeiro_nome = input("Informe o novo primeiro nome: ")
                    vazio(primeiro_nome)
                    sobrenome = input("Informe o novo sobrenome: ")
                    vazio(sobrenome)
                    email = input("Informe o novo email do funcionário: ")
                    vazio(email)
                    funcao = input("Informe a nova função do funcionário (primeira letra maiúscula): ")
                    vazio(funcao)
                    
                    Funcionario.editar_funcionario(id, usuario, senha, cpf, primeiro_nome, sobrenome,email,funcao)
                
        elif escolha_funcionarios == 4:
                    id = input("Digite o ID do funcionário que deseja alterar: ")
                    confirmar = input("Tem certeza que deseja excluir este funcionário? (sim/nao): ")
                    if confirmar.lower() == "sim":
                        Funcionario.excluir_funcionario(id_usuario,id)
                        print("Funcionário excluído com sucesso.")
                    else:
                        print("Exclusão cancelada.")

        elif escolha_funcionarios == 5:
            Funcionario.listar_funcionarios()  
        else:
            print("Opção inválida. Tente novamente.")


def menu_cliente():
    while True:
        print("\nMenu Cliente:")
        print("1 - Sair")
        print("2 - Ver livros")
        print("3 - Ver emprestimos")
        print("4 - Calcular multas")
        print("5 - Pagar multa")
        escolha_cliente = int(input("Digite o número da opção desejada: "))

        if escolha_cliente == 1:
            print("Saindo do sistema. ")
            break
        elif escolha_cliente == 2:
            Cliente.ver_livros()
        elif escolha_cliente == 3:
            Cliente.ver_emprestimos(id_usuario)
        elif escolha_cliente == 4:
            Emprestimo.calcular_multa(id_usuario)
            Cliente.ver_multas(id_usuario)
        elif escolha_cliente == 5:
            id_multa = input("Informe o ID da multa que deseja pagar: ")
            Cliente.pagar_multa(id_multa)
        else:
            print("Opção inválida. Tente novamente.")



def verificar_cpf(cpf):

    if len(cpf) == 11 and cpf.isdigit():  

        if cpf == cpf[0] * 11:
            return False
        else:
            soma = 0
            mult = 10

            for digito in cpf[:9]: 
                soma += int(digito) * mult
                mult -= 1

            if soma % 11 >= 2:
                d1 = 11 - (soma % 11)
            else:
                d1 = 0

            soma = 0
            mult = 11

            for digito in cpf[:10]:  
                soma += int(digito) * mult
                mult -= 1

            if soma % 11 >= 2:
                d2 = 11 - (soma % 11)
            else:
                d2 = 0

            # Verifica se os dígitos calculados correspondem aos fornecidos
            if int(cpf[9]) == d1 and int(cpf[10]) == d2:
                return True
            else:
                raise ValueError("CPF inválido.")
    else:
        raise ValueError("CPF deve ter 11 dígitos numéricos.")

sistema_login()
