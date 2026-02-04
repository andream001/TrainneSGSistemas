SGTrainec 2026
Desenvolver um programa para gerenciamento de uma empresa do assistôncin tcnicn
Criar tela de inicialização do sistema (ogin-"JOSE"-Senha: "432mudar123"). após logar, criar um menu principal (1. Efetuar pedidos e 2. Sair`)
Solicitar os dados da ordem de servico (Ordem de Servico (/8) - Contador automático, Nome ac cliente (C/40), Data Ordem Serviço, Nome do técnico (C/30), Descrição do equipamento (C/40), Data de Compra. Entrega Domicilio? (C/1) e limite de crédito do cliente
Caso a ordem de serviço seja para entrega, solicitar OS dados: Endereço, Bairro, Referência C Telefone, adicionar uma Taxa de entrega de 2% no valor total da ordem de servico.
Caso o valor da ordem de Serviço seja maior que limite de crédito do cliente, solicitar usuário SUPERVISOR (C/15) no qual a senha será "AUTORIZA99". Caso não seja validado pelo supervisor. desconsiderar o último serviço/produto para que o limite não fique estourado
Solicitar os dados dos serviços que serão efetuados ([P]roduto/[S]erviço:
1. Caso seja Produto: Descrição do produto (C/30), Qtde, Preço Unit.(N/11/2), %Desconto(N/5/2). Valor Total (/11/2) - calculado
2. Caso seja Serviço: Descrição do Serviço (C/25), %Desconto(N/5/2), %Comissão Técnico(N/5/2),. Preço Total (N/12/2)
○ usuário poderá digitar quantos produtos/serviços quiser ou até que o usuário tecle [ESC] (perguntar se deseja finalizar a ordem de serviço) - Realizar o controle de linhas.
. Caso o equipamento esteja na garantia (2 anos para os produtos e 1 ano para os serviços), abater os valores do cálculo da ordem de serviço.
No momento da digitação dos produtos/serviços, mostrar simultaneamente o valor total da ordem de serviço e o valor total já contemplando a questão da garantia.
No momento do fechamento da venda, solicitar as formas de pagamento: Dinheiro, Cheque, Cartão. ○ usuário poderá utilizar as 03 formas de pagamento, entretanto, não poderá repeti-la.
Caso o valor total da ordem de serviço seja zero, ou seja, a garantia cobrirá todo o conserto, avisar usuário e solicitar os dados da nota fiscal: CNPJ da empresa (N/14), Número da Nota (N/10), Data da nota.
Mostrar o valor total da comissão do técnico.
Boa Sorte!