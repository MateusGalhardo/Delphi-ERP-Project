unit uControleLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TfrmControleLog = class(TfrmTelaHerancaConsulta)
    f1QryListagemID: TFDAutoIncField;
    QryListagemDATA_HORA: TSQLTimeStampField;
    f2QryListagemUSUARIO: TStringField;
    f2QryListagemACAO: TStringField;
    f2QryListagemTELA: TStringField;
    f2QryListagemDESCRICAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdPesquisaTitleClick(Column: TColumn);
  private
    { Private declarations }
    SelectOriginal: string;
    IndiceAtual: string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function RetornarCampoTraduzido(Campo: String): String;
  public
    { Public declarations }
  end;

var
  frmControleLog: TfrmControleLog;

implementation

{$R *.dfm}

procedure TfrmControleLog.btnPesquisarClick(Sender: TObject);
var I:Integer; TipoCampo:TFieldType; NomeCampo: string; WhereOrAnd: string; CondicaoSQL: string;
begin
  if mskPesquisar.Text='' then
  begin
    QryListagem.Close;
    QryListagem.SQL.Clear;
    QryListagem.SQL.Add(SelectOriginal);
    QryListagem.Open;
    Abort;
  end;

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

  if Pos('where', LowerCase(SelectOriginal)) > 0 then
  begin
    WhereOrAnd := ' and '
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


  else if (TipoCampo in [ftDate, ftDateTime, ftdate, ftTimeStamp]) then
  begin
      CondicaoSQL := WhereOrAnd + ' CAST(' + NomeCampo + ' as date) = :Data';
  end


 else if (TipoCampo in [ftFloat, ftCurrency, ftFMTBcd]) then
 begin
    CondicaoSQl := WhereOrAnd+''+NomeCampo + '='+StringReplace(mskPesquisar.Text,',','.',[rfReplaceAll]);
 end;


  QryListagem.Close;
  QryListagem.SQL.Clear;
  QryListagem.SQL.Add(SelectOriginal);
  QryListagem.SQL.Add(CondicaoSQL);
  QryListagem.ParamByName('Data').AsDate := StrToDate(mskPesquisar.Text);
  QryListagem.Open;

  mskPesquisar.Text:='';
  mskPesquisar.SetFocus;

end;

procedure TfrmControleLog.ExibirLabelIndice(Campo:string; aLabel:TLabel);
  begin
    alabel.Caption:=RetornarCampoTraduzido(Campo);
  end;

function TfrmControleLog.RetornarCampoTraduzido(Campo:String):String;
var i:Integer;
begin
  for I := 0 to QryListagem.Fields.Count-1 do begin
    if LowerCase(QryListagem.Fields[i].FieldName)=LowerCase(Campo)then begin
    Result:= QryListagem.Fields[i].DisplayLabel;
    Break;
    end;
  end;
end;

procedure TfrmControleLog.FormCreate(Sender: TObject);
var i: Integer;
begin
  inherited;
  grdPesquisa.TitleFont.Color:=clWhite;

  for i := 0 to grdPesquisa.Columns.Count - 1 do
  grdPesquisa.Columns[i].Title.Alignment := taCenter;
end;

procedure TfrmControleLog.FormShow(Sender: TObject);
begin
  inherited;
  SelectOriginal:=QryListagem.SQL.Text;
  QryListagem.Open;
  lblIndice.Caption:= 'Selecione um campo para pesquisa';
end;

procedure TfrmControleLog.grdPesquisaTitleClick(Column: TColumn);
begin
  IndiceAtual:= Column.FieldName;
   QryListagem.IndexFieldNames:=IndiceAtual;
   ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmControleLog.mskPesquisarChange(Sender: TObject);
var Date:TDateTime;
s: string;
begin
  if(trim(TMaskEdit(Sender).Text) = '')then
    Exit;

  if(QryListagem.FieldByName(IndiceAtual).DataType in [ftString, ftWideString] )then
  begin
    QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey])
  end

  else if(QryListagem.FieldByName(IndiceAtual).DataType in [ftFloat, ftCurrency, ftFMTBcd] )then
  begin
    try
      QryListagem.Locate(IndiceAtual, (TMaskEdit(Sender).Text), [])
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
       else QryListagem.Locate(IndiceAtual, TMaskEdit(Sender).Text, []);

  s := StringReplace(mskPesquisar.Text, '/', '', [rfReplaceAll]);

  if Length(s) <= 2 then begin

  if Length(s) > 2 then
    Insert('/', s, 3);

  if Length(s) > 5 then
    Insert('/', s, 6);

  mskPesquisar.OnChange := nil;
  mskPesquisar.Text := s;
  mskPesquisar.SelStart := Length(s);
  mskPesquisar.OnChange := mskPesquisarChange;
  end;
end;

end.
