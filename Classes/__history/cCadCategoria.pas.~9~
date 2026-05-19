unit cCadCategoria;

interface

uses
   System.Classes,
   Vcl.Controls,
   Vcl.ExtCtrls,
  FireDAC.Comp.Client,
  Vcl.Dialogs,
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
   FireDAC.Stan.Param,
  FireDAC.Stan.Error,
   FireDAC.DatS,
    FireDAC.Phys.Intf,
     FireDAC.DApt.Intf,
      FireDAC.Stan.Async,
       FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TCategoria = class
  private
    ConexaoDB:TFDConnection;
    F_categoriaId:Integer;
    F_descricao:string;

    function GetCodigo: Integer;
    function getDescricao: string;

   procedure setCodigo(const Value: Integer);
   procedure setDescricao(const Value: string);
  public
    constructor Create(aConexao:TFDConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
  published
     property codigo:Integer  read GetCodigo  write setCodigo;
     property descricao:string read getDescricao  write setDescricao;

  end;

implementation

{ TCategoria }

{$REGION ' Constructor and Destructor'}

 constructor TCategoria.Create(aConexao:TFDConnection);
begin
  ConexaoDB:=aConexao;
end;

 destructor TCategoria.Destroy;
begin

  inherited;
end;

{$ENDREGION}

{$REGION 'CRUD'}

function TCategoria.Apagar: Boolean;
var Qry: TFDQuery;
begin
  Result := False;
  if MessageDlg('Apagar o Registro:' + #13#13 + 'Código: ' + IntToStr(F_categoriaId) + #13 + 'Descrição: ' + F_descricao,
                mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
  begin
    Exit;
  end;

  Qry := TFDQuery.Create(nil);

  try
    Qry.Connection := ConexaoDB;

    Qry.SQL.Clear;
    Qry.SQL.Add(
      'DELETE FROM categorias ' +
      'WHERE categoriaId = :categoriaId');

    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;

    try
      ConexaoDB.StartTransaction;

      Qry.ExecSQL;

      ConexaoDB.Commit;

      Result := True;

    except
      on E: Exception do
      begin
        if ConexaoDB.InTransaction then
          ConexaoDB.Rollback;

        ShowMessage('Essa categoria não pode ser excluída porque está sendo utilizada em um ou mais produtos.');

        Result := False;
        Abort;
      end;
    end;

  finally
    FreeAndNil(Qry);
  end;
end;

function TCategoria.Atualizar: Boolean;
var Qry:TFDQuery;
begin
  try
   Result:= True;
   Qry:=TFDQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('UPDATE categorias' +
            '  SET descricao = :descricao' +
            '  WHERE categoriaId = :categoriaId');


   Qry.ParamByName('descricao').AsString := Self.F_descricao;
   Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

  try
    ConexaoDB.StartTransaction;
    Qry.ExecSQL;
    ConexaoDB.Commit;
  except
    ConexaoDB.Rollback;
    Result:=False;
  end;

  finally
  if  Assigned(Qry) then
  FreeAndNil(Qry);
  end;

end;


function TCategoria.Inserir: Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=True;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO categorias (descricao) values (:descricao)');
    Qry.ParamByName('descricao').AsString:= Self.F_descricao;
   try
    ConexaoDB.StartTransaction;
    Qry.ExecSQL;
    ConexaoDB.Commit;
  except
    ConexaoDB.Rollback;
    Result:=False;
  end;
  finally
    if Assigned(Qry) then
    FreeAndNil(Qry);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var Qry:TFDQuery;
begin
  try
   Result:= True;
   Qry:=TFDQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('SELECT categoriaId, descricao '+
               '  FROM categorias '+
               ' WHERE categoriaId=:categoriaId');
   Qry.ParamByName('categoriaId').AsInteger:=id;
   Qry.Open;
  try

    Self.F_categoriaId:= Qry.FieldByName('categoriaId').asInteger;
    Self.F_descricao:= Qry.FieldByName('descricao').AsString;
  Except
    Result:=False;
  end;
  finally
  if  Assigned(Qry) then
  FreeAndNil(Qry);
  end;
end;

{$ENDREGION}

{$REGION 'Gets'}

function TCategoria.GetCodigo: Integer;
begin
  Result:= Self.F_categoriaId;
end;

function TCategoria.getDescricao: string;
begin
  Result:= Self.F_descricao;
end;


{$ENDREGION}

{$REGION 'Sets'}
procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId:= Value;
end;

procedure TCategoria.setDescricao(const Value: string);
begin
  Self.F_descricao := Value;
end;

{$ENDREGION}

end.
