unit cCadUsuario;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uFuncaoCriptografia;

type
  TUsuario = class
    private
       ConexaoDB:TFDConnection;
       F_UsuarioId:Integer;
       F_Nome:string;
       F_Senha:string;
       F_perfilId: Integer;
       function getSenha: string;
       procedure setSenha (const value: string);

    public
       constructor Create (aConexao:TFDConnection);
       destructor Destroy; override;
       function Inserir: Boolean;
       function Atualizar: Boolean;
       function Apagar: Boolean;
       function Selecionar(id:integer): Boolean;
       function Logar(aUsuario, aSenha: String): Boolean;
       function UsuarioExiste(aUsuario:String):Boolean;
       function AlterarSenha: Boolean;

    published
       property codigo      :Integer     read F_UsuarioId     write F_UsuarioId;
       property nome        :String      read F_Nome          write F_Nome;
       property senha       :String      read getSenha        write setSenha;
       property perfilId    :Integer     read F_perfilId      write F_perfilId;
  end;
implementation

uses
  uCadUsuario;

constructor TUsuario.Create(aConexao:TFDConnection);
begin
  ConexaoDB:=aConexao;
end;

destructor TUsuario.Destroy;
begin

  inherited;
end;

{$region 'CRUD'}
function TUsuario.Apagar: Boolean;
var Qry:TFDQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Código: '+IntToStr(F_usuarioId)+#13+
                'Nome: '  +F_nome,mtConfirmation,[mbYes, mbNo],0)<> mrYes then begin
     Result:=false;
     abort;
  end;

  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('delete from usuariosAcaoAcesso where usuarioId = :usuarioId '+
                'delete from usuarios where usuarioId = :usuarioId ');
                Qry.ParamByName('usuarioId').AsInteger :=F_usuarioId;

    Qry.SQL.Add('DELETE FROM usuarios '+
                ' WHERE usuarioId=:usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger :=F_usuarioId;
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

function TUsuario.Atualizar: Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuarios '+
                '   SET nome           =:nome '+
                '        ,perfilId      =:perfilId '+
                '       ,senha         =:senha '+
                ' WHERE usuarioId=:usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger       :=Self.F_usuarioId;
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('perfilId').AsInteger        :=Self.F_perfilId;
    Qry.ParamByName('senha').AsString            :=Self.F_Senha;

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

function TUsuario.Inserir: Boolean;
var Qry: TFDQuery;
begin
  Result := False;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := ConexaoDB;

    ConexaoDB.StartTransaction;

    Qry.SQL.Text :=
      'INSERT INTO usuarios (nome, senha, perfilId) '+
      'OUTPUT INSERTED.usuarioId '+
      'VALUES (:nome, :senha, :perfilId)';

    Qry.ParamByName('nome').AsString := Self.F_nome;
    Qry.ParamByName('senha').AsString := Self.F_Senha;
    Qry.ParamByName('perfilId').AsInteger := Self.F_perfilId;

    Qry.Open;

    Self.F_usuarioId := Qry.Fields[0].AsInteger;

    ConexaoDB.Commit;
    Result := True;

  except
    ConexaoDB.Rollback;
    raise;
  end;

  Qry.Free;
end;

function TUsuario.Selecionar(id: Integer): Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId,'+
                '       nome, '+
                '       perfilId, '+
                '       senha '+
                '  FROM usuarios '+
                ' WHERE usuarioId=:usuarioId');
    Qry.ParamByName('usuarioId').AsInteger:=id;
    Try
      Qry.Open;

      Self.F_usuarioId     := Qry.FieldByName('usuarioId').AsInteger;
      Self.F_nome          := Qry.FieldByName('nome').AsString;
      Self.F_senha         := Qry.FieldByName('senha').AsString;
      Self.F_perfilId      := Qry.FieldByName('perfilId').AsInteger;;
    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TUsuario.UsuarioExiste(aUsuario:String):Boolean;
var Qry:TFDQuery;
begin
  try
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(usuarioId) AS Qtde '+
                '  FROM usuarios '+
                ' WHERE nome =:nome ');
    Qry.ParamByName('nome').AsString :=aUsuario;
    Try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger>0 then
         result := true
      else
         result := false;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

{$ENDREGION}

{$region 'GET E SET'}
function TUsuario.getSenha: string;
begin
  result:= Descriptografar(Self.F_Senha);
end;

procedure TUsuario.setSenha(const value:string);
begin
  Self.F_senha := Criptografar(value);
end;
{$endregion}

{$region 'LOGIN'}
function TUsuario.Logar(aUsuario:String; aSenha:String):Boolean;
var Qry:TFDQuery;
begin
  try
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId, '+
                '       nome, '+
                '       senha '+
                '  FROM usuarios '+
                ' WHERE nome=:nome AND senha=:Senha');
    Qry.ParamByName('nome').AsString :=aUsuario;
    Qry.ParamByName('senha').AsString:=Criptografar(aSenha);
    Try
      Qry.Open;

      if Qry.FieldByName('usuarioId').AsInteger>0 then begin
         F_usuarioId := Qry.FieldByName('usuarioId').AsInteger;
         F_nome      := Qry.FieldByName('nome').AsString;
         F_senha     := Qry.FieldByName('senha').AsString;
         result:= True;
      end
      else
         result := false;

    Except
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;
{$endregion}

{$region 'ALTERAÇÃO DE SENHA'}
function TUsuario.AlterarSenha: Boolean;
var Qry:TFDQuery;
begin
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuarios '+
                '   SET senha =:senha '+
                ' WHERE usuarioId=:usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger       :=Self.F_usuarioId;
    Qry.ParamByName('senha').AsString            :=Self.F_Senha;

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
{$endregion}

end.

