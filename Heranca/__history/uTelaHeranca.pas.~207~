unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ComCtrls, Vcl.ExtCtrls, System.UITypes,
  uDtmConexao, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uEnum,
  RxToolEdit, RxCurrEdit, System.IniFiles;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    dbnvgrNavigator: TDBNavigator;
    btnFechar: TBitBtn;
    fdqryListagem: TFDQuery;
    dsListagem: TDataSource;
    lblIndice: TLabel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure grdListagemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    SelectOriginal:string;
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TbitBtn;
              Navegador:TDBNavigator; pgcPrincipal: TPageControl; Flag:Boolean);

    function RetornarCampoTraduzido(Campo: string): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;

    procedure DesablitarEditPK;
    procedure LimparEdits;


  public
    { Public declarations }
    EstadoDoCadastro:TEstadoDoCadastro;
    IndiceAtual:string;
    function GetDesc: string; virtual;
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; virtual;
    function GetColumnByFieldName(Grid: TDBGrid; const AFieldName: string): TColumn;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
    procedure GravarAuditoria(Acao, Tela, Descricao: string);
    function SomenteNumeros(const Texto:string):string;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

uses uPrincipal, cUsuarioLogado;

{$R *.dfm}

{$REGION 'OBSERVAÇÕES'}
 //TAG: 1 - Chave Primária - PK
 //TAG: 2 - Campos Obrigatórios
{$ENDREGION}

{$REGION 'FUNÇÕES E PROCEDURES'}
procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.name+'_'+TBitBtn(Sender).Name, DtmConexao.ConexaoDB) then
  begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, dbnvgrNavigator, pgcPrincipal,False);
  EstadoDoCadastro:=ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnPesquisarClick(Sender: TObject);
var I:Integer; TipoCampo:TFieldType; NomeCampo: string; WhereOrAnd: string; CondicaoSQL: string;
begin
  if mskPesquisar.Text='' then
  begin
    fdqryListagem.Close;
    fdqryListagem.SQL.Clear;
    fdqryListagem.SQL.Add(SelectOriginal);
    fdqryListagem.Open;
    Abort;
  end;

  for I := 0 to fdqryListagem.FieldCount-1 do
  begin
    if fdqryListagem.Fields[i].FieldName=IndiceAtual then
    begin
      TipoCampo := fdqryListagem.Fields[i].DataType;
      if fdqryListagem.Fields[i].Origin<>'' then
      begin
        if Pos('.',fdqryListagem.Fields[i].Origin) > 1 then
        NomeCampo := fdqryListagem.Fields[i].Origin
        else
        NomeCampo := fdqryListagem.Fields[i].Origin+'.'+fdqryListagem.Fields[i].FieldName
      end
      else
      NomeCampo := fdqryListagem.Fields[i].FieldName;
      Break;
    end;
  end;

  if Pos('where', LowerCase(SelectOriginal)) > 0 then
  begin
    WhereOrAnd := ' and ';
  end
  else
  begin
    WhereOrAnd := ' where ';
  end;

  if (TipoCampo=ftString) or (TipoCampo=ftWideString) then
  begin
    CondicaoSQL := WhereOrAnd+' '+ NomeCampo + ' LIKE '+QuotedStr('%'+mskPesquisar.Text+'%');
  end
  else if (TipoCampo in [ftInteger, ftSmallint, ftAutoInc]) then
  begin
    CondicaoSQL := WhereOrAnd+''+NomeCampo + '='+mskPesquisar.Text
  end

  //AUTORAL DO PEPPA, MATEUS E LEO

  else if (TipoCampo in [ftDate, ftDateTime, ftdate, ftTimeStamp]) then
  begin
      CondicaoSQL := WhereOrAnd+' '+' CAST '+'('+NomeCampo +' as date)' + '='+QuotedStr(mskPesquisar.Text)
  end


 else if (TipoCampo in [ftFloat, ftCurrency, ftFMTBcd]) then
 begin
    CondicaoSQl := WhereOrAnd+''+NomeCampo + '='+StringReplace(mskPesquisar.Text,',','.',[rfReplaceAll]);
 end;


  fdqryListagem.Close;
  fdqryListagem.SQL.Clear;
  fdqryListagem.SQL.Add(SelectOriginal);
  fdqryListagem.SQL.Add(CondicaoSQL);
  fdqryListagem.Open;

  mskPesquisar.Text:='';
  mskPesquisar.SetFocus;

end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
var Date:TDateTime; Texto, N: string; poscursor: Integer;
begin
   if IndiceAtual = 'documento' then begin
  PosCursor := mskPesquisar.SelStart;
  mskPesquisar.OnChange := nil;
  try
    N := SomenteNumeros(mskPesquisar.Text);
    Texto := N;

    if Length(N) <= 11 then
    begin
      if Length(N) > 3 then Texto := Copy(N,1,3) + '.' + Copy(N,4,Length(N)-3);
      if Length(N) > 6 then Texto := Copy(N,1,3) + '.' + Copy(N,4,3) + '.' + Copy(N,7,Length(N)-6);
      if Length(N) > 9 then Texto := Copy(N,1,3) + '.' + Copy(N,4,3) + '.' + Copy(N,7,3) + '-' + Copy(N,10,Length(N)-9);
    end
    else
    begin
      if Length(N) > 2 then Texto := Copy(N,1,2) + '.' + Copy(N,3,Length(N)-2);
      if Length(N) > 5 then Texto := Copy(N,1,2) + '.' + Copy(N,3,3) + '.' + Copy(N,6,Length(N)-5);
      if Length(N) > 8 then Texto := Copy(N,1,2) + '.' + Copy(N,3,3) + '.' + Copy(N,6,3) + '/' + Copy(N,9,Length(N)-8);
      if Length(N) > 12 then Texto := Copy(N,1,2) + '.' + Copy(N,3,3) + '.' + Copy(N,6,3) + '/' + Copy(N,9,4) + '-' + Copy(N,13,Length(N)-12);
    end;

    mskPesquisar.Text := Texto;
    mskPesquisar.SelStart := Length(Texto);
  finally
    mskPesquisar.OnChange := mskPesquisarChange;
  end;
  end;


   if (fdqryListagem.FieldByName(IndiceAtual).DataType in [ftDate, ftDateTime, ftTimeStamp]) then begin
  PosCursor := mskPesquisar.SelStart;
  mskPesquisar.OnChange := nil;
  try
    N := SomenteNumeros(mskPesquisar.Text);
    Texto := N;

    if Length(N) <= 8 then
    begin
      if Length(N) > 2 then Texto := Copy(N,1,2) + '/' + Copy(N,3,Length(N)-2);
      if Length(N) > 4 then Texto := Copy(N,1,2) + '/' + Copy(N,3,2) + '/' + Copy(N,5,Length(N)-4);
    end;
    mskPesquisar.MaxLength := 10;
    mskPesquisar.Text := Texto;
    mskPesquisar.SelStart := Length(Texto);
  finally
    mskPesquisar.OnChange := mskPesquisarChange;
  end;
  end;




  if(trim(TMaskEdit(Sender).Text) = '')then
    Exit;

  if(fdqryListagem.FieldByName(IndiceAtual).DataType in [ftString, ftWideString] )then
  begin
    fdqryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey])
  end
  else if(fdqryListagem.FieldByName(IndiceAtual).DataType in [ftFloat, ftCurrency, ftFMTBcd] )then
  begin
   try
     fdqryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [])
   except

   end;
  end
  else if(fdqryListagem.FieldByName(IndiceAtual).DataType in [ftDate, ftDateTime, ftTimeStamp] )then
  begin
   if TryStrToDate(TMaskEdit(Sender).Text, Date) then
   begin
     fdqryListagem.Locate(IndiceAtual, Date, []);
   end
  end
  else
     fdqryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [])
end;

function TfrmTelaHeranca.SomenteNumeros(const Texto:string):string;
var
  I:Integer;
begin
  Result:='';

  for I:= 1 to Length(Texto) do
    if Texto[I] in ['0'..'9'] then
    Result:= Result+Texto[I];
end;

procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar:TbitBtn;
Navegador:TDBNavigator; pgcPrincipal: TPageControl; Flag:Boolean);
begin
  btnNovo.Enabled:=Flag;
  btnApagar.Enabled:=Flag;
  btnAlterar.Enabled:=Flag;
  Navegador.Enabled:=Flag;
  pgcPrincipal.Pages[0].TabVisible:=Flag;
  btnCancelar.Enabled:=not(Flag);
  btnGravar.Enabled:=not(Flag);
end;

function TfrmTelaHeranca.GetColumnByFieldName(Grid: TDBGrid; const AFieldName: string): TColumn;
var I: Integer;
begin
  Result := nil;
  for I := 0 to Grid.Columns.Count - 1 do
  begin
    if SameText(Grid.Columns[I].FieldName, AFieldName) then
      Exit(Grid.Columns[I]);
  end;
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal:TPageControl; Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
      pgcPrincipal.TabIndex:=Indice;
end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:string):string;
var   I:Integer;
begin
  for I := 0 to fdqryListagem.Fields.Count-1 do begin
    if LowerCase (fdqryListagem.Fields[I].FieldName)= LowerCase(Campo) then begin
    Result:=fdqryListagem.Fields[I].DisplayLabel;
    Break;

    end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo:string; aLabel:TLabel);
begin
  Alabel.Caption:= RetornarCampoTraduzido(Campo);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio:Boolean;
Var i: Integer;
begin
  Result:= False;
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Text = EmptyStr) then begin
         MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
                    ' é um campo obrigatório',mtInformation,[mbOK], 0);
         TLabeledEdit(Components[i]).SetFocus;
         Result:=True;
         Break;
         end;
    end;

  end;
end;

procedure TfrmTelaHeranca.DesablitarEditPK;
  Var i: Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
          TLabeledEdit(Components[i]).Enabled:=False;
          Break;
      end;

      end;
    end;
  end;

procedure TfrmTelaHeranca.LimparEdits;
  Var i: Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then
        TLabeledEdit(Components[i]).Text:=EmptyStr
      else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text:=''
      else if (Components[i] is TMemo) then
      TMemo(Components[i]).Text:=''
      else if (Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[i]).KeyValue:=Null
      else if (Components[i] is TCurrencyEdit) then
      TCurrencyEdit(Components[i]).Value:=0
      else if (Components[i] is TDateEdit) then
      TDateEdit(Components[i]).Date:=0
      else if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text:= ''

    end;
  end;

{$ENDREGION}

{$REGION 'Métodos Virtuais'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('DELETADO');
  Result:= True;
end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro:TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro=ecInserir) then
     ShowMessage('Inserir')
  else if (EstadoDoCadastro=ecAlterar) then
     ShowMessage('Alterado');
    Result:= True
end;

{$endregion}

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
var ArquivoINI: TIniFile; I: Integer; Secao: string;
begin
  ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'PreferenciasGrid.ini');
  try
    Secao := oUsuarioLogado.nome + '_' + Self.ClassName;

    for I := 0 to grdListagem.Columns.Count - 1 do
    begin
      ArquivoINI.WriteInteger(
        Secao,
        grdListagem.Columns[I].FieldName + '.Width',
        grdListagem.Columns[I].Width
      );

      ArquivoINI.WriteInteger(
        Secao,
        grdListagem.Columns[I].FieldName + '.Index',
        grdListagem.Columns[I].Index
      );
    end;

  finally
    ArquivoINI.Free;
  end;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
var I: Integer;
begin
  grdListagem.TitleFont.Color:=clWhite;

                                                               //centraliza todos os titulos
    for I := 0 to grdListagem.Columns.Count - 1 do
    grdListagem.Columns[I].Title.Alignment := taCenter;

  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,
                        dgTabs,dgAlwaysShowSelection,dgCancelOnExit,dgTitleClick,
                        dgTitleHotTrack]
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
var ArquivoINI: TIniFile; I, NewIndex: Integer; Col: TColumn; Secao: string; J: Integer;
begin
  ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'PreferenciasGrid.ini');
  try
    Secao := oUsuarioLogado.nome + '_' + Self.ClassName;

    grdListagem.Columns.BeginUpdate;
    try
      for J := 0 to grdListagem.Columns.Count - 1 do
       begin
        for I := 0 to grdListagem.Columns.Count - 1 do
         begin
            Col := grdListagem.Columns[I];

            NewIndex := ArquivoINI.ReadInteger(
            Secao,
            Col.FieldName + '.Index',
            Col.Index
            );

          if Col.Index <> NewIndex then
          Col.Index := NewIndex;
         end;
       end;

      for I := 0 to grdListagem.Columns.Count - 1 do
      begin
        Col := grdListagem.Columns[I];

        Col.Width := ArquivoINI.ReadInteger(
          Secao,
          Col.FieldName + '.Width',
          Col.Width
        );
      end;

    finally
      grdListagem.Columns.EndUpdate;
    end;

  finally
    ArquivoINI.Free;
  end;

  if (fdqryListagem.SQL.Text <> EmptyStr) then begin
    fdqryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    SelectOriginal := fdqryListagem.SQL.Text;
    fdqryListagem.Open;
  end;

  ControlarIndiceTab(pgcPrincipal, 0);
  DesablitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
                  btnGravar, btnApagar,
                  dbnvgrNavigator, pgcPrincipal,True);
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Linha: Integer;
begin
  if (gdFixed in State) then
  begin
    grdListagem.Canvas.Brush.Color := $00D0D0D0; // cinza suave
    grdListagem.Canvas.Font.Style := [fsBold];
    grdListagem.Canvas.FillRect(Rect);
    grdListagem.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    Exit;
  end;

  Linha := grdListagem.DataSource.DataSet.RecNo;

if (gdSelected in State) then
begin
  grdListagem.Canvas.Brush.Color := $00DFF0DF; // verde pastel
  grdListagem.Canvas.Font.Color := clBlack;

  grdListagem.Canvas.FillRect(Rect);
  grdListagem.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  Exit;
end;


  if (Linha mod 2) = 0 then
    grdListagem.Canvas.Brush.Color := clWebLightgrey  // cinzinha
  else
    grdListagem.Canvas.Brush.Color := clWhite;

  grdListagem.Canvas.Font.Color := clBlack;

  grdListagem.Canvas.FillRect(Rect);
  grdListagem.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;


procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGrid(Key,Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual:=Column.FieldName;
  fdqryListagem.IndexFieldNames:=IndiceAtual;
  ExibirLabelIndice(IndiceAtual,lblIndice);
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.name+'_'+TBitBtn(Sender).Name, DtmConexao.ConexaoDB) then
  begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, dbnvgrNavigator, pgcPrincipal,False);
    EstadoDoCadastro:=ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
    if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.name+'_'+TBitBtn(Sender).Name, DtmConexao.ConexaoDB) then
  begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

 try
  if (Apagar) then begin
      GravarAuditoria('APAGAR', Self.Caption, 'Registro apagado: ' + getDesc);

    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, dbnvgrNavigator, pgcPrincipal,True);
    ControlarIndiceTab(pgcPrincipal, 0);
    LimparEdits;
    fdqryListagem.Close;
    fdqryListagem.Open;
  end
  else begin
    MessageDlg('Erro na Exclusão', mtError, [mbOK], 0);
  end;
  finally
    EstadoDoCadastro:=ecNenhum;
 end;

end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, dbnvgrNavigator, pgcPrincipal,True);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro:=ecNenhum;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

function TfrmTelaHeranca.GetDesc:string;
begin
 result:= '';
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if not TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, self.name+'_'+TBitBtn(Sender).Name, DtmConexao.ConexaoDB) then
  begin
    MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
    Abort;
  end;

 if (ExisteCampoObrigatorio) then
     Abort;
  try
    if Gravar(EstadoDoCadastro) then
   begin
     if EstadoDoCadastro = ecInserir then
        GravarAuditoria('INSERIR', Self.Caption, 'Registro inserido: ' + GetDesc)
     else if EstadoDoCadastro = ecAlterar then
         GravarAuditoria('EDITAR', Self.Caption, 'Registro alterado: ' + GetDesc);

    ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, dbnvgrNavigator, pgcPrincipal,True);
    ControlarIndiceTab(pgcPrincipal, 0);

    EstadoDoCadastro:=ecNenhum;
    LimparEdits;
    fdqryListagem.Close;
    fdqryListagem.Open;
   end;
  finally
  end;
end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
  if (Shift =[ssCtrl]) and (Key = 46) then
      Key := 0
end;

procedure TfrmTelaHeranca.GravarAuditoria(Acao, Tela, Descricao: string);
var Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := DtmConexao.ConexaoDB;

    Qry.SQL.Text :=
      'INSERT INTO AUDITORIA ' +
      '(DATA_HORA, USUARIO, ACAO, TELA, DESCRICAO) ' +
      'VALUES (:DATA_HORA, :USUARIO, :ACAO, :TELA, :DESCRICAO)';

    Qry.ParamByName('DATA_HORA').AsDateTime := TDateTime(Now);
    Qry.ParamByName('USUARIO').AsString := oUsuarioLogado.nome;
    Qry.ParamByName('ACAO').AsString := Acao;
    Qry.ParamByName('TELA').AsString := Tela;
    Qry.ParamByName('DESCRICAO').AsString := Descricao;

    Qry.ExecSQL;
  except
    on E: Exception do
      ShowMessage('Erro auditoria: ' + E.Message);
  end;

  Qry.Free;
end;

end.
