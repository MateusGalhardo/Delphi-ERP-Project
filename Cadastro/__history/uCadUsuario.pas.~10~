unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cCadUsuario, uEnum,
  uDTMconexao, cAcaoAcesso;

type
  TfrmCadUsuario = class(TfrmTelaHeranca)
    f1ListagemusuarioID: TFDAutoIncField;
    f2Listagemnome: TStringField;
    f2Listagemsenha: TStringField;
    edtUsuarioId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    btnExibir: TSpeedButton;
    btnAleatorio: TSpeedButton;
    lbl1: TLabel;
    lkpFuncao: TDBLookupComboBox;
    QryFuncao: TFDQuery;
    dsFuncao: TDataSource;
    f1QryFuncaoperfilId: TFDAutoIncField;
    f2QryFuncaodescricao: TStringField;
    lbl2: TLabel;
    intgrfldListagemperfilId: TIntegerField;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAleatorioClick(Sender: TObject);
    procedure btnExibirClick(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
    oUsuario: TUsuario;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
    function GetDesc: string; override;
    function GerarSenha(Tamanho: Integer): string;
    procedure AplicarFuncoes(AUsuarioId, APerfilId: Integer);
    procedure RetornarInfos;
  public
    { Public declarations }
  end;

var
  frmCadUsuario: TfrmCadUsuario;

implementation

uses
  uPrincipal, uFuncaoCriptografia;

{$R *.dfm}

{ TfrmCadUsuario }

function TfrmCadUsuario.Apagar: Boolean;
begin
  if oUsuario.Selecionar(fdqryListagem.FieldByName('usuarioID').AsInteger) then
  begin
    result := oUsuario.Apagar;
  end;
end;

function TfrmCadUsuario.GetDesc: string;
begin
  result := oUsuario.nome;
end;

procedure TfrmCadUsuario.btnAleatorioClick(Sender: TObject);
begin
  inherited;
  edtSenha.Text := GerarSenha(10);
end;

function TfrmCadUsuario.GerarSenha(Tamanho: Integer): string;
const
  Caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*';
var
  i, Posicao: Integer;
begin
  Result := '';
  for i := 1 to Tamanho do
  begin
    Posicao := Random(Length(Caracteres)) + 1;
    Result := Result + Caracteres[Posicao];
  end;
end;

procedure TfrmCadUsuario.btnAlterarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('usuarioId').AsInteger = 0 then begin
    Exit;
  end;

  if oUsuario.Selecionar(fdqryListagem.FieldByName('usuarioID').AsInteger) then
  begin
    edtUsuarioId.Text := IntToStr(oUsuario.codigo);
    edtNome.Text := oUsuario.nome;
    edtSenha.Text := oUsuario.senha;
    oUsuario.senha := edtSenha.Text;

  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  RetornarInfos;
  EstadoDoCadastro := ecAlterar;
  fdqryListagem.Refresh;
  inherited;

end;

procedure TfrmCadUsuario.btnApagarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('usuarioId').AsInteger = 0 then begin
    Exit;
  end;

  if fdqryListagem.FieldByName('usuarioId').AsInteger < 4 then begin
    ShowMessage('Esse usuário não pode ser deletado');
    Abort;
  end;
  inherited;
end;

procedure TfrmCadUsuario.btnExibirClick(Sender: TObject);
begin
  inherited;
  if edtSenha.PasswordChar = '*' then
  begin
    edtSenha.PasswordChar := #0;
    btnExibir.Caption := '🔓'
  end
  else
  begin
    edtSenha.PasswordChar := '*';
    btnExibir.Caption := '🔒'
  end;
end;

procedure TfrmCadUsuario.btnGravarClick(Sender: TObject);
var
  PerfilId: Integer;
begin
  if (EstadoDoCadastro = ecInserir) and oUsuario.UsuarioExiste(edtNome.Text) then
  begin
    MessageDlg('Usuário ja cadastrado', mtInformation, [mbok], 0);
    edtNome.SetFocus;
    Abort;
  end;

  if edtUsuarioId.Text <> EmptyStr then
    oUsuario.codigo := StrToInt(edtUsuarioId.Text)
  else
    oUsuario.codigo := 0;

  oUsuario.nome := edtNome.Text;
  oUsuario.senha := edtSenha.Text;
  oUsuario.perfilId := lkpFuncao.KeyValue;

  if VarIsNull(lkpFuncao.KeyValue) then
    PerfilId := 0
  else
    PerfilId := lkpFuncao.KeyValue;

    inherited;
end;

procedure TfrmCadUsuario.AplicarFuncoes(AUsuarioId, APerfilId: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := dtmConexao.ConexaoDB;

    dtmConexao.ConexaoDB.StartTransaction;
    try
      if lkpFuncao.text = 'Estoquista' then
      begin
        Qry.SQL.Text := 'DELETE FROM usuariosAcaoAcesso WHERE usuarioId = :usuarioId; ' +
       ' INSERT INTO usuariosAcaoAcesso (usuarioId, acaoAcessoId, ativo) ' +
       'SELECT :usuarioId, acaoAcessoId, ativo ' + 'FROM usuariosAcaoAcesso ' +
       'WHERE usuarioId = 1'; //estoquista

        Qry.ParamByName('usuarioId').AsInteger := AUsuarioId;
      end;

      if lkpFuncao.Text = 'ADM' then
      begin
        Qry.SQL.Text := 'DELETE FROM usuariosAcaoAcesso WHERE usuarioId = :usuarioId; ' +
        ' INSERT INTO usuariosAcaoAcesso (usuarioId, acaoAcessoId, ativo) ' +
        'SELECT :usuarioId, acaoAcessoId, ativo ' + 'FROM usuariosAcaoAcesso ' +
        'WHERE usuarioId = 3'; //admin

        Qry.ParamByName('usuarioId').AsInteger := AUsuarioId;
      end;

      if lkpFuncao.Text = 'Vendedor' then
      begin
        Qry.SQL.Text := 'DELETE FROM usuariosAcaoAcesso WHERE usuarioId = :usuarioId; ' +
         'INSERT INTO usuariosAcaoAcesso (usuarioId, acaoAcessoId, ativo) ' +
         'SELECT :usuarioId, acaoAcessoId, ativo ' +
         'FROM usuariosAcaoAcesso ' +
         'WHERE usuarioId = 2'; //vendedor

        Qry.ParamByName('usuarioId').AsInteger := AUsuarioId;
      end;

      Qry.ExecSQL;

      dtmConexao.ConexaoDB.Commit;
    except
      dtmConexao.ConexaoDB.Rollback;
      raise;
    end;

  finally
    Qry.Free;
  end;
end;

procedure TfrmCadUsuario.RetornarInfos;
begin
  edtUsuarioId.Text := fdqryListagem.FieldByName('usuarioId').AsString;
  edtNome.Text := fdqryListagem.FieldByName('nome').AsString;
  edtSenha.Text := Descriptografar(fdqryListagem.FieldByName('senha').AsString);
  lkpFuncao.KeyValue := fdqryListagem.FieldByName('perfilId').AsInteger;
  oUsuario.perfilId := fdqryListagem.FieldByName('perfilId').AsInteger;
end;

procedure TfrmCadUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
    FreeAndNil(oUsuario);
end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(dtmConexao.ConexaoDB);
  IndiceAtual := 'nome';
  QryFuncao.Active := True;
end;

function TfrmCadUsuario.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
var perfilId: Integer;
begin
  Result := False;

  if EstadoDoCadastro = ecInserir then
    Result := oUsuario.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result := oUsuario.Atualizar
  else
    Exit;

  if VarIsNull(lkpFuncao.KeyValue) then
    perfilId := 0
  else
    perfilId := lkpFuncao.KeyValue;

  if perfilId > 0 then
    AplicarFuncoes(oUsuario.codigo, perfilId);

  TAcaoAcesso.PreencherUsuariosVsAcoes(dtmConexao.ConexaoDB);
end;

procedure TfrmCadUsuario.grdListagemDblClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('usuarioId').AsInteger = 0 then begin
    Exit;
  end;

  RetornarInfos;
  inherited;
end;

end.

