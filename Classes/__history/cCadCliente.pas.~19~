unit cCadCliente;

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
  FireDAC.Comp.DataSet,
  uDTMconexao;

type
  TCliente = class
  private
    ConexaoDB:TFDConnection;
    F_clienteId:Integer;
    F_nome:String;
    F_endereco: string;
    F_cidade:String;
    F_bairro: String;
    F_estado: string;
    F_cep: String;
    F_telefone: string;
    F_email: string;
    F_dataNascimento: TDateTime;
    F_documento: string;
    F_observacao: string;
    F_IDSituacao: Integer;
    F_casa: string;

    procedure Validar;

  public
    constructor Create(aConexao:TFDConnection);
    destructor Destroy; override;

    procedure Limpar;

    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;

  published
    property codigo         :Integer    read F_clienteId      write F_clienteId;
    property nome           :string     read F_nome           write F_nome;
    property endereco       :string     read F_endereco       write F_endereco;
    property cidade         :string     read F_cidade         write F_cidade;
    property bairro         :string     read F_bairro         write F_bairro;
    property estado         :string     read F_estado         write F_Estado;
    property cep            :string     read F_cep            write F_Cep;
    property telefone       :string     read F_telefone       write F_telefone;
    property email          :string     read F_email          write F_email;
    property dataNascimento :TDateTime  read F_dataNascimento write F_dataNascimento;
    property documento      :string     read F_documento      write F_documento;
    property IDSituacao     :integer    read F_IDSituacao     write F_IDSituacao;
    property observacao     :string     read F_observacao     write F_observacao;
    property casa           :string     read F_casa           write F_casa;
  end;

implementation

{ TCategoria }

{$region 'Constructor and Destructor'}
constructor TCliente.Create(aConexao:TFDConnection);
begin
  ConexaoDB:=aConexao;
  Limpar;
end;

destructor TCliente.Destroy;
begin

  inherited;
end;
{$endRegion}

procedure TCliente.Validar;
begin
  if Trim(F_nome) = '' then
    raise Exception.Create('Nome é obrigatório');

  if F_IDSituacao = 0 then
    raise Exception.Create('Situação do cliente é obrigatória');
end;

procedure TCliente.Limpar;
begin
  F_clienteId := 0;
  F_nome := '';
  F_documento := '';
  F_observacao := '';
  F_IDSituacao := 0;
  F_endereco := '';
  F_cidade := '';
  F_bairro := '';
  F_estado := '';
  F_cep := '';
  F_telefone := '';
  F_email := '';
  F_dataNascimento := 0;
  F_casa := '';
end;

{$region 'CRUD'}
function TCliente.Apagar: Boolean;
var Qry:TFDQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Codigo: '+IntToStr(F_clienteId)+#13+
                'Descrição: '+F_nome,mtConfirmation,[mbYes, mbNo],0)<> mrYes then begin
     Result:=false;
     abort;
  end;

  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM clientes '+
                ' WHERE clienteId=:clienteId ');
    Qry.ParamByName('clienteId').AsInteger :=F_clienteId;
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

function TCliente.Atualizar: Boolean;
var Qry:TFDQuery;
begin
 Validar;
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE clientes '+
                '   SET nome            =:nome '+
                '       ,documento      =:documento '+
                '       ,endereco       =:endereco '+
                '       ,cidade         =:cidade '+
                '       ,IDSituacao     =:IDSituacao '+
                '       ,bairro         =:bairro '+
                '       ,casa           =:casa '+
                '       ,observacao     =:observacao '+
                '       ,estado         =:estado '+
                '       ,cep            =:cep '+
                '       ,telefone       =:telefone '+
                '       ,email          =:email '+
                '       ,dataNascimento =:dataNascimento '+
                ' WHERE clienteId=:clienteId ');
    Qry.ParamByName('clienteId').AsInteger       :=Self.F_clienteId;
    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('documento').AsString        :=Self.F_documento;
    Qry.ParamByName('IDSituacao').AsInteger      :=Self.F_IDSituacao;
    Qry.ParamByName('endereco').AsString         :=Self.F_endereco;
    Qry.ParamByName('cidade').AsString           :=Self.F_cidade;
    Qry.ParamByName('bairro').AsString           :=Self.F_bairro;
    Qry.ParamByName('casa').AsString             :=Self.F_casa;
    Qry.ParamByName('estado').AsString           :=Self.F_estado;
    Qry.ParamByName('cep').AsString              :=Self.F_cep;
    Qry.ParamByName('telefone').AsString         :=Self.F_telefone;
    Qry.ParamByName('email').AsString            :=Self.F_email;
    Qry.ParamByName('observacao').AsString       :=Self.F_observacao;
    Qry.ParamByName('dataNascimento').AsDateTime :=Self.F_dataNascimento;


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

function TCliente.Inserir: Boolean;
var Qry:TFDQuery;
begin
 Validar;
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO clientes (nome, '+
                '                      documento, '+
                '                      endereco, '+
                '                      IDSituacao, '+
                '                      cidade,  '+
                '                      bairro,  '+
                '                      casa,  '+
                '                      observacao,  '+
                '                      estado, '+
                '                      cep, '+
                '                      telefone, '+
                '                      email, '+
                '                      dataNascimento) '+
                ' VALUES              (:nome, '+
                '                      :documento, '+
                '                      :endereco, '+
                '                      :IDSituacao, '+
                '                      :cidade,  '+
                '                      :bairro,  '+
                '                      :casa,  '+
                '                      :observacao,  '+
                '                      :estado, '+
                '                      :cep, '+
                '                      :telefone, '+
                '                      :email, '+
                '                      :dataNascimento)' );

    Qry.ParamByName('nome').AsString             :=Self.F_nome;
    Qry.ParamByName('documento').AsString        :=Self.F_documento;
    Qry.ParamByName('IDSituacao').AsInteger      :=Self.F_IDSituacao;
    Qry.ParamByName('endereco').AsString         :=Self.F_endereco;
    Qry.ParamByName('cidade').AsString           :=Self.F_cidade;
    Qry.ParamByName('bairro').AsString           :=Self.F_bairro;
    Qry.ParamByName('casa').AsString             :=Self.F_casa;
    Qry.ParamByName('observacao').AsString       :=Self.F_observacao;
    Qry.ParamByName('estado').AsString           :=Self.F_estado;
    Qry.ParamByName('cep').AsString              :=Self.F_cep;
    Qry.ParamByName('telefone').AsString         :=Self.F_telefone;
    Qry.ParamByName('email').AsString            :=Self.F_email;
    Qry.ParamByName('dataNascimento').AsDateTime :=Self.F_dataNascimento;



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

function TCliente.Selecionar(id: Integer): Boolean;
var Qry:TFDQuery;
begin
 Limpar;
  try
    Result:=true;
    Qry:=TFDQuery.Create(nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT clienteId,'+
                '       nome, '+
                '       documento, '+
                '       IDSituacao, '+
                '       observacao, '+
                '       endereco, '+
                '       cidade, '+
                '       bairro, '+
                '       estado, '+
                '       casa, '+
                '       cep, '+
                '       telefone, '+
                '       email, '+
                '       dataNascimento '+
                '  FROM clientes '+
                ' WHERE clienteId=:clienteId');
    Qry.ParamByName('clienteId').AsInteger:=id;
    Try
      Qry.Open;

      Self.F_clienteId     := Qry.FieldByName('clienteId').AsInteger;
      Self.F_nome          := Qry.FieldByName('nome').AsString;
      Self.F_documento     := Qry.FieldByName('documento').AsString;
      Self.F_IDSituacao    := Qry.FieldByName('IDSituacao').AsInteger;
      Self.F_observacao    := Qry.FieldByName('observacao').AsString;
      Self.F_endereco      := Qry.FieldByName('endereco').AsString;
      Self.F_cidade        := Qry.FieldByName('cidade').AsString;
      Self.F_bairro        := Qry.FieldByName('bairro').AsString;
      Self.F_casa          := Qry.FieldByName('casa').AsString;
      Self.F_estado        := Qry.FieldByName('estado').AsString;
      Self.F_cep           := Qry.FieldByName('cep').AsString;
      Self.F_telefone      := Qry.FieldByName('telefone').AsString;
      Self.F_email         := Qry.FieldByName('email').AsString;
      Self.F_dataNascimento:= Qry.FieldByName('dataNascimento').AsDateTime;

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
