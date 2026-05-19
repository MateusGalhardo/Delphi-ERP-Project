unit cAtualizacaoTabelaMSSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  cAtualizacaoBancoDeDados, cCadUsuario;

type
  TAtualizacaoTableMSSQL = class(TAtualizaBancoDados)

  private
    function TabelaExiste(aNomeTabela: String): Boolean;

    procedure Categorias;
    procedure Situacao;
    procedure Cliente;
    procedure Produtos;
    procedure vendasItens;
    procedure Vendas;
    procedure Usuario;
    procedure AcaoAcesso;
    procedure UsuariosAcaoAcesso;
    procedure Fornecedor;
    procedure Perfil;
    procedure Auditoria;

  public
    constructor Create(aConexao: TFDConnection);
    destructor Destroy; override;
  end;

implementation

{ TAtualizacaoTableMSSQL }

constructor TAtualizacaoTableMSSQL.Create(aConexao: TFDConnection);
begin
  ConexaoDB := aConexao;

  Categorias;
  Situacao;
  AcaoAcesso;
  Perfil;
  Fornecedor;
  Auditoria;
  Cliente;
  Usuario;
  Produtos;
  Vendas;
  vendasItens;
  UsuariosAcaoAcesso;
end;

destructor TAtualizacaoTableMSSQL.Destroy;
begin
  inherited;
end;

function TAtualizacaoTableMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
var
  Qry: TFDQuery;
begin
  Result := False;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := ConexaoDB;

    Qry.SQL.Text :=
      'SELECT OBJECT_ID(:NomeTabela) AS ID';

    Qry.ParamByName('NomeTabela').AsString := aNomeTabela;

    Qry.Open;

    Result := Qry.FieldByName('ID').AsInteger > 0;

  finally
    Qry.Free;
  end;
end;

procedure TAtualizacaoTableMSSQL.Categorias;
begin
  if not TabelaExiste('categorias') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE categorias ( ' +
      ' categoriaId INT IDENTITY(1,1) NOT NULL, ' +
      ' descricao VARCHAR(30) NULL, ' +
      ' PRIMARY KEY (categoriaId) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Situacao;
begin
  if not TabelaExiste('situacao') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE situacao ( ' +
      ' IDSituacao INT IDENTITY(1,1) PRIMARY KEY, ' +
      ' SituacaoCliente VARCHAR(20) ' +
      ')'
    );

    ExecutaDiretoBancoDeDados(
      'INSERT INTO situacao (SituacaoCliente) VALUES ' +
      '(''ATIVO''), ' +
      '(''BLOQUEADO''), ' +
      '(''ATENÇÃO''), ' +
      '(''INATIVO''), ' +
      '(''PROSPECTO'')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Cliente;
begin
  if not TabelaExiste('clientes') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE clientes ( ' +
      ' clienteId INT IDENTITY(1,1) NOT NULL, ' +
      ' nome VARCHAR(60) NULL, ' +
      ' documento VARCHAR(18) NOT NULL UNIQUE, ' +
      ' endereco VARCHAR(60) NULL, ' +
      ' cidade VARCHAR(50) NULL, ' +
      ' bairro VARCHAR(40) NULL, ' +
      ' estado VARCHAR(2) NULL, ' +
      ' cep VARCHAR(10) NULL, ' +
      ' telefone VARCHAR(14) NULL, ' +
      ' email VARCHAR(100) NULL, ' +
      ' dataNascimento DATETIME NULL, ' +
      ' IDSituacao INT NULL, ' +
      ' observacao VARCHAR(255) NULL, ' +
      ' casa VARCHAR(5) NULL, ' +
      ' PRIMARY KEY (clienteId), ' +
      ' CONSTRAINT FK_ClienteSituacao ' +
      ' FOREIGN KEY (IDSituacao) REFERENCES situacao(IDSituacao) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Fornecedor;
begin
  if not TabelaExiste('fornecedor') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE fornecedor ( ' +
      ' fornId INT IDENTITY(1,1) PRIMARY KEY, ' +
      ' nome VARCHAR(50), ' +
      ' cnpj VARCHAR(18), ' +
      ' endereco VARCHAR(100), ' +
      ' numero VARCHAR(10), ' +
      ' bairro VARCHAR(50), ' +
      ' cidade VARCHAR(50), ' +
      ' estado VARCHAR(3), ' +
      ' cep VARCHAR(10), ' +
      ' telefone VARCHAR(15), ' +
      ' email VARCHAR(50), ' +
      ' observacao VARCHAR(200) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Produtos;
begin
  if not TabelaExiste('produtos') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE produtos ( ' +
      ' produtoId INT IDENTITY(1,1) NOT NULL, ' +
      ' fornId INT NULL, ' +
      ' nome VARCHAR(60) NULL, ' +
      ' descricao VARCHAR(255) NULL, ' +
      ' valor DECIMAL(18,5) DEFAULT 0.00000 NULL, ' +
      ' quantidade DECIMAL(18,5) DEFAULT 0.00000 NULL, ' +
      ' categoriaId INT NULL, ' +
      ' DataProduto DATETIME NULL DEFAULT GETDATE(), ' +
      ' foto VARBINARY(MAX) NULL, ' +

      ' PRIMARY KEY (produtoId), ' +

      ' CONSTRAINT FK_ProdutosCategorias ' +
      ' FOREIGN KEY (categoriaId) REFERENCES categorias(categoriaId), ' +

      ' CONSTRAINT FK_ProdutosFornecedor ' +
      ' FOREIGN KEY (fornId) REFERENCES fornecedor(fornId) ' +

      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Vendas;
begin
  if not TabelaExiste('vendas') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE vendas ( ' +
      ' vendaId INT IDENTITY(1,1) NOT NULL, ' +
      ' clienteId INT NOT NULL, ' +
      ' dataVenda DATETIME DEFAULT GETDATE(), ' +
      ' totalVenda DECIMAL(18,5) DEFAULT 0.00000, ' +
      ' PRIMARY KEY (vendaId), ' +
      ' CONSTRAINT FK_VendasClientes ' +
      ' FOREIGN KEY (clienteId) REFERENCES clientes(clienteId) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.vendasItens;
begin
  if not TabelaExiste('vendasItens') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE vendasItens ( ' +
      ' vendaId INT NOT NULL, ' +
      ' produtoId INT NOT NULL, ' +
      ' valorUnitario DECIMAL(18,5) DEFAULT 0.00000, ' +
      ' quantidade DECIMAL(18,5) DEFAULT 0.00000, ' +
      ' totalProduto DECIMAL(18,5) DEFAULT 0.00000, ' +

      ' PRIMARY KEY (vendaId, produtoId), ' +

      ' CONSTRAINT FK_VendasItensVenda ' +
      ' FOREIGN KEY (vendaId) REFERENCES vendas(vendaId), ' +

      ' CONSTRAINT FK_VendasItensProdutos ' +
      ' FOREIGN KEY (produtoId) REFERENCES produtos(produtoId) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.AcaoAcesso;
begin
  if not TabelaExiste('acaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE acaoAcesso ( ' +
      ' acaoAcessoId INT IDENTITY(1,1) NOT NULL, ' +
      ' descricao VARCHAR(100) NOT NULL, ' +
      ' chave VARCHAR(60) NOT NULL UNIQUE, ' +
      ' PRIMARY KEY (acaoAcessoId) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Perfil;
begin
  if not TabelaExiste('perfil') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE perfil ( ' +
      ' perfilId INT IDENTITY(1,1) PRIMARY KEY, ' +
      ' descricao VARCHAR(50) ' +
      ')'
    );

    ExecutaDiretoBancoDeDados(
      'INSERT INTO perfil (descricao) VALUES ' +
      '(''Estoquista''), ' +
      '(''ADM''), ' +
      '(''Vendedor'')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Usuario;
var
  oUsuario: TUsuario;
begin
  if not TabelaExiste('usuarios') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE usuarios ( ' +
      ' usuarioId INT IDENTITY(1,1) NOT NULL, ' +
      ' nome VARCHAR(50) NOT NULL, ' +
      ' senha VARCHAR(40) NOT NULL, ' +
      ' perfilId INT NULL, ' +

      ' PRIMARY KEY (usuarioId), ' +

      ' CONSTRAINT FK_UsuariosPerfil ' +
      ' FOREIGN KEY (perfilId) REFERENCES perfil(perfilId) ' +
      ')'
    );

    ExecutaDiretoBancoDeDados(
      'INSERT INTO usuarios (nome, senha, perfilId) VALUES ' +
      '(''Estoquista'', ''454'', 1), ' +
      '(''Vendedor'', ''12312'', 3)'
    );
  end;

  oUsuario := TUsuario.Create(ConexaoDB);
  try
    oUsuario.nome := 'Admin';
    oUsuario.senha := '123';
    oUsuario.perfilId := 1;

    if not oUsuario.UsuarioExiste(oUsuario.nome) then
      oUsuario.Inserir;

  finally
    oUsuario.Free;
  end;
end;

procedure TAtualizacaoTableMSSQL.UsuariosAcaoAcesso;
begin
  if not TabelaExiste('usuariosAcaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE usuariosAcaoAcesso ( ' +
      ' usuarioId INT NOT NULL, ' +
      ' acaoAcessoId INT NOT NULL, ' +
      ' ativo BIT NOT NULL DEFAULT 1, ' +

      ' PRIMARY KEY (usuarioId, acaoAcessoId), ' +

      ' CONSTRAINT FK_UsuarioAcaoAcessoUsuario ' +
      ' FOREIGN KEY (usuarioId) REFERENCES usuarios(usuarioId), ' +

      ' CONSTRAINT FK_UsuarioAcaoAcessoAcaoAcesso ' +
      ' FOREIGN KEY (acaoAcessoId) REFERENCES acaoAcesso(acaoAcessoId) ' +
      ')'
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Auditoria;
begin
  if not TabelaExiste('AUDITORIA') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE AUDITORIA ( ' +
      ' ID INT IDENTITY(1,1) PRIMARY KEY, ' +
      ' DATA_HORA DATETIME, ' +
      ' USUARIO VARCHAR(50), ' +
      ' ACAO VARCHAR(50), ' +
      ' TELA VARCHAR(50), ' +
      ' DESCRICAO VARCHAR(255) ' +
      ')'
    );
  end;
end;

end.
