unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  uDTMconexao, cCadCategoria, uEnum,
  Data.SqlTimSt;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    f1ListagemcategoriaId: TFDAutoIncField;
    f2Listagemdescricao: TStringField;
    lbl1: TLabel;
    lbl2: TLabel;
    edtCategoriaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);

  private
    oCategoria: TCategoria;

    function GetDesc: string; override;

  public
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$REGION 'Override'}

function TfrmCadCategoria.Apagar: Boolean;
begin
  Result := False;

  if not Assigned(oCategoria) then
    Exit;

  if fdqryListagem.IsEmpty then
    Exit;

  if oCategoria.Selecionar(
       fdqryListagem.FieldByName('categoriaId').AsInteger) then
  begin
    Result := oCategoria.Apagar;
  end;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  Result := False;

  if not Assigned(oCategoria) then
    Exit;

  if Trim(edtCategoriaId.Text) <> '' then
    oCategoria.codigo := StrToIntDef(edtCategoriaId.Text, 0)
  else
    oCategoria.codigo := 0;

  oCategoria.descricao := Trim(edtDescricao.Text);

  case EstadoDoCadastro of
    ecInserir:
      Result := oCategoria.Inserir;

    ecAlterar:
      Result := oCategoria.Atualizar;
  end;
end;

procedure TfrmCadCategoria.grdListagemDblClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('categoriaId').AsInteger = 0 then begin
    Exit;
  end;
  inherited;
end;

procedure TfrmCadCategoria.mskPesquisarChange(Sender: TObject);
begin
  inherited;
end;

{$ENDREGION}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('categoriaId').AsInteger = 0 then begin
    Exit;
  end;

  if not Assigned(oCategoria) then
    Exit;

  if fdqryListagem.IsEmpty then
    Exit;

  if oCategoria.Selecionar(
       fdqryListagem.FieldByName('categoriaId').AsInteger) then
  begin
    edtCategoriaId.Text := IntToStr(oCategoria.codigo);
    edtDescricao.Text := oCategoria.descricao;

    inherited;
  end
  else
  begin
    ShowMessage('Registro não encontrado.');
    btnCancelar.Click;
  end;
end;

procedure TfrmCadCategoria.btnApagarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('categoriaId').AsInteger = 0 then begin
    Exit;
  end;
  inherited;
end;

function TfrmCadCategoria.GetDesc: string;
begin
  Result := '';

  if Assigned(oCategoria) then
    Result := oCategoria.descricao;
end;

procedure TfrmCadCategoria.btnGravarClick(Sender: TObject);
begin
  if Trim(edtDescricao.Text) = '' then
  begin
    ShowMessage('Insira sua categoria');
    edtDescricao.SetFocus;
    Exit;
  end;
  inherited;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(oCategoria);
  Action := caFree;
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria := TCategoria.Create(dtmConexao.ConexaoDB);
  IndiceAtual := 'descricao';
end;

end.
