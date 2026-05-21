unit uUsuarioVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmUsuarioVsAcoes = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    dtsAcoes: TDataSource;
    dtsUsuario: TDataSource;
    QryUsuario: TFDQuery;
    QryAcoes: TFDQuery;
    f1QryUsuariousuarioID: TFDAutoIncField;
    f2QryUsuarioNome: TStringField;
    intgrfldQryAcoesusuarioId: TIntegerField;
    intgrfldQryAcoesacaoAcessoId: TIntegerField;
    f2QryAcoesdescricao: TStringField;
    QryAcoesativo: TBooleanField;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure QryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grdUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuarioVsAcoes: TfrmUsuarioVsAcoes;

implementation

uses
  uDTMconexao;

{$R *.dfm}

procedure TfrmUsuarioVsAcoes.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDblClick(Sender: TObject);
var
  Qry: TFDQuery;
  vUsuarioId, vAcaoId: Integer;
begin
  try
    vUsuarioId := QryAcoes.FieldByName('usuarioId').AsInteger;
    vAcaoId    := QryAcoes.FieldByName('acaoAcessoId').AsInteger;

    Qry := TFDQuery.Create(nil);
    Qry.Connection := dtmConexao.ConexaoDB;

    Qry.SQL.Text :=
      'UPDATE usuariosAcaoAcesso '+
      'SET ativo = :ativo '+
      'WHERE usuarioId = :usuarioId '+
      'AND acaoAcessoId = :acaoAcessoId';

    Qry.ParamByName('usuarioId').AsInteger := vUsuarioId;
    Qry.ParamByName('acaoAcessoId').AsInteger := vAcaoId;
    Qry.ParamByName('ativo').AsBoolean :=
      not QryAcoes.FieldByName('ativo').AsBoolean;

    dtmConexao.ConexaoDB.StartTransaction;
    try
      Qry.ExecSQL;
      dtmConexao.ConexaoDB.Commit;
    except
      dtmConexao.ConexaoDB.Rollback;
      raise;
    end;

  finally
    SelecionarAcoesAcessoPorUsuario;

    QryAcoes.Locate('usuarioId;acaoAcessoId',
                    VarArrayOf([vUsuarioId, vAcaoId]), []);

    FreeAndNil(Qry);
  end;
end;

procedure TfrmUsuarioVsAcoes.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var Ativo: Boolean;
begin
  // cabeçalho
  if gdFixed in State then
  begin
    grdAcoes.Canvas.Brush.Color := clGray;
    grdAcoes.Canvas.FillRect(Rect);
    Exit;
  end;

  Ativo := Column.Field.DataSet.FieldByName('ativo').AsBoolean;

  if not Ativo then
  begin
    grdAcoes.Canvas.Brush.Color := $00CCCCFF; // vermelinho pastel
    grdAcoes.Canvas.Font.Color := clBlack;
  end
  else if gdSelected in State then
  begin
    grdAcoes.Canvas.Brush.Color := $00DFF0DF;
    grdAcoes.Canvas.Font.Color := clBlack;
  end
  else if Column.Field.DataSet.RecNo mod 2 = 0 then
  begin
    grdAcoes.Canvas.Brush.Color := clWebLightgrey;
    grdAcoes.Canvas.Font.Color := clBlack;
  end
  else
  begin
    grdAcoes.Canvas.Brush.Color := clWhite;
    grdAcoes.Canvas.Font.Color := clBlack;
  end;

  grdAcoes.Canvas.FillRect(Rect);

  grdAcoes.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);
end;

procedure TfrmUsuarioVsAcoes.grdUsuariosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  Linha: Integer;
begin
  if (gdFixed in State) then
  begin
    grdUsuarios.Canvas.Brush.Color := $00D0D0D0; // cinza suave
    grdUsuarios.Canvas.Font.Style := [fsBold];
    grdUsuarios.Canvas.FillRect(Rect);
    grdUsuarios.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    Exit;
  end;

  Linha := grdUsuarios.DataSource.DataSet.RecNo;

if (gdSelected in State) then
begin
  grdUsuarios.Canvas.Brush.Color := $00DFF0DF; // verde pastel
  grdUsuarios.Canvas.Font.Color := clBlack;

  grdUsuarios.Canvas.FillRect(Rect);
  grdUsuarios.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  Exit;
end;


  if (Linha mod 2) = 0 then
    grdUsuarios.Canvas.Brush.Color := clWebLightgrey  // cinzinha
  else
    grdUsuarios.Canvas.Brush.Color := clWhite;

  grdUsuarios.Canvas.Font.Color := clBlack;

  grdUsuarios.Canvas.FillRect(Rect);
  grdUsuarios.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmUsuarioVsAcoes.FormCreate(Sender: TObject);
var i: Integer;
begin
  grdUsuarios.TitleFont.Color:=clWhite;
  grdAcoes.TitleFont.Color:=clWhite;

    for i := 0 to grdUsuarios.Columns.Count - 1 do
    grdUsuarios.Columns[i].Title.Alignment := taCenter;

     grdAcoes.TitleFont.Color:=clWhite;

    for i := 0 to grdAcoes.Columns.Count - 1 do
    grdAcoes.Columns[i].Title.Alignment := taCenter;
end;

procedure TfrmUsuarioVsAcoes.FormShow(Sender: TObject);
begin
  try
    QryUsuario.DisableControls;
    QryUsuario.Open;
    SelecionarAcoesAcessoPorUsuario;
  finally
    QryUsuario.EnableControls;
  end;
end;

procedure TfrmUsuarioVsAcoes.QryUsuarioAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuarioVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  QryAcoes.Close;
  QryAcoes.ParamByName('usuarioId').AsInteger := QryUsuario.FieldByName('usuarioID').AsInteger;
  QryAcoes.Open;
end;

end.
