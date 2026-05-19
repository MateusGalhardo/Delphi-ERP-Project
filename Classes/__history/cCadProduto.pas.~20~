unit cCadProduto;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.ComCtrls, RxToolEdit;

type
  TProduto = class
  private
    ConexaoDB:TFDConnection;
    F_produtoId:Integer;
    F_nome:string;
    f_descricao: string;
    F_valor:Double;
    F_quantidade: Double;
    F_categoriaId: Integer;
    F_Foto: TBitMap;
    F_fornId: Integer;

  public
  constructor Create(aConexao:TFDConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;

  published
    property codigo        :Integer    read F_produtoId      write F_produtoId;
    property nome          :string     read F_nome           write F_nome;
    property descricao     :string     read F_descricao      write F_descricao;
    property valor         :Double     read F_valor          write F_valor;
    property quantidade    :Double     read F_quantidade     write F_quantidade;
    property categoriaId   :Integer    read F_categoriaId    write F_categoriaId;
    property foto          :TBitmap    read F_Foto           write F_Foto;
    property fornId        :Integer    read F_fornId         write F_fornId;

  end;

implementation

{$region 'Constructor and Destructor'}
constructor TProduto.Create (aConexao:TFDConnection);
begin
  ConexaoDB:=aConexao;
  F_Foto   :=TBitmap.Create;
  F_Foto.Assign(nil)
end;

destructor TProduto.Destroy;
begin
  if
  Assigned (F_Foto) then begin
  F_Foto.Assign(nil);
  F_Foto.Free;
  end;
  inherited;
  end;

{$endregion}

{$region 'CRUD'}
function TProduto.Apagar: Boolean;
var Qry:TFDQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Codigo: '+IntToStr(F_produtoId)+#13+
                'Descricao: '+F_nome,mtConfirmation,[mbYes, mbNo],0)<> mrYes then begin
     Result:=false;
     Exit;;
  end;

  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM produtos '+
                ' WHERE produtoId=:produtoId ');
    Qry.ParamByName('produtoId').AsInteger :=F_produtoId;

    try
    ConexaoDB.StartTransaction;
    Qry.ExecSQL;
    ConexaoDB.Commit;
  except
    on e: Exception do begin
      ConexaoDB.Rollback;

       if Pos('FK_VendasItensProdutos', E.Message) > 0 then
          ShowMessage('Não é possível excluir este produto pois ele já está vinculado a vendas.')
        else
          ShowMessage('Erro ao excluir produto: ' + E.Message);
          Exit;

      Result:=False;
    end;
  end;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TProduto.Atualizar: Boolean;
var Qry:TFDQuery;
    MS: TMemoryStream;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos '+
                '   SET nome           =:nome '+
                '       ,descricao     =:descricao '+
                '       ,valor         =:valor '+
                '       ,quantidade    =:quantidade '+
                '       ,foto          =:foto '+
                '       ,fornId        =:fornId '+
                '       ,categoriaId   =:categoriaId '+
                ' WHERE produtoId=:produtoId ');
    Qry.ParamByName('produtoId').AsInteger       :=Self.F_produtoId;
    Qry.ParamByName('fornId').AsInteger          :=Self.F_fornId;
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('descricao').AsString        :=Self.F_descricao;
    Qry.ParamByName('valor').AsFloat             :=Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat        :=Self.F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger     :=Self.F_categoriaId;

    if (Self.F_Foto = nil) or Self.F_Foto.Empty then
    begin
      Qry.ParamByName('foto').DataType := ftBlob;
      Qry.ParamByName('foto').Clear;
    end
    else
    begin
      MS := TMemoryStream.Create;
      try
        Self.F_Foto.SaveToStream(MS);
        MS.Position := 0;
        Qry.ParamByName('foto').DataType := ftBlob;
        Qry.ParamByName('foto').LoadFromStream(MS, ftBlob);
      finally
        MS.Free;
      end;
    end;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TProduto.Inserir: Boolean;
var Qry:TFDQuery;
    MS: TMemoryStream;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO produtos (nome, '+
                '                      descricao, '+
                '                      fornId,  '+
                '                      valor,  '+
                '                      quantidade,  '+
                '                      categoriaId, DataProduto, '+
                '                      foto ) '+
                ' VALUES              (:nome, '+
                '                      :descricao, '+
                '                      :fornId,  '+
                '                      :valor,  '+
                '                      :quantidade,  '+
                '                      :categoriaId, :DataProduto, '+
                '                      :foto ) ');

    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('descricao').AsString        :=Self.F_descricao;
    Qry.ParamByName('valor').AsFloat             :=Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat        :=Self.F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger     :=Self.F_categoriaId;
    Qry.ParamByName('fornId').AsInteger          :=Self.F_fornId;
    Qry.ParamByName('DataProduto').AsDateTime    := TDateTime(Now);

    if (Self.F_foto = nil) or Self.F_foto.Empty then
    begin
      Qry.ParamByName('foto').DataType := ftBlob;
      Qry.ParamByName('foto').Clear;
    end
    else
    begin
      MS := TMemoryStream.Create;
      try
        Self.F_Foto.SaveToStream(MS);
        MS.Position := 0;
        Qry.ParamByName('foto').DataType := ftBlob;
        Qry.ParamByName('foto').LoadFromStream(MS, ftBlob);
      finally
        MS.Free;
      end;
    end;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TProduto.Selecionar(id: Integer): Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT produtoId,'+
                '       nome, '+
                '       fornId, '+
                '       descricao, '+
                '       valor, '+
                '       quantidade, '+
                '       categoriaId, '+
                '       foto '+
                '  FROM produtos '+
                ' WHERE produtoId=:produtoId');
    Qry.ParamByName('produtoId').AsInteger:=id;
    Try
      Qry.Open;

      Self.F_produtoId     := Qry.FieldByName('produtoId').AsInteger;
      Self.F_fornId        := Qry.FieldByName('fornId').AsInteger;
      Self.F_nome          := Qry.FieldByName('nome').AsString;
      Self.F_descricao     := Qry.FieldByName('descricao').AsString;
      Self.F_valor         := Qry.FieldByName('valor').AsFloat;
      Self.F_quantidade    := Qry.FieldByName('quantidade').AsFloat;
      Self.F_categoriaId   := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_foto.Assign(Qry.FieldByName('foto'));
    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
{$endregion}


end.
