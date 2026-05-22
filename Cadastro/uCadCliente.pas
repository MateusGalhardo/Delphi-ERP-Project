unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, RxToolEdit, cCadCliente, uEnum, uDtmConexao, System.ImageList, Vcl.ImgList, cValidar,
  System.JSON, System.Net.HttpClient, System.Net.URLClient, IdHTTP, IdSSLOpenSSL, Vcl.Imaging.pngimage, DateUtils, System.RegularExpressions;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtCEP: TMaskEdit;
    edtTelefone: TEdit;
    dtpDataNascimento: TDateTimePicker;
    cbbPessoa: TComboBox;
    lblPessoa: TLabel;
    edtDoc: TEdit;
    lblDoc: TLabel;
    lkpStatus: TDBLookupComboBox;
    QryStatus: TFDQuery;
    dsStatus: TDataSource;
    f1ListagemclienteId: TFDAutoIncField;
    f2Listagemnome: TStringField;
    f2Listagemdocumento: TStringField;
    intgrfldListagemIDSituacao: TIntegerField;
    f2Listagemendereco: TStringField;
    f2Listagemcidade: TStringField;
    f2Listagembairro: TStringField;
    f2Listagemestado: TStringField;
    f2Listagemcep: TStringField;
    f2Listagemtelefone: TStringField;
    f2Listagememail: TStringField;
    fdqryListagemdataNascimento: TSQLTimeStampField;
    f1QryStatusIDSituacao: TFDAutoIncField;
    f2QryStatusSituacaoCliente: TStringField;
    lblStatus: TLabel;
    imagemStatus: TImageList;
    edtEstado: TLabeledEdit;
    edtObservacao: TEdit;
    lblObs: TLabel;
    f2Listagemobservacao: TStringField;
    lbl4: TLabel;
    pnlLegenda: TPanel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    img1: TImage;
    img3: TImage;
    img5: TImage;
    edtCasa: TEdit;
    lbl10: TLabel;
    f2Listagemcasa: TStringField;
    img6: TImage;
    img4: TImage;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    chkSemNumero: TCheckBox;
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure cbbPessoaChange(Sender: TObject);
    procedure edtDocChange(Sender: TObject);
    procedure edtTelefoneChange(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnGravarClick(Sender: TObject);
    procedure lkpStatusCloseUp(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCEPChange(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure edtTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure edtDocKeyPress(Sender: TObject; var Key: Char);
    procedure chkSemNumeroClick(Sender: TObject);
  private
    { Private declarations }
    oCliente:TCliente;
    LinhaZebrada: Integer;
    function Apagar:Boolean; override;
    function GetDesc:string; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
    procedure LimparComponenteItem;
    procedure PreencherEndereco(const CEP: string);
    procedure DefinirTipoPessoaPeloDocumento(const ADoc: string);
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

uses
  cUsuarioLogado, cFuncao, uAlterarSenha, uLogin, uPrincipal, uCadUsuario;

{$R *.dfm}

{$region 'Override'}
function TfrmCadCliente.Apagar: Boolean;
var Qry: TFDQuery;
begin
  Result := False;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := dtmConexao.ConexaoDB;

    Qry.SQL.Text :=
      'SELECT TOP 1 vendaId ' +
      'FROM vendas ' +                           //procura no banco se o cliente tiver vendas feitas
      'WHERE clienteId = :clienteId';

    Qry.ParamByName('clienteId').AsInteger := fdqryListagem.FieldByName('clienteId').AsInteger;

    Qry.Open;

    if not Qry.IsEmpty then                 //se tiver mostra a mensagem
    begin
      MessageDlg('Não é possível excluir este cliente pois ele possui vendas cadastradas', mtWarning, [mbOK], 0);
      Abort;
    end;

  finally
    Qry.Free;
  end;

  if oCliente.Selecionar(fdqryListagem.FieldByName('clienteId').AsInteger) then begin
     Result:=oCliente.Apagar;
  end;
end;

function TfrmCadCliente.GetDesc: string;
begin
  Result := oCliente.nome;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if Trim(edtClienteId.Text) = '' then
     oCliente.codigo := 0
  else
     oCliente.codigo:=StrToInt(edtClienteId.Text);

  oCliente.nome           :=edtNome.Text;
  oCliente.documento      :=edtDoc.Text;
  oCliente.IDSituacao     :=lkpStatus.KeyValue;
  oCliente.cep            :=edtCEP.Text;
  oCliente.casa           :=edtCasa.Text;
  oCliente.estado         :=edtEstado.Text;
  oCliente.endereco       :=edtEndereco.Text;
  oCliente.observacao     :=edtObservacao.Text;
  oCliente.bairro         :=edtBairro.Text;
  oCliente.cidade         :=edtCidade.Text;
  oCliente.telefone       :=edtTelefone.Text;
  oCliente.email          :=edtEmail.Text;
  oCliente.dataNascimento :=dtpDataNascimento.Date;

  if (EstadoDoCadastro=ecInserir) then
     Result:=oCliente.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
     Result:=oCliente.Atualizar;
end;

procedure TfrmCadCliente.grdListagemDblClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('clienteId').AsInteger = 0 then begin
    Exit;
  end;
  inherited;
end;

procedure TfrmCadCliente.grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
State: TGridDrawState);
var Linha: Integer; imgIndex: Integer;
begin
  // cabeçalho
  if gdFixed in State then
  begin
    grdListagem.Canvas.Brush.Color := clGray;
    grdListagem.Canvas.FillRect(Rect);
    Exit;
  end;

  Linha := fdqryListagem.RecNo;

  if gdSelected in State then
  begin
    grdListagem.Canvas.Brush.Color := $00DFF0DF;
    grdListagem.Canvas.Font.Color := clBlack;
  end
  else if Linha mod 2 = 0 then
  begin
    grdListagem.Canvas.Brush.Color := clWebLightgrey;
    grdListagem.Canvas.Font.Color := clBlack;
  end
  else
  begin
    grdListagem.Canvas.Brush.Color := clWhite;
    grdListagem.Canvas.Font.Color := clBlack;
  end;

  grdListagem.Canvas.FillRect(Rect);

  // bolinhas
  if Column.FieldName = 'IDSituacao' then
  begin
    case fdqryListagem.FieldByName('idSituacao').AsInteger of
      1: imgIndex := 0;
      2: imgIndex := 2;
      3: imgIndex := 1;
      4: imgIndex := 3;
      5: imgIndex := 4;
    else
      Exit;
    end;

    imagemStatus.Draw(grdListagem.Canvas,
      Rect.Left + (Rect.Width div 2) - 8,
      Rect.Top + (Rect.Height div 2) - 8,
      imgIndex);
  end
  else
  begin
    grdListagem.Canvas.TextRect(Rect,
      Rect.Left + 2,
      Rect.Top + 2,
      Column.Field.AsString);
  end;
end;

procedure TfrmCadCliente.LimparComponenteItem;
begin
  lkpStatus.KeyValue := Null;
  edtDoc.Text:= '';
end;

procedure TfrmCadCliente.lkpStatusCloseUp(Sender: TObject);
begin
  inherited;
  if (lkpStatus.Text = 'ATENÇÃO') or (lkpStatus.Text = 'BLOQUEADO') then
   begin
     edtObservacao.Visible := True;
     lblObs.Visible := True;
   end
   else
   begin
     edtObservacao.Visible := False;
     lblObs.Visible := False;
   end;
end;

procedure TfrmCadCliente.mskPesquisarChange(Sender: TObject);
begin
  if IndiceAtual = 'IDSituacao' then begin
    if mskPesquisar.Text <> '' then begin
      mskPesquisar.Text := '';
      ShowMessage('Não é possivel realizar pesquisas nesse campo');
      mskPesquisar.SetFocus;
    end;
  end;
  inherited;
end;

{$endregion}

function SomenteNumeros(const Texto:string):string;
var I:Integer;
begin
  Result:='';
  for I:= 1 to Length(Texto) do
    if Texto[I] in ['0'..'9'] then
    Result:= Result+Texto[I];
end;

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('clienteId').AsInteger = 0 then begin
    Exit;
  end;

  if oCliente.Selecionar(fdqryListagem.FieldByName('clienteId').AsInteger) then begin
     edtClienteId.Text:=IntToStr(oCliente.codigo);
     edtNome.Text     :=oCliente.nome;

     DefinirTipoPessoaPeloDocumento(oCliente.documento);
     if cbbPessoa.Text = 'Física' then
        lblDoc.Caption := 'CPF'
     else lblDoc.Caption := 'CNPJ';

     edtDoc.Text            :=oCliente.documento;
     lkpStatus.KeyValue     :=oCliente.IDSituacao;
     edtCEP.Text            :=oCliente.cep;
     edtEndereco.Text       :=oCliente.endereco;
     edtEstado.Text         :=oCliente.estado;
     edtBairro.Text         :=oCliente.bairro;
     edtCidade.Text         :=oCliente.cidade;
     edtCasa.Text           :=oCliente.Casa;

     chkSemNumero.OnClick := nil;
     try
     if UpperCase(Trim(edtCasa.Text)) = 'S/N' then
     begin
       chkSemNumero.Checked := True;
       edtCasa.ReadOnly := True;
     end
     else
     begin
       chkSemNumero.Checked := False;
       edtCasa.ReadOnly := False;
     end;
     finally
       chkSemNumero.OnClick := chkSemNumeroClick;
     end;

     edtObservacao.Text     :=oCliente.observacao;
     edtTelefone.Text       :=oCliente.telefone;
     edtEmail.Text          :=oCliente.email;
     dtpDataNascimento.Date :=oCliente.dataNascimento;

  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  if ((fdqryListagem.FieldByName('IDSituacao').AsInteger = 2) or (fdqryListagem.FieldByName('IDSituacao').AsInteger = 3) ) then
  begin
    edtObservacao.Visible:=True;
    lblObs.Visible:=True;
  end
  else
  begin
    edtObservacao.Visible:=False;
    lblObs.Visible:=False;
  end;

  inherited;
end;

procedure TfrmCadCliente.btnApagarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('clienteId').AsInteger = 0 then begin
    Exit;
  end;

  inherited;
end;

procedure TfrmCadCliente.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparComponenteItem;
end;

procedure TfrmCadCliente.DefinirTipoPessoaPeloDocumento(const ADoc: string);
var DocLimpo: string;
begin
  DocLimpo := SomenteNumeros(ADoc);

  if Length(DocLimpo) > 11 then
    cbbPessoa.ItemIndex := cbbPessoa.Items.IndexOf('Jurídica')
  else if Length(DocLimpo) > 0 then
    cbbPessoa.ItemIndex := cbbPessoa.Items.IndexOf('Física');
end;

procedure TfrmCadCliente.btnGravarClick(Sender: TObject);
var Qry: TFDQuery; Email, CEP: string;
begin
  Email := Trim(edtEmail.Text);
  CEP := SomenteNumeros(edtCEP.Text);
  Qry := TFDQuery.Create(nil);

  try
    Qry.Connection := dtmConexao.ConexaoDB;

    Qry.SQL.Text :=
      'SELECT clienteId ' +             //ve se tem documento igual
      'FROM clientes ' +
      'WHERE documento = :documento';

    Qry.ParamByName('documento').AsString := edtDoc.Text;
    Qry.Open;

    if not Qry.IsEmpty then     //se a query n tiver vazia é pq tem documento igual
    begin
      if (Trim(edtClienteId.Text) = '') or
         (Qry.FieldByName('clienteId').AsInteger <> StrToIntDef(edtClienteId.Text,0)) then //verificação se ta alterando
      begin                                                                        //o mesmo cliente ou se ta duplicando
        ShowMessage('Documento já cadastrado no sistema');
        edtDoc.SetFocus;
        Exit;
      end;
    end;

  finally
    Qry.Free;
  end;

  if Trim(cbbPessoa.Text) = '' then begin
    ShowMessage('Informe o Tipo de Pessoa');
    cbbPessoa.SetFocus;
    Exit;
  end;

  if Trim(edtDoc.Text) = '' then begin
    ShowMessage('Informe o documento');
    edtDoc.SetFocus;
    Exit;
  end;

  if Length(CEP) <> 8 then begin
    ShowMessage('Informe o CEP');
    edtCEP.SetFocus;
    Exit;
  end;

  if Trim(edtEndereco.Text) = '' then begin
    ShowMessage('Informe o endereço');
    edtDoc.SetFocus;
    Exit;
  end;

  if (not chkSemNumero.Checked) and (Trim(edtCasa.Text) = '') then
  begin
    ShowMessage('Informe o número da casa');
    edtCasa.SetFocus;
    Exit;
  end;

  if Trim(cbbPessoa.Text) = 'Física' then
  begin
  if not ValidarCPF(edtDoc.Text) then
  begin
    ShowMessage('CPF Inválido');
    edtDoc.SetFocus;
    Exit;
  end;
 end;

 if Trim(cbbPessoa.Text) = 'Jurídica' then
begin
  if not ValidarCNPJ(edtDoc.Text) then
  begin
    ShowMessage('CNPJ Inválido');
    edtDoc.SetFocus;
    Exit;
  end;
end;

if Trim(edtNome.Text) = '' then
  begin
  ShowMessage('Informe o nome do cliente');
  edtNome.SetFocus;
  Exit;
end;

if VarIsNull(lkpStatus.KeyValue) then
   begin
   ShowMessage('Selecione o status do cliente');
   lkpStatus.SetFocus;
   Exit;
  end;

if not TRegEx.IsMatch(Email, '^[^@\s]{2,}@[^@\s]{5,}.[^@\s]{2,}$') then
  begin
    ShowMessage('Informe um e-mail válido');
    edtEmail.SetFocus;
    Exit;
  end;

if YearsBetween(dtpDataNascimento.Date, Date) < 18 then
  begin
    ShowMessage('O Cliente deve ter 18 anos ou mais');
    dtpDataNascimento.SetFocus;
    dtpDataNascimento.Date := date;
    Exit;
  end;

  inherited;
  fdqryListagem.Close;
  fdqryListagem.Open;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  fdqryListagem.Close;
  fdqryListagem.Open;

  edtClienteId.Clear;
  edtNome.Clear;
  edtDoc.Clear;

  chkSemNumero.Checked := False;
  edtCasa.Enabled := True;

  dtpDataNascimento.date:=Date;
  lkpStatus.KeyValue := Null;

  LimparComponenteItem;

  oCliente.Limpar;

  cbbPessoa.SetFocus;
  cbbPessoa.ItemIndex := -1;
  cbbPessoa.Text := '';
end;

function BuscarCEP(const CEP: string): TJSONObject;
var IdHTTP: TIdHTTP; SSL: TIdSSLIOHandlerSocketOpenSSL; Response: string; CEPLimpo: string;
begin
  Result   := nil;
  CEPLimpo := SomenteNumeros(CEP);

  if Length(CEPLimpo) <> 8 then
    Exit;

  IdHTTP := TIdHTTP.Create(nil);
  SSL    := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    SSL.SSLOptions.Method := sslvTLSv1_2;
    SSL.SSLOptions.Mode   := sslmClient;
    IdHTTP.IOHandler      := SSL;

    IdHTTP.ConnectTimeout  := 5000;
    IdHTTP.ReadTimeout     := 5000;

    try
      Response := IdHTTP.Get('https://viacep.com.br/ws/' + CEPLimpo + '/json/');
      Result   := TJSONObject.ParseJSONValue(Response) as TJSONObject;
    except
      Result := nil;
    end;

  finally
    SSL.Free;
    IdHTTP.Free;
  end;
end;

procedure TfrmCadCliente.PreencherEndereco(const CEP: string);
var JSON: TJSONObject;
begin
  JSON := BuscarCEP(CEP);

  if Assigned(JSON) then
  try
    if JSON.GetValue('erro') <> nil then
    begin
      edtEndereco.Clear;
      edtBairro.Clear;
      edtCidade.Clear;
      edtEstado.Clear;

      edtEndereco.ReadOnly := False;
      edtEstado.ReadOnly   := False;
      edtBairro.ReadOnly   := False;
      edtCidade.ReadOnly   := False;

      ShowMessage('CEP não encontrado.' + sLineBreak + 'Verifique o número digitado ou preencha o endereço manualmente.');
      Exit;
    end;

    edtEndereco.Text := JSON.GetValue('logradouro').Value;
    edtBairro.Text   := JSON.GetValue('bairro').Value;
    edtCidade.Text   := JSON.GetValue('localidade').Value;
    edtEstado.Text   := JSON.GetValue('uf').Value;

    edtEndereco.ReadOnly := True;
    edtEstado.ReadOnly   := True;
    edtBairro.ReadOnly   := True;
    edtCidade.ReadOnly   := True;
  finally
    JSON.Free;
  end
  else
  begin
    ShowMessage('Serviço de CEP indisponível no momento.' + sLineBreak + 'Por favor, preencha o endereço manualmente.');

    edtEndereco.ReadOnly := False;
    edtEstado.ReadOnly   := False;
    edtBairro.ReadOnly   := False;
    edtCidade.ReadOnly   := False;

    edtEndereco.SetFocus;
  end;
end;

procedure TfrmCadCliente.cbbPessoaChange(Sender: TObject);
begin
  inherited;
  if cbbPessoa.Text = 'Física' then
     lblDoc.Caption := 'CPF'
  else lblDoc.Caption := 'CNPJ';

  edtDoc.Clear
end;

procedure TfrmCadCliente.chkSemNumeroClick(Sender: TObject);
begin
  if chkSemNumero.Checked then
  begin
    edtCasa.Text := 'S/N';
    edtCasa.ReadOnly := True;
  end
  else
  begin
    edtCasa.Clear;
    edtCasa.ReadOnly := False;
  end;
  inherited;
end;

procedure TfrmCadCliente.edtCEPChange(Sender: TObject);
var CEP: string;
begin
  inherited;
  CEP:= SomenteNumeros(edtCEP.Text);

  if Length(CEP) = 8 then begin
   lbl11.Visible := False;
   lbl12.Visible := False;
   lbl13.Visible := False;
   lbl14.Visible := False;
   PreencherEndereco(edtCEP.Text);
  end
  else begin
   lbl11.Visible := True;
   lbl12.Visible := True;
   lbl13.Visible := True;
   lbl14.Visible := True;
  end;
end;

procedure TfrmCadCliente.edtDocChange(Sender: TObject);
var TextoLimpo: string; T: TEdit;
begin
  inherited;

  T := TEdit(Sender);

  if T.Tag = 1 then Exit;
  T.Tag := 1;

  try
    TextoLimpo := SomenteNumeros(T.Text);

    if cbbPessoa.Text = 'Física' then
    begin
      if Length(TextoLimpo) > 11 then
        TextoLimpo := Copy(TextoLimpo, 1, 11);

      if Length(TextoLimpo) > 9 then
        T.Text := Copy(TextoLimpo,1,3)+'.'+Copy(TextoLimpo,4,3)+'.'+Copy(TextoLimpo,7,3)+'-'+Copy(TextoLimpo,10,2)
      else if Length(TextoLimpo) > 6 then
        T.Text := Copy(TextoLimpo,1,3)+'.'+Copy(TextoLimpo,4,3)+'.'+Copy(TextoLimpo,7)
      else if Length(TextoLimpo) > 3 then
        T.Text := Copy(TextoLimpo,1,3)+'.'+Copy(TextoLimpo,4)
      else
        T.Text := TextoLimpo;
    end
    else if cbbPessoa.Text = 'Jurídica' then
    begin
      if Length(TextoLimpo) > 14 then
        TextoLimpo := Copy(TextoLimpo, 1, 14);

      if Length(TextoLimpo) > 12 then
        T.Text := Copy(TextoLimpo,1,2)+ '.' +Copy(TextoLimpo,3,3)+'.' +
                  Copy(TextoLimpo,6,3)+ '/' +Copy(TextoLimpo,9,4)+ '-' + Copy(TextoLimpo,13,2)
      else if Length(TextoLimpo) > 8 then
        T.Text := Copy(TextoLimpo,1,2)+ '.' +Copy(TextoLimpo,3,3)+'.' +
                  Copy(TextoLimpo,6,3)+ '/' +Copy(TextoLimpo,9)
      else if Length(TextoLimpo) > 5 then
        T.Text := Copy(TextoLimpo,1,2)+ '.' +Copy(TextoLimpo,3,3)+ '.' + Copy(TextoLimpo,6)
      else if Length(TextoLimpo) > 2 then
        T.Text := Copy(TextoLimpo,1,2)+ '.' +Copy(TextoLimpo,3)
      else
        T.Text := TextoLimpo;
    end;

    T.SelStart := Length(T.Text);
  finally
    T.Tag := 0;
  end;

end;

procedure TfrmCadCliente.edtDocKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z', 'A'..'Z', #32] then
  Key := #0;
  inherited;
end;

procedure TfrmCadCliente.edtTelefoneChange(Sender: TObject);
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

procedure TfrmCadCliente.edtTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z', 'A'..'Z', #32] then
  Key := #0;
  inherited;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
     FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;

  QryStatus.Open;
  oCliente:=TCliente.Create(dtmConexao.ConexaoDB);
  IndiceAtual:='nome';
  LinhaZebrada:= 0;
end;


procedure TfrmCadCliente.FormShow(Sender: TObject);
begin
  inherited;
  dtpDataNascimento.MaxDate := Date;
end;

end.
