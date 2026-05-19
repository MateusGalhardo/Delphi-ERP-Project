unit uConProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHerancaConsulta, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TfrmConProduto = class(TfrmTelaHerancaConsulta)
    f1QryListagemprodutoId: TFDAutoIncField;
    f2QryListagemnome: TStringField;
    fmtbcdfldQryListagemvalor_final: TFMTBCDField;
    fmtbcdfldQryListagemquantidade: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConProduto: TfrmConProduto;

implementation

{$R *.dfm}

procedure TfrmConProduto.FormCreate(Sender: TObject);
begin
  aCampoId :='produtoId';
  IndiceAtual :='nome';
  inherited;
end;

end.
