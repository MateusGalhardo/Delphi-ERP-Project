# 🌊 Bitwave ERP — Sistema de Gestão de Vendas

> **ERP de vendas desenvolvido em Delphi VCL com SQL Server, focado em pequenas e médias empresas que precisam de controle completo sobre clientes, produtos, fornecedores e vendas.**

---

## 📋 Índice

- [Descrição Geral](#-descrição-geral)
- [Objetivo do Sistema](#-objetivo-do-sistema)
- [Funcionalidades Principais](#-funcionalidades-principais)
- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Arquitetura do Projeto](#-arquitetura-do-projeto)
- [Estrutura de Pastas](#-estrutura-de-pastas)
- [Banco de Dados](#-banco-de-dados)
- [Requisitos para Rodar](#-requisitos-para-rodar)
- [Como Configurar o Ambiente](#-como-configurar-o-ambiente)
- [Como Compilar o Projeto](#-como-compilar-o-projeto)
- [Como Conectar ao Banco](#-como-conectar-ao-banco)
- [Principais Telas](#-principais-telas)
- [Regras de Negócio](#-regras-de-negócio)
- [Validações Implementadas](#-validações-implementadas)
- [Integrações Externas](#-integrações-externas)
- [Padrões Utilizados](#-padrões-utilizados)
- [Criptografia](#-criptografia)
- [Sistema de Permissões](#-sistema-de-permissões)
- [Relatórios](#-relatórios)
- [Dependências e Componentes Terceiros](#-dependências-e-componentes-terceiros)

---

## 📌 Descrição Geral

O **Bitwave** é um sistema ERP (Enterprise Resource Planning) desktop desenvolvido em **Delphi VCL** com persistência em **Microsoft SQL Server**. O sistema cobre o ciclo completo de uma operação comercial: cadastros de clientes, fornecedores, produtos e categorias; controle de estoque; emissão e gestão de vendas; relatórios gerenciais; dashboard financeiro com gráficos; log de auditoria; e controle granular de permissões de acesso por usuário.

A aplicação é distribuída como um único executável Windows (`vendas.exe`) que se conecta ao SQL Server via arquivo de configuração INI, tornando o deploy simples e sem dependências de instalador.

---

## 🎯 Objetivo do Sistema

Fornecer a pequenas e médias empresas uma ferramenta integrada para:

- Gerenciar o cadastro completo de clientes (com situação/status, endereço via CEP, CPF/CNPJ validados)
- Controlar fornecedores com CNPJ obrigatório
- Gerenciar catálogo de produtos com categorias, estoque e imagem
- Processar vendas com múltiplos itens, controle automático de estoque e exportação para Excel
- Emitir relatórios em PDF e Excel
- Auditar todas as ações dos usuários no sistema
- Controlar acesso por usuário com permissões por tela/ação

---

## ✨ Funcionalidades Principais

| Módulo | Funcionalidades |
|---|---|
| **Cadastro de Clientes** | CRUD completo, busca por CEP (ViaCEP), validação CPF/CNPJ, situação do cliente, foto de status, data de nascimento |
| **Cadastro de Fornecedores** | CRUD completo, CNPJ obrigatório, endereço completo, busca por CEP |
| **Cadastro de Produtos** | CRUD completo, foto do produto (BMP/JPG/PNG), categoria, fornecedor vinculado, unidade de medida, controle de estoque |
| **Categorias** | CRUD completo de categorias de produtos |
| **Vendas** | Seleção de cliente e produtos, adição de itens com quantidade e valor unitário, cálculo automático de total, exportação Excel |
| **Controle de Estoque** | Baixa automática ao confirmar venda, devolução ao cancelar/apagar venda |
| **Dashboard** | 4 gráficos na tela principal (barras, pizza, linha), atualização por timer |
| **Resumo Financeiro** | Total de estoque, total de vendas, lucro estimado, gráfico de balanço por período |
| **Relatórios** | Clientes, fichas de clientes, produtos, categorias, vendas por período, produtos por categoria (PDF e Excel) |
| **Usuários** | CRUD de usuários, alteração de senha, vinculação a perfis de acesso |
| **Controle de Acesso** | Ações de acesso por tela/formulário, mapeamento usuário × ações com ativação/desativação |
| **Log de Auditoria** | Registro de ações por usuário com data/hora, tela e descrição |
| **ChatBot interno** | Consultas pré-definidas ao banco (estoque total, total de vendas, contagem de usuários/clientes/fornecedores) |
| **Auto-atualização do BD** | Criação e atualização automática de tabelas e colunas ao iniciar o sistema |

---

## 🛠 Tecnologias Utilizadas

| Tecnologia | Versão / Detalhes |
|---|---|
| **Delphi** | RAD Studio (VCL, Win32) |
| **SQL Server** | Microsoft SQL Server / SQL Server Express |
| **FireDAC** | Camada de acesso a dados (nativa do Delphi) |
| **TeeChart (VCLTee)** | Gráficos no Dashboard e Resumo Financeiro |
| **RLReport** | Geração de relatórios (PDF, XLS, XLSX) |
| **Indy (IndyHTTP/SSL)** | Requisições HTTP para ViaCEP |
| **DataSnap (TClientDataSet)** | Gerenciamento do carrinho de itens da venda em memória |
| **ViaCEP API** | Preenchimento automático de endereço por CEP |
| **OpenSSL** | SSL/TLS para chamadas HTTPS (libeay32.dll / ssleay32.dll) |
| **RxLib** | Componentes auxiliares (RxToolEdit, RxCurrEdit, RxPickDate) |
| **PngBitBtn / PngSpeedButton** | Botões com suporte a PNG |
| **Git** | Controle de versão |

---

## 🏗 Arquitetura do Projeto

O projeto adota uma arquitetura em camadas inspirada no padrão **MVC/MVP**, separando claramente responsabilidades:

```
┌─────────────────────────────────────────────────────┐
│              CAMADA DE APRESENTAÇÃO                 │
│  Forms (uCad*, uCon*, uPro*, uRel*, uControle*)     │
│  Herança base: TfrmTelaHeranca / TfrmTelaHerancaConsulta │
└────────────────────┬────────────────────────────────┘
                     │ usa
┌────────────────────▼────────────────────────────────┐
│              CAMADA DE NEGÓCIO (Classes/)            │
│  TCliente, TProduto, TFornecedor, TVenda,            │
│  TControleEstoque, TAcaoAcesso, TUsuario, etc.       │
└────────────────────┬────────────────────────────────┘
                     │ usa
┌────────────────────▼────────────────────────────────┐
│              CAMADA DE DADOS (DataModules/)          │
│  TdtmConexao (conexão), TdtmVenda (queries venda)   │
│  TDTMGrafico (queries do dashboard)                 │
└────────────────────┬────────────────────────────────┘
                     │ FireDAC
┌────────────────────▼────────────────────────────────┐
│              SQL SERVER (banco de dados)             │
└─────────────────────────────────────────────────────┘
```

**Padrão base de telas de cadastro:** todas as telas de manutenção herdam de `TfrmTelaHeranca`, que já encapsula o comportamento padrão de listagem, pesquisa, botões CRUD, navegação e persistência de preferências de grid via INI.

**Padrão base de telas de consulta:** telas somente-leitura herdam de `TfrmTelaHerancaConsulta`.

---

## 📁 Estrutura de Pastas

```
arquivos vendas/
├── vendas.dpr              # Projeto principal (entry point)
├── vendas.dproj            # Arquivo de projeto Delphi
├── uPrincipal.pas/.dfm     # Form principal (menu + dashboard)
├── uLogin.pas/.dfm         # Tela de login
│
├── Cadastro/               # Forms de cadastro (View)
│   ├── uCadCliente.*       # Cadastro de clientes
│   ├── uCadProduto.*       # Cadastro de produtos
│   ├── uCadCategoria.*     # Cadastro de categorias
│   ├── uCadUsuario.*       # Cadastro de usuários
│   ├── uCadAcaoAcesso.*    # Cadastro de ações de acesso
│   └── uFornecedor.*       # Cadastro de fornecedores
│
├── Classes/                # Regras de negócio (Model)
│   ├── cCadCliente.pas     # Classe TCliente (CRUD + validação)
│   ├── cCadProduto.pas     # Classe TProduto (CRUD + foto)
│   ├── cFornecedor.pas     # Classe TFornecedor (CRUD + validação)
│   ├── cCadCategoria.pas   # Classe TCategoria
│   ├── cCadUsuario.pas     # Classe TUsuario (CRUD + login + senha)
│   ├── cAcaoAcesso.pas     # Classe TAcaoAcesso (permissões)
│   ├── CProVenda.pas       # Classe TVenda (venda + itens + estoque)
│   ├── cControleEstoque.pas# Classe TControleEstoque (baixa/devolução)
│   ├── cValidar.pas        # Funções ValidarCPF / ValidarCNPJ
│   ├── cArquivoIni.pas     # Leitura/escrita de arquivo INI
│   ├── cFuncao.pas         # Utilitários (criação de forms c/ permissão)
│   ├── cAtualizacaoBancoDeDados.pas    # Base de auto-update DB
│   ├── cAtualizacaoTabelaMSSQL.pas     # Criação de tabelas
│   └── cAtualizacaoCampoMSSQL.pas      # Adição de colunas (migrations)
│
├── Consulta/               # Telas de lookup/seleção
│   ├── uConCliente.*
│   ├── uConProduto.*
│   ├── uConCategoria.*
│   └── uConFornecedor.*
│
├── Processo/               # Telas de processo de negócio
│   └── uProVenda.*         # Tela de processamento de vendas
│
├── Relatório/              # Relatórios (RLReport)
│   ├── uRelCadCliente.*
│   ├── uRelCadClienteFicha.*
│   ├── uRelCadProduto.*
│   ├── uRelCadProdutoComGrupoCategoria.*
│   ├── uRelCategoria.*
│   ├── uRelProVenda.*
│   ├── uRelVendaPorData.*
│   └── uSelecionarData.*
│
├── Controle/               # Módulos de controle operacional
│   ├── uChatBot.*          # ChatBot com consultas SQL pré-definidas
│   ├── uControleLog.*      # Visualização do log de auditoria
│   └── uResFinanceiro.*    # Resumo financeiro com gráficos
│
├── Heranca/                # Classes/forms base (herança)
│   ├── uTelaHeranca.*      # Form base para telas de CRUD
│   ├── uTelaHerancaConsulta.* # Form base para consultas
│   ├── uEnum.pas           # Enumerações do sistema
│   └── uFuncaoCriptografia.pas # Criptografia de senha
│
├── datamodule/             # DataModules (acesso a dados)
│   ├── uDTMconexao.*       # Módulo de conexão (FireDAC + INI)
│   ├── uDTMVenda.*         # DataModule para venda
│   ├── uDTMGrafico.*       # DataModule para gráficos do dashboard
│   └── uFrmAtualizaDB.*    # Form de status de atualização do BD
│
├── login/                  # Módulo de autenticação
│   ├── cUsuarioLogado.pas  # Classe TUsuarioLogado + TenhoAcesso()
│   ├── uAlterarSenha.*     # Tela de alteração de senha
│   └── uUsuarioVsAcoes.*   # Mapeamento usuário × permissões
│
├── Terceiros/              # Componentes de terceiros
│   └── Enter.pas           # Navegação por Enter (Tab substituído)
│
├── viacep-master/          # Biblioteca ViaCEP
│   ├── src/ViaCEP.Core.pas
│   ├── src/ViaCEP.Intf.pas
│   ├── src/ViaCEP.Model.pas
│   └── lib/ (libeay32.dll, ssleay32.dll)
│
├── Images/                 # Recursos visuais
│   └── *.bmp, *.png, *.jpg
│
└── Win32/Debug/            # Saída de compilação
    ├── vendas.exe
    └── vendas.ini          # Configuração de conexão
```

---

## 🗄 Banco de Dados

**SGBD:** Microsoft SQL Server (qualquer edição, incluindo SQL Server Express)

O sistema **cria automaticamente todas as tabelas** na primeira execução através das classes `TAtualizacaoTableMSSQL` e `TAtualizacaoCampoMSSQL`. Não é necessário executar script manual de criação de schema.

### Tabelas identificadas no código

| Tabela | Descrição | Campos principais |
|---|---|---|
| `categorias` | Categorias de produtos | `categoriaId` (PK, identity), `descricao` |
| `situacao` | Situações/status do cliente | `IDSituacao` (PK), `SituacaoCliente` |
| `clientes` | Cadastro de clientes | `clienteId`, `nome`, `documento`, `IDSituacao` (FK), `endereco`, `cidade`, `bairro`, `estado`, `cep`, `telefone`, `email`, `dataNascimento`, `observacao`, `casa` |
| `fornecedores` | Cadastro de fornecedores | `fornId`, `nome`, `cnpj`, `endereco`, `numero`, `bairro`, `cidade`, `estado`, `cep`, `telefone`, `email`, `observacao` |
| `produtos` | Catálogo de produtos | `produtoId`, `nome`, `descricao`, `valor`, `quantidade`, `categoriaId` (FK), `foto` (VarBinary MAX), `fornId` (FK), `unidadeMedida` |
| `vendas` | Cabeçalho das vendas | `vendaId`, `clienteId` (FK), `dataVenda`, `totalVenda` |
| `vendasItens` | Itens de cada venda | `vendaId` (FK), `produtoId` (FK), `quantidade`, `valorUnitario`, `valorTotalProduto` |
| `usuarios` | Usuários do sistema | `usuarioId`, `nome`, `senha` (criptografada), `perfilId` |
| `perfil` | Perfis de usuário | `perfilId`, `descricao` |
| `acaoAcesso` | Ações/telas cadastradas | `acaoAcessoId`, `descricao`, `chave` |
| `usuariosAcaoAcesso` | Permissões usuário × ação | `usuarioId` (FK), `acaoAcessoId` (FK), `ativo` (BIT) |
| `auditoria` | Log de auditoria | `ID`, `DATA_HORA`, `USUARIO`, `ACAO`, `TELA`, `DESCRICAO` |

### Migrations automáticas

O sistema verifica e aplica alterações de schema ao iniciar:

- Verifica existência de tabela com `OBJECT_ID(:NomeTabela)`
- Verifica existência de coluna com `INFORMATION_SCHEMA.COLUMNS`
- Exemplo de migration: adição da coluna `foto` (VarBinary MAX) na tabela `produtos`

---

## ⚙️ Requisitos para Rodar

| Requisito | Detalhe |
|---|---|
| **Sistema Operacional** | Windows (7/10/11, 32 ou 64 bits — binário é Win32) |
| **SQL Server** | SQL Server 2012 ou superior / SQL Server Express (gratuito) |
| **Delphi** (apenas para compilar) | RAD Studio com suporte a FireDAC, VCLTee e RLReport |
| **OpenSSL DLLs** | `libeay32.dll` e `ssleay32.dll` na pasta do executável (incluídas em `viacep-master/lib/`) |
| **Acesso de rede** | Para uso da API ViaCEP (https://viacep.com.br) — opcional |

---

## 🔧 Como Configurar o Ambiente

### 1. SQL Server

Instale o SQL Server Express (gratuito):
```
https://www.microsoft.com/pt-br/sql-server/sql-server-downloads
```

Crie um banco de dados vazio chamado `Vendas` (ou o nome que preferir — o sistema usa o `master` para se conectar inicialmente e depois troca para o banco configurado no INI).

### 2. Arquivo de configuração (`vendas.ini`)

Crie o arquivo `vendas.ini` na **mesma pasta** do executável `vendas.exe`:

**Autenticação Windows (recomendado):**
```ini
[DB]
Server=NOME_DO_SERVIDOR\SQLEXPRESS
DataBase=Vendas
Auth=Windows
```

**Autenticação SQL Server:**
```ini
[DB]
Server=NOME_DO_SERVIDOR\SQLEXPRESS
DataBase=Vendas
Auth=SQL
User=sa
Password=sua_senha
```

### 3. DLLs OpenSSL

Copie `libeay32.dll` e `ssleay32.dll` da pasta `viacep-master/lib/` para a pasta do executável.

### 4. Primeira execução

Ao executar pela primeira vez, o sistema cria automaticamente todas as tabelas necessárias no banco de dados informado.

---

## 🔨 Como Compilar o Projeto

1. Abra o Delphi RAD Studio
2. Abra o arquivo `vendas.dproj`
3. Certifique-se de que os seguintes componentes estão instalados:
   - **FireDAC** (nativo do Delphi)
   - **RLReport** (gerador de relatórios)
   - **RxLib** (`RxToolEdit`, `RxCurrEdit`, `RxPickDate`)
   - **VCLTee** (TeeChart — nativo do Delphi)
   - **PngBitBtn / PngSpeedButton**
4. Configure o target para **Win32 / Debug** ou **Win32 / Release**
5. Pressione `F9` ou **Run > Run** para compilar e executar

---

## 🔌 Como Conectar ao Banco

A conexão é gerenciada pelo DataModule `TdtmConexao` (`uDTMconexao.pas`), carregado automaticamente ao iniciar a aplicação:

```pascal
// Trecho do uDTMconexao.pas
Ini := TIniFile.Create(Path);
ConexaoDB.Params.DriverID := 'MSSQL';
ConexaoDB.Params.Values['Server']   := Ini.ReadString('DB','Server','');
ConexaoDB.Params.Values['Database'] := 'master';

if SameText(Auth, 'SQL') then
begin
  ConexaoDB.Params.Values['User_Name'] := Ini.ReadString('DB','User','');
  ConexaoDB.Params.Values['Password']  := Ini.ReadString('DB','Password','');
end
else
  ConexaoDB.Params.Values['OSAuthent'] := 'Yes'; // Windows Auth
```

Caso o arquivo `vendas.ini` não seja encontrado, o sistema lança uma exceção explicativa e interrompe a inicialização.

---

## 🖥 Principais Telas

### 🏠 Tela Principal (`uPrincipal`)
Dashboard central com menu de navegação e 4 gráficos TeeChart (barras, pizza ×2, linha rápida). Um `TTimer` atualiza os gráficos periodicamente. Exibe o nome do usuário logado na barra de status.

### 🔐 Login (`uLogin` / `uLogin.pas`)
Autenticação por usuário e senha. A senha é armazenada criptografada no banco e comparada após descriptografia pela classe `TUsuario.Logar()`. Após o login, o objeto `TUsuarioLogado` é repassado para todos os forms abertos.

### 👤 Cadastro de Clientes (`uCadCliente`)
Herda de `TfrmTelaHeranca`. Possui:
- Seleção de tipo de pessoa (Física/Jurídica) com alternância do label CPF/CNPJ
- Campo CEP com máscara e botão de consulta ViaCEP (preenchimento automático de endereço)
- Lookup de situação do cliente com indicadores visuais coloridos (ImageList)
- Checkbox "Sem Número" para endereços sem número
- Validação de CPF e CNPJ em tempo real

### 📦 Cadastro de Produtos (`uCadProduto`)
- Upload de foto do produto (BMP, JPG, PNG) com redimensionamento para 160×130px
- Vínculo a categoria e fornecedor
- Controle de quantidade em estoque
- Unidade de medida

### 🛒 Processo de Venda (`uProVenda`)
- Seleção de cliente via `TDBLookupComboBox` (filtra clientes ativos)
- Adição de produtos ao carrinho (`TClientDataSet` em memória)
- Cálculo automático de valor total do item (quantidade × valor unitário)
- Atualização do total geral da venda
- Botão de exportação Excel
- Ao gravar: baixa automática do estoque para cada item
- Ao cancelar/apagar: devolução automática do estoque

### 💰 Resumo Financeiro (`uResFinanceiro`)
Painel com KPIs: quantidade de produtos em estoque, valor total do estoque, quantidade/valor de vendas, lucro. Gráfico de linha com evolução do balanço por mês.

### 🤖 ChatBot (`uChatBot`)
Janela com ComboBox de perguntas pré-definidas. Ao enviar, executa queries SQL correspondentes e exibe a resposta com animação de digitação simulada via `TTimer`.

Perguntas disponíveis:
- Quantidade total do estoque
- Valor total do estoque
- Quantidade de usuários cadastrados
- Quantidade de clientes cadastrados
- Quantidade de fornecedores cadastrados
- Quantidade de vendas

### 🔑 Usuários vs Ações (`uUsuarioVsAcoes`)
Grid duplo: usuários à esquerda, permissões à direita. Duplo clique numa ação alterna o campo `ativo` entre 0 e 1 no banco, habilitando ou desabilitando o acesso daquele usuário àquela tela.

### 📋 Log de Auditoria (`uControleLog`)
Exibe a tabela `auditoria` com filtro dinâmico por coluna. Herda de `TfrmTelaHerancaConsulta`. Permite ordenação clicando no cabeçalho das colunas.

---

## 📐 Regras de Negócio

### Clientes
- Nome é campo obrigatório
- Situação do cliente é obrigatória (sem situação, não grava)
- CPF deve ter 11 dígitos e passar na validação do dígito verificador
- CNPJ deve ter 14 dígitos e passar na validação do dígito verificador
- CEP pode ser consultado automaticamente para preenchimento de endereço

### Fornecedores
- Nome é campo obrigatório
- CNPJ é campo obrigatório (fornecedor é sempre pessoa jurídica)
- CNPJ passa pela validação de dígito verificador

### Produtos
- Categoria e fornecedor são campos vinculados
- Estoque é gerenciado automaticamente via `TControleEstoque`
- Foto é opcional (armazenada como `VarBinary(MAX)` no banco)

### Vendas
- Ao inserir uma venda: baixa de estoque (`quantidade - qtdeBaixa`) para cada item, dentro de transação
- Ao apagar uma venda: exclui itens primeiro, depois o cabeçalho (`DELETE vendasItens` → `DELETE vendas`), dentro de transação com rollback em caso de falha
- O carrinho de itens usa `TClientDataSet` em memória (sem tocar o banco até o momento do Gravar)
- Verificação se item já existe na venda antes de inserir (evita duplicidade)

### Estoque
```
Baixar: UPDATE produtos SET quantidade = quantidade - :qtdeBaixa WHERE produtoId = :produtoId
Retornar: UPDATE produtos SET quantidade = quantidade + :qtdeRetorno WHERE produtoId = :produtoId
```
Ambas as operações são transacionadas individualmente com `StartTransaction / Commit / Rollback`.

### Controle de Acesso
- Cada form tem um `Name` único que serve como chave (`chave`) na tabela `acaoAcesso`
- Ao abrir qualquer form via `TFuncao.CriarForm()`, o sistema verifica em `usuariosAcaoAcesso` se o usuário logado tem a ação ativa
- Se não tiver permissão: exibe alerta e não abre o form

---

## ✅ Validações Implementadas

| Validação | Localização | Detalhe |
|---|---|---|
| CPF | `cValidar.pas` → `ValidarCPF()` | 11 dígitos, não todos iguais, cálculo dos 2 dígitos verificadores |
| CNPJ | `cValidar.pas` → `ValidarCNPJ()` | 14 dígitos, não todos iguais, cálculo dos 2 dígitos verificadores |
| Nome obrigatório (cliente) | `cCadCliente.pas` → `TCliente.Validar()` | `raise Exception` se vazio |
| Situação obrigatória (cliente) | `cCadCliente.pas` → `TCliente.Validar()` | `raise Exception` se `IDSituacao = 0` |
| Nome obrigatório (fornecedor) | `cFornecedor.pas` → `TFornecedor.Validar()` | `raise Exception` se vazio |
| CNPJ obrigatório (fornecedor) | `cFornecedor.pas` → `TFornecedor.Validar()` | `raise Exception` se vazio |
| CEP (ViaCEP) | `ViaCEP.Core.pas` → `Validate()` | Deve ter 8 dígitos numéricos |
| Chave de acesso única | `cAcaoAcesso.pas` → `ChaveExiste()` | Impede chaves duplicadas |
| Usuário existente | `cCadUsuario.pas` → `UsuarioExiste()` | Impede nome de usuário duplicado |
| Campos obrigatórios genéricos | `uTelaHeranca.pas` → `ExisteCampoObrigatorio()` | Varredura por componentes com tag especial |

---

## 🌐 Integrações Externas

### ViaCEP (`https://viacep.com.br`)

Integração para preenchimento automático de endereço a partir do CEP.

**Biblioteca:** `viacep-master/src/ViaCEP.Core.pas`

**Fluxo:**
1. Usuário digita o CEP no campo mascarado
2. Ao sair do campo (OnExit), o sistema chama a API
3. `TViaCEP.Get(cep)` faz `GET https://viacep.com.br/ws/{cep}/json`
4. Resposta JSON é desserializada em `TViaCEPClass`
5. Campos de endereço, bairro, cidade e estado são preenchidos automaticamente

**Dependências:** Indy (TIdHTTP + TIdSSLIOHandlerSocketOpenSSL) + OpenSSL DLLs

**Tratamento de erro:** CEP inválido retorna `"erro": true` → exibe `Exception` ao usuário

---

## 🎨 Padrões Utilizados

### Herança de Forms (Base Form Pattern)
Todas as telas de CRUD herdam de `TfrmTelaHeranca`, que implementa:
- `PageControl` com abas Listagem / Manutenção
- `DBGrid` com ordenação dinâmica ao clicar no cabeçalho
- Pesquisa dinâmica por qualquer coluna (monta WHERE dinamicamente)
- Controle de estado dos botões (Novo/Alterar/Cancelar/Gravar/Apagar)
- Persistência de largura das colunas do Grid em arquivo INI (`PreferenciasGrid.ini`)
- Alternância de cores nas linhas do Grid (zebra)
- Navegação por Enter entre campos

### Classe de Negócio (Business Object Pattern)
Cada entidade tem uma classe correspondente em `Classes/`:
- `constructor Create(aConexao: TFDConnection)` — recebe a conexão por injeção
- Métodos `Inserir`, `Atualizar`, `Apagar`, `Selecionar`
- Método `Validar` privado chamado antes de persistir
- Método `Limpar` que zera todos os campos
- Uso de `StartTransaction / Commit / Rollback` em cada operação

### Factory de Forms com Controle de Acesso
`TFuncao.CriarForm()` centraliza a abertura de todos os forms, verificando permissão antes de exibir:
```pascal
class procedure TFuncao.CriarForm(aNomeForm: TFormClass;
  oUsuarioLogado: TUsuarioLogado; aConexao: TFDConnection);
```

### Configuração via INI
`TArquivoIni` centraliza leitura e escrita de configurações. Usado tanto para conexão (`vendas.ini`) quanto para preferências de grid (`PreferenciasGrid.ini`, `PreferenciasGridConsulta.ini`, `PreferenciasGridVendas.ini`).

---

## 🔒 Criptografia

Implementada em `uFuncaoCriptografia.pas`:

- **Algoritmo:** Caesar cipher customizado — inverte a string e soma/subtrai 6 ao código ASCII de cada caractere
- **Uso:** Senhas dos usuários armazenadas no banco de dados

---

## 🔑 Sistema de Permissões

O controle de acesso funciona em três camadas:

1. **`acaoAcesso`** — tabela com todas as telas/ações cadastradas (chave = `Name` do Form Delphi)
2. **`usuariosAcaoAcesso`** — relacionamento usuário × ação com campo `ativo` (BIT)
3. **`TUsuarioLogado.TenhoAcesso()`** — consulta ao banco antes de cada abertura de form

```sql
SELECT usuarioId FROM usuariosAcaoAcesso
WHERE usuarioId = :usuarioId
  AND acaoAcessoId = (
    SELECT TOP 1 acaoAcessoId FROM acaoAcesso WHERE chave = :chave
  )
  AND ativo = 1
```

A classe `TAcaoAcesso.CriarAcoes()` popula automaticamente a tabela `acaoAcesso` com todos os forms do sistema.

---

## 📊 Relatórios

Todos os relatórios utilizam o componente **RLReport** e suportam exportação para:
- **PDF** (`TRLPDFFilter`)
- **XLS** (`TRLXLSFilter`)
- **XLSX** (`TRLXLSXFilter`)

| Relatório | Arquivo | Conteúdo |
|---|---|---|
| Listagem de Clientes | `uRelCadCliente` | Grid com todos os clientes |
| Ficha de Cliente | `uRelCadClienteFicha` | Dados completos de um cliente |
| Listagem de Produtos | `uRelCadProduto` | Grid com todos os produtos |
| Produtos por Categoria | `uRelCadProdutoComGrupoCategoria` | Agrupado por categoria |
| Listagem de Categorias | `uRelCategoria` | Grid de categorias |
| Vendas (completo) | `uRelProVenda` | Cabeçalho + itens por venda com subtotais |
| Vendas por Período | `uRelVendaPorData` | Filtro por data inicial/final |

---

## 📦 Dependências e Componentes Terceiros

| Componente | Uso | Origem |
|---|---|---|
| **RLReport** | Geração de relatórios PDF/XLS/XLSX | Rave Reports / FastReport compatível |
| **RxLib** | `RxToolEdit` (edição com botão), `RxCurrEdit` (moeda), `RxPickDate` (calendário) | RxLib open source |
| **VCLTee (TeeChart)** | Gráficos no dashboard e resumo financeiro | Embutido no Delphi |
| **Indy** | HTTP/HTTPS para ViaCEP | Embutido no Delphi |
| **PngBitBtn/PngSpeedButton** | Botões com imagem PNG | Terceiros |
| **OpenSSL** | TLS para HTTPS | `libeay32.dll` + `ssleay32.dll` (versão 1.x) |
| **Enter.pas** | Navegação por Enter no lugar de Tab | Terceiros |
| **DataSnap (TClientDataSet)** | Carrinho de itens em memória | Embutido no Delphi |
