unit uFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uEnum, cFornecedor, uDTMconexao, cValidar, IdSSLOpenSSL, IdHTTP, System.JSON, System.RegularExpressions;

type
  TfrmFornecedor = class(TfrmTelaHeranca)
    f1ListagemfornId: TFDAutoIncField;
    f2Listagemnome: TStringField;
    f2Listagemcnpj: TStringField;
    f2Listagemendereco: TStringField;
    f2Listagemtelefone: TStringField;
    f2Listagememail: TStringField;
    f2Listagemobservacao: TStringField;
    edtNome: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtTelefone: TEdit;
    lblTelefone: TLabel;
    edtEmail: TLabeledEdit;
    edtFornId: TLabeledEdit;
    edtCNPJ: TEdit;
    lblCnpj: TLabel;
    edtObservacao: TEdit;
    lblObservacao: TLabel;
    lblCEP: TLabel;
    edtBairro: TEdit;
    lblCEP1: TLabel;
    edtCidade: TEdit;
    lblCEP2: TLabel;
    edtEstado: TEdit;
    lblCEP3: TLabel;
    edtNumero: TEdit;
    lbl10: TLabel;
    f2Listagemnumero: TStringField;
    f2Listagembairro: TStringField;
    f2Listagemcidade: TStringField;
    f2Listagemestado: TStringField;
    f2Listagemcep: TStringField;
    mskCEP: TMaskEdit;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    procedure grdListagemDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCNPJChange(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskCEPChange(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    { Private declarations }
    oFornecedor: TFornecedor;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
    procedure CarregarItensSelecionados;
    function GetDesc: string; override;
    procedure PreencherEndereco(const CEP: string);
    function BuscarCEP(const CEP: string): TJSONObject;
  public
    { Public declarations }
    procedure LimparComponenteItem;
    function SomenteNumeros(const Texto:string):string;
  end;

var
  frmFornecedor: TfrmFornecedor;

implementation

uses uCadCliente, uCadProduto;

{$R *.dfm}

function TfrmFornecedor.SomenteNumeros(const Texto:string):string;
var
  I:Integer;
begin
  Result:='';

  for I:= 1 to Length(Texto) do
    if Texto[I] in ['0'..'9'] then
    Result:= Result+Texto[I];
end;

function TfrmFornecedor.GetDesc: string;
begin
  result := oFornecedor.nome;
end;

function TfrmFornecedor.Apagar: Boolean;
begin
  if oFornecedor.Selecionar(fdqryListagem.FieldByName('fornId').AsInteger) then begin
    result:=oFornecedor.Apagar;
  end;
end;

procedure TfrmFornecedor.CarregarItensSelecionados;
begin
  edtNome.Text :=      fdqryListagem.FieldByName('nome').AsString;
  edtTelefone.Text:=   fdqryListagem.FieldByName('telefone').AsString;
  edtCnpj.Text:=       fdqryListagem.FieldByName('cnpj').AsString;
  edtFornId.Text :=    fdqryListagem.FieldByName('fornId').AsString;
  edtEmail.Text:=      fdqryListagem.FieldByName('email').AsString;
  edtEndereco.Text:=   fdqryListagem.FieldByName('endereco').AsString;
  edtObservacao.Text:= fdqryListagem.FieldByName('observacao').AsString;
  edtNumero.Text :=    fdqryListagem.FieldByName('numero').AsString;
  edtBairro.Text :=    fdqryListagem.FieldByName('bairro').AsString;
  edtCidade.Text :=    fdqryListagem.FieldByName('cidade').AsString;
  edtEstado.Text :=    fdqryListagem.FieldByName('estado').AsString;
  mskCEP.Text :=       fdqryListagem.FieldByName('cep').AsString;
end;

procedure TfrmFornecedor.grdListagemDblClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('fornId').AsInteger = 0 then begin
    Exit;
  end;

  inherited;
  CarregarItensSelecionados;
end;

procedure TfrmFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
    oFornecedor:=TFornecedor.Create(dtmConexao.ConexaoDB);
    IndiceAtual:='nome';
end;

procedure TfrmFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  fdqryListagem.Open;
end;

function TfrmFornecedor.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtFornId.Text<>EmptyStr then
     oFornecedor.codigo:=StrToInt(edtFornId.Text)
  else
     oFornecedor.codigo:=0;

  oFornecedor.nome                   :=edtNome.Text;
  oFornecedor.endereco               :=edtEndereco.Text;
  oFornecedor.telefone               :=edtTelefone.Text;
  oFornecedor.email                  :=edtEmail.Text;
  oFornecedor.cnpj                   :=edtCnpj.Text;
  oFornecedor.observacao             :=edtObservacao.Text;
  oFornecedor.numero                 := edtNumero.Text;
  oFornecedor.bairro                 := edtBairro.Text;
  oFornecedor.cidade                 := edtCidade.Text;
  oFornecedor.estado                 := edtEstado.Text;
  oFornecedor.cep                    := mskCEP.Text;

  if (EstadoDoCadastro=ecInserir) then
    result:=oFornecedor.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
    result:=oFornecedor.Atualizar;
    limparComponenteitem;
end;

procedure TfrmFornecedor.LimparComponenteItem;
begin
  edtNome.Text := '';
  edtEndereco.Text := '';
  edtTelefone.Text := '';
  edtEmail.Text := '';
  edtCnpj.Text := '';
  edtObservacao.Text := '';
  edtNumero.Text := '';
  edtNumero.Text := '';
  edtBairro.Text := '';
  edtCidade.Text := '';
  edtEstado.Text := '';
  mskCEP.Text := '';
end;

procedure TfrmFornecedor.btnAlterarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('fornId').AsInteger = 0 then begin
    Exit;
  end;

  if oFornecedor.Selecionar(fdqryListagem.FieldByName('fornId').AsInteger) then begin
     edtFornId.Text:= IntToStr(oFornecedor.codigo);

     edtNome.Text:=       oFornecedor.nome;
     edtEndereco.Text:=   oFornecedor.endereco;
     edtTelefone.Text:=   oFornecedor.telefone;
     edtEmail.Text:=      oFornecedor.email;
     edtCnpj.Text:=       oFornecedor.cnpj;
     edtObservacao.Text:= oFornecedor.observacao;
     edtNumero.Text:=     oFornecedor.numero;
     edtBairro.Text:=     oFornecedor.bairro;
     edtCidade.Text:=     oFornecedor.cidade;
     edtEstado.Text:=     oFornecedor.estado;
     mskCEP.Text :=       oFornecedor.cep;

  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;

end;

procedure TfrmFornecedor.btnApagarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('fornId').AsInteger = 0 then begin
    Exit;
  end;
  inherited;
end;

procedure TfrmFornecedor.btnGravarClick(Sender: TObject);
var Email: string;
begin
  Email := Trim(edtEmail.Text);

  if not cValidar.ValidarCNPJ(edtCnpj.Text) then
  begin
    ShowMessage('CNPJ Inválido');
    Exit;
  end;

  if not TRegEx.IsMatch(Email, '^[^@\s]{2,}@[^@\s]{5,}.[^@\s]{2,}$') then
  begin
    ShowMessage('Informe um e-mail válido');
    edtEmail.SetFocus;
    Exit;
  end;

  if Trim(edtNumero.Text) = '' then begin
    ShowMessage('Preencha o Número');
    Exit;
  end;

  if Trim(edtTelefone.Text) = '' then begin
    ShowMessage('Preencha o Telefone');
    Exit;
  end;

inherited;
end;

procedure TfrmFornecedor.mskCEPChange(Sender: TObject);
var CEP: string;
begin
  inherited;
  CEP:= SomenteNumeros(mskCEP.Text);

  if Length(CEP) = 8 then begin
   lbl12.Visible := False;
   lbl13.Visible := False;
   lbl14.Visible := False;
   lbl15.Visible := False;
   PreencherEndereco(mskCEP.Text);
  end
  else begin
   lbl12.Visible := True;
   lbl13.Visible := True;
   lbl14.Visible := True;
   lbl15.Visible := True;
  end;
end;

procedure TfrmFornecedor.edtCNPJChange(Sender: TObject);
var
  Texto, N: string;
  PosCursor: Integer;
begin
  PosCursor := edtCnpj.SelStart;

  edtCnpj.OnChange := nil;
  try
    N := SomenteNumeros(edtCnpj.Text);
    Texto := N;

    if Length(N) <= 14 then
    begin
      if Length(N) > 2 then Texto := Copy(N,1,2) + '.' + Copy(N,3,Length(N)-2);
      if Length(N) > 5 then Texto := Copy(N,1,2) + '.' + Copy(N,3,3) + '.' + Copy(N,6,Length(N)-5);
      if Length(N) > 8 then Texto := Copy(N,1,2) + '.' + Copy(N,3,3) + '.' + Copy(N,6,3) + '/' + Copy(N,9,Length(N)-8);
      if Length(N) > 12 then Texto := Copy(N,1,2) + '.' + Copy(N,3,3) + '.' + Copy(N,6,3) + '/' + Copy(N,9,4) + '-' + Copy(N,13,Length(N)-12);
    end;
    edtCnpj.Text := Texto;
    edtCnpj.SelStart := Length(Texto);
  finally
    edtCnpj.OnChange := edtCnpjChange;
  end;
end;

function TfrmFornecedor.BuscarCEP(const CEP: string): TJSONObject;
var IdHTTP: TIdHTTP; SSL: TIdSSLIOHandlerSocketOpenSSL; Response: string; CEPLimpo: string;
begin
  Result := nil;
  CEPLimpo := SomenteNumeros(CEP);
  if Length(CEPLimpo) <> 8 then
    Exit;

  IdHTTP := TIdHTTP.Create(nil);
  SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode := sslmClient;

    IdHTTP.IOHandler := SSL;

    Response := IdHTTP.Get('https://viacep.com.br/ws/' + CEPLimpo + '/json/');
    Result := TJSONObject.ParseJSONValue(Response) as TJSONObject;
  finally
    SSL.Free;
    IdHTTP.Free;
  end;
end;

procedure TfrmFornecedor.PreencherEndereco(const CEP: string);
var JSON: TJSONObject;
begin
  JSON := BuscarCEP(CEP);

  if Assigned(JSON) then
  try
    if JSON.GetValue('erro') <> nil then
    begin
      edtEndereco.Clear;
      edtBairro.Clear;                              //se o CEP não for encontrado
      edtCidade.Clear;
      edtEstado.Clear;

      edtEndereco.ReadOnly := False;
      edtEstado.ReadOnly := False;
      edtBairro.ReadOnly := False;
      edtCidade.ReadOnly := False;

      ShowMessage('CEP inválido!');
      Exit;
    end;

    edtEndereco.Text := JSON.GetValue('logradouro').Value;
    edtBairro.Text   := JSON.GetValue('bairro').Value;       //se o CEP for encontrado
    edtCidade.Text   := JSON.GetValue('localidade').Value;
    edtEstado.Text   := JSON.GetValue('uf').Value;

    edtEndereco.ReadOnly := True;
    edtEstado.ReadOnly := True;
    edtBairro.ReadOnly := True;
    edtCidade.ReadOnly := True;

  finally
    JSON.Free;
  end
  else
  begin
    ShowMessage('Não foi possível consultar o CEP.');

    edtEndereco.ReadOnly := False;
    edtEstado.ReadOnly := False;
    edtBairro.ReadOnly := False;
    edtCidade.ReadOnly := False;
  end;
end;

procedure TfrmFornecedor.edtTelefoneChange(Sender: TObject);
var Texto: string;
begin
  inherited;
begin
  Texto := edtTelefone.Text;


  Texto := SomenteNumeros(edtTelefone.Text);

  if Texto = '' then Exit;
                                //SE a primeira casinha for 0 é 0800

  if (Texto[1] = '0') and (Texto[3] = '0') and (Texto[4] = '0') then
  begin
    if Length(Texto) <= 4 then
      edtTelefone.Text := Copy(Texto, 1, Length(Texto))
    else if Length(Texto) <= 7 then
      edtTelefone.Text := Copy(Texto,1,4) + ' ' + Copy(Texto,5,3)
    else
      edtTelefone.Text := Copy(Texto,1,4) + ' ' + Copy(Texto,5,3) + ' ' + Copy(Texto,8,4);

    edtTelefone.SelStart := Length(edtTelefone.Text);
  end
  else
  begin
    if Length(Texto) <= 10 then
    begin
      if Length(Texto) <= 2 then
        edtTelefone.Text := '(' + Copy(Texto,1,Length(Texto))
      else if Length(Texto) <= 6 then
        edtTelefone.Text := '(' + Copy(Texto,1,2) + ')' + Copy(Texto,3,Length(Texto)-2)
      else
        edtTelefone.Text := '(' + Copy(Texto,1,2) + ')' + Copy(Texto,3,4) + '-' + Copy(Texto,7,Length(Texto)-6);
    end
  else
    begin
    edtTelefone.MaxLength:= 14;
      edtTelefone.Text := '(' + Copy(Texto,1,2) + ')' + Copy(Texto,3,5) + '-' + Copy(Texto,8,Length(Texto)-7);
    end;
  end;

  edtTelefone.SelStart := Length(edtTelefone.Text);
end;
end;
end.

