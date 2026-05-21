unit uTelaHerancaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls,
  Vcl.Buttons, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, uTelaHeranca, System.IniFiles;

type
  TfrmTelaHerancaConsulta = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    mskPesquisar: TMaskEdit;
    lblIndice: TLabel;
    grdPesquisa: TDBGrid;
    QryListagem: TFDQuery;
    dtsListagem: TDataSource;
    btnFechar: TBitBtn;
    btnPesquisar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure grdPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdPesquisaTitleClick(Column: TColumn);
    procedure grdPesquisaDblClick(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    SelectOriginal:string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function RetornarCampoTraduzido(Campo: string): string;
    function SomenteNumeros(const Texto: string): string;
    { Private declarations }
  public
    { Public declarations }
    aRetornarIdSelecionado:Variant;
    aIniciarPesquisaId:Variant;
    aCampoId:string;
    IndiceAtual:string;
  end;

var
  frmTelaHerancaConsulta: TfrmTelaHerancaConsulta;

implementation

uses
  uDTMconexao, uPrincipal;

{$R *.dfm}

procedure TfrmTelaHerancaConsulta.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHerancaConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
var ArquivoINI:TIniFile; I: Integer;
begin
  inherited;
  ExtractFilePath(Application.ExeName);
  ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'PreferenciasGridConsulta.ini');

  try
    for I := 0 to grdPesquisa.Columns.Count - 1 do
    begin
      ArquivoINI.WriteInteger(
      oUsuarioLogado.nome,
      'Coluna_' + IntToStr(I),
      grdPesquisa.Columns[I].Width);
    end;
  finally
    ArquivoINI.Free;
  end;

  QryListagem.Close;
end;

procedure TfrmTelaHerancaConsulta.FormCreate(Sender: TObject);
var i: Integer;
begin
  grdPesquisa.TitleFont.Color:=clWhite;

                                                               //centraliza todos os titulos
    for I := 0 to grdPesquisa.Columns.Count - 1 do
    grdPesquisa.Columns[I].Title.Alignment := taCenter;

  if QryListagem.Active then
     QryListagem.Close;
     ExibirLabelIndice(IndiceAtual, lblIndice);
    QryListagem.Open;
end;

procedure TfrmTelaHerancaConsulta.FormShow(Sender: TObject);
var ArquivoINI: TIniFile ;
    I:Integer;
begin
  inherited;
  SelectOriginal:= QryListagem.SQL.Text;
  ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName)+ 'PreferenciasGridConsulta.ini');

  try
    for I := 0 to grdPesquisa.Columns.Count - 1 do
    begin
      grdPesquisa.Columns[I].Width := ArquivoINI.ReadInteger
      (oUsuarioLogado.nome,
      'Coluna_' + IntToStr(I),
      grdPesquisa.Columns[I].Width);
    end;
  finally
    ArquivoINI.Free;
  end;

end;

procedure TfrmTelaHerancaConsulta.grdPesquisaDblClick(Sender: TObject);
begin
  aRetornarIdSelecionado := QryListagem.FieldByName(aCampoId).AsVariant;
  Close;
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  Linha: Integer;
begin
  if (gdFixed in State) then
  begin
    grdPesquisa.Canvas.Brush.Color := $00D0D0D0; // cinza suave
    grdPesquisa.Canvas.Font.Style := [fsBold];
    grdPesquisa.Canvas.FillRect(Rect);
    grdPesquisa.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    Exit;
  end;

  Linha := grdPesquisa.DataSource.DataSet.RecNo;

if (gdSelected in State) then
begin
  grdPesquisa.Canvas.Brush.Color := $00DFF0DF; // verde pastel
  grdPesquisa.Canvas.Font.Color := clBlack;

  grdPesquisa.Canvas.FillRect(Rect);
  grdPesquisa.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  Exit;
end;

  if (Linha mod 2) = 0 then
    grdPesquisa.Canvas.Brush.Color := clWebLightgrey  // cinzinha
  else
    grdPesquisa.Canvas.Brush.Color := clWhite;

  grdPesquisa.Canvas.Font.Color := clBlack;

  grdPesquisa.Canvas.FillRect(Rect);
  grdPesquisa.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 46) then
      Key := 0;
end;

procedure TfrmTelaHerancaConsulta.grdPesquisaTitleClick(Column: TColumn);
begin
  IndiceAtual :=Column.FieldName;
  QryListagem.IndexFieldNames:=IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

function TfrmTelaHerancaConsulta.RetornarCampoTraduzido(Campo:string):string;
var   I:Integer;
begin
  for I := 0 to QryListagem.Fields.Count-1 do begin
    if LowerCase (QryListagem.Fields[I].FieldName)= LowerCase(Campo) then begin
    Result:=QryListagem.Fields[I].DisplayLabel;
    Break;

    end;
  end;
end;

procedure TfrmTelaHerancaConsulta.btnPesquisarClick(Sender: TObject);
var I:Integer; TipoCampo: TFieldType; NomeCampo: string; WhereOrAnd: string; CondicaoSQL: string;
begin
  if mskPesquisar.Text='' then
  begin
    QryListagem.Close;
    QryListagem.SQL.Clear;
    QryListagem.SQL.Add(SelectOriginal);
    QryListagem.Open;
    Abort;
  end;

  TipoCampo := ftUnknown;
  for I := 0 to QryListagem.FieldCount-1 do
  begin
    if QryListagem.Fields[i].FieldName=IndiceAtual then
    begin
      TipoCampo := QryListagem.Fields[i].DataType;
      if QryListagem.Fields[i].Origin<>'' then
      begin
        if Pos('.',QryListagem.Fields[i].Origin) > 1 then
        NomeCampo := QryListagem.Fields[i].Origin
        else
        NomeCampo := QryListagem.Fields[i].Origin+'.'+QryListagem.Fields[i].FieldName
      end
      else
      NomeCampo := QryListagem.Fields[i].FieldName;
      Break;
    end;
  end;

  if TipoCampo = ftUnknown then
  begin
    ShowMessage('Campo não encontrado');
    Exit;
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


  QryListagem.Close;
  QryListagem.SQL.Clear;
  QryListagem.SQL.Add(SelectOriginal);
  QryListagem.SQL.Add(CondicaoSQL);
  QryListagem.Open;

  mskPesquisar.Text:='';
  mskPesquisar.SetFocus;

end;

procedure TfrmTelaHerancaConsulta.mskPesquisarChange(Sender: TObject);
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


  if(trim(TMaskEdit(Sender).Text) = '')then
    Exit;

  if(QryListagem.FieldByName(IndiceAtual).DataType in [ftString, ftWideString] )then
  begin
    QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey])
  end
  else if(QryListagem.FieldByName(IndiceAtual).DataType in [ftFloat, ftCurrency, ftFMTBcd] )then
  begin
   try
     QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [])
   except

   end;
  end
  else if(QryListagem.FieldByName(IndiceAtual).DataType in [ftDate, ftDateTime, ftTimeStamp] )then
  begin
   if TryStrToDate(TMaskEdit(Sender).Text, Date) then
   begin
     QryListagem.Locate(IndiceAtual, Date, []);
   end
  end
  else
     QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [])
end;

function TfrmTelaHerancaConsulta.SomenteNumeros(const Texto:string):string;
var
  I:Integer;
begin
  Result:='';

  for I:= 1 to Length(Texto) do
    if Texto[I] in ['0'..'9'] then
    Result:= Result+Texto[I];
end;

procedure TfrmTelaHerancaConsulta.ExibirLabelIndice(Campo:string; aLabel:TLabel);
begin
  Alabel.Caption:= RetornarCampoTraduzido(Campo);
end;

end.
