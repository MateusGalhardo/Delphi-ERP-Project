unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.ComCtrls, uDTMconexao, uDTMVenda, RxToolEdit, RxCurrEdit, uEnum, cProVenda, Data.SqlTimSt, cFuncao, System.IniFiles, math;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    edtValorTotal: TCurrencyEdit;
    lbl3: TLabel;
    dbGridItensVenda: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    lbl4: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtTotalProduto: TCurrencyEdit;
    btnAdicionarItem: TBitBtn;
    btnApagarItem: TBitBtn;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtDataVenda: TDateEdit;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn4: TSpeedButton;
    f1ListagemvendaId: TFDAutoIncField;
    intgrfldListagemclienteId: TIntegerField;
    f2Listagemnome: TStringField;
    fdqryListagemdataVenda: TSQLTimeStampField;
    fmtbcdfldListagemtotalVenda: TFMTBCDField;
    QryExcel: TFDQuery;
    f1QryExcelcodVenda: TFDAutoIncField;
    f2QryExcelnomeCliente: TStringField;
    f2QryExcelnomeProduto: TStringField;
    f1QryExcelcodProduto: TFDAutoIncField;
    fmtbcdfldQryExcelQuantidade: TFMTBCDField;
    btnExcel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridItensVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnApagarItemClick(Sender: TObject);
    procedure dbGridItensVendaDblClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure lkpClienteCloseUp(Sender: TObject);
    procedure dbGridItensVendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure pnl2Click(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure mskPesquisarExit(Sender: TObject);
  private
    { Private declarations }
    dtmVenda:TdtmVenda;
    oVenda:TVenda;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function Apagar:Boolean; override;
    function TotalizarProduto(ValorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
    function GetDesc: string; override;
    procedure ExportarCSV(ADataset: TDataSet);
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

uses
  uRelProVenda, uCadCliente, cUsuarioLogado, uPrincipal, uCadProduto, uConCategoria, uConCliente, uConProduto, cControleEstoque;

{$R *.dfm}

{$region 'Override'}
function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(fdqryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
  Result:=oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean;
begin
  if edtVendaId.Text<>EmptyStr then
     oVenda.VendaId:=StrToInt(edtVendaId.Text)
  else
    oVenda.VendaId:= 0;

   oVenda.ClienteId         :=lkpCliente.KeyValue;
   oVenda.DataVenda         :=edtDataVenda.Date;
   oVenda.TotalVenda        :=edtValorTotal.Value;

   if (EstadoDoCadastro=ecInserir) then
      oVenda.vendaId := oVenda.Inserir(dtmVenda.cdsItensVenda)
   else if (EstadoDoCadastro=ecAlterar) then
      oVenda.Atualizar(dtmVenda.cdsItensVenda);

   frmRelProVenda:=TfrmRelProVenda.Create(self);
  frmRelProVenda.QryVendas.Close;
  frmRelProVenda.QryVendas.ParamByName('VendaId').AsInteger:= oVenda.VendaId;
  frmRelProVenda.QryVendas.Open;

  frmRelProVenda.QryVendasItens.Close;
  frmRelProVenda.QryVendasItens.ParamByName('VendaId').AsInteger:= oVenda.VendaId;
  frmRelProVenda.QryVendasItens.Open;

  frmRelProVenda.Relatorio.PreviewModal;
  frmRelProVenda.Release;
  result:= true;
end;

procedure TfrmProVenda.lkpClienteCloseUp(Sender: TObject);
var Situacao: Integer; Observacao: string;
begin
  Situacao := dtmVenda.QryCliente.FieldByName('IDSituacao').AsInteger;

  if Situacao = 3 then
  begin
    Observacao := dtmVenda.QryCliente.FieldByName('observacao').AsString;

    if Observacao <> '' then
      ShowMessage('Observação para o cliente:' + sLineBreak + Observacao)
    else
      ShowMessage('Cliente marcado como Atenção' +sLineBreak + 'Sem Observações');
  end;

   if(dtmVenda.QryCliente.FieldByName('IDSituacao').AsInteger = 4) then
  begin
    ShowMessage('Cliente Inativo!');
    lkpCliente.KeyValue:='';
  end;

   if(dtmVenda.QryCliente.FieldByName('IDSituacao').AsInteger = 2) then
  begin
    if Observacao <> '' then
    begin
      ShowMessage('Cliente Bloqueado por: ' + sLineBreak + Observacao);
      lkpCliente.KeyValue:='';
    end
    else  begin
      ShowMessage('Cliente Bloqueado!' + sLineBreak+ 'Sem Observações');
      lkpCliente.KeyValue:='';
    end;
  end;
end;

procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  if TDBLookupComboBox(Sender).KeyValue<>Null then begin
     edtValorUnitario.Value:=dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
     edtValorUnitario.value:= Ceil(edtValorUnitario.Value / 0.45);
     edtQuantidade.Value:=1;
     edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
  end;
end;

procedure TfrmProVenda.mskPesquisarExit(Sender: TObject);
var date:TDateTime;
begin
  if IndiceAtual = 'dataVenda' then begin
   if mskPesquisar.Text <> '' then begin
    if (Length(SomenteNumeros(mskPesquisar.Text)) < 8)  or (not TryStrToDate(mskPesquisar.Text, date)) then begin
      ShowMessage('Digite uma data válida ou completa');
      mskPesquisar.SetFocus;
    end;
   end;
  end;
end;

procedure TfrmProVenda.pnl2Click(Sender: TObject);
begin
  inherited;

end;

{$endregion}
procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('vendaId').AsInteger = 0 then begin
    Exit;
  end;

  if oVenda.Selecionar(fdqryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
     edtVendaId.Text     :=IntToStr(oVenda.VendaId);
     lkpCliente.KeyValue :=oVenda.ClienteId;
     edtDataVenda.Date   :=oVenda.DataVenda;
     edtValorTotal.Value :=oVenda.TotalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

function TfrmProVenda.GetDesc: string;
begin
  result := IntToStr(oVenda.VendaId);
end;

procedure TfrmProVenda.btnApagarClick(Sender: TObject);
var QrySelect, QryUpdate: TFDQuery;
begin
  if fdqryListagem.FieldByName('vendaId').AsInteger = 0 then begin
    Exit;
  end;

  if MessageDlg('Apagar o Registro?', mtConfirmation,[mbYes, mbNo],0) = mrYes then
  begin
  if MessageDlg('Deseja retornar os produtos ao estoque?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    QrySelect := TFDQuery.Create(nil);
    QryUpdate := TFDQuery.Create(nil);
    try
      QrySelect.Connection := dtmConexao.ConexaoDB;
      QryUpdate.Connection := dtmConexao.ConexaoDB;

      dtmConexao.ConexaoDB.StartTransaction;
      try
        QrySelect.SQL.Text :=
          'SELECT produtoId, quantidade ' +
          'FROM vendasItens ' +
          'WHERE vendaId = :vendaId';

        QrySelect.ParamByName('vendaId').AsInteger := fdqryListagem.FieldByName('vendaId').AsInteger;
        QrySelect.Open;

        while not QrySelect.Eof do
        begin
          QryUpdate.SQL.Text :=
            'UPDATE produtos ' +
            'SET quantidade = quantidade + :qtde ' +
            'WHERE produtoId = :produtoId';

          QryUpdate.ParamByName('produtoId').AsInteger :=
            QrySelect.FieldByName('produtoId').AsInteger;

          QryUpdate.ParamByName('qtde').AsFloat :=
            QrySelect.FieldByName('quantidade').AsFloat;

          QryUpdate.ExecSQL;

          QrySelect.Next;
        end;

        dtmConexao.ConexaoDB.Commit;
      except
        dtmConexao.ConexaoDB.Rollback;
        raise;
      end;

    finally
      QrySelect.Free;
      QryUpdate.Free;
    end;
  end;

  inherited;

end;

end;
procedure TfrmProVenda.btnApagarItemClick(Sender: TObject);
var Qry:TFDQuery;
begin
  inherited;
  if lkpProduto.KeyValue=Null then begin
     MessageDlg('Selecione o Produto a ser excluído', mtInformation,[mbOK],0);
     dbGridItensVenda.SetFocus;
     Abort;

  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
     dtmVenda.cdsItensVenda.Delete;
     edtValorTotal.Value:=TotalizarVenda;
     LimparComponenteItem;
  end;

end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnExcelClick(Sender: TObject);
begin
  inherited;
  QryExcel.Open();
  ExportarCSV(QryExcel);
  QryExcel.Close;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  if (dtmVenda.QryCliente.FieldByName('IDSituacao').AsInteger = 5)then
  begin
    if MessageDlg('Cliente selecionado é Prospecto, deseja tornar o cliente ativo?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      with dtmVenda.QryUpdate do
      begin
        SQL.Text := 'UPDATE clientes SET IDSituacao = :IDSituacao WHERE clienteId = :id';
        ParamByName('IDSituacao').AsInteger := 1;
        ParamByName('id').AsInteger := dtmVenda.QryCliente.FieldByName('clienteId').AsInteger;
        ExecSQL;
      end;

      ShowMessage('Cliente atualizado para ATIVO!');

      dtmVenda.QryCliente.Close;
      dtmVenda.QryCliente.Open;
    end
    else
      lkpCliente.KeyValue:='';
  end;

  if MessageDlg('Tem certeza que deseja realizar esta venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if dtmVenda.cdsItensVenda.IsEmpty then
   begin
    MessageDlg('Adicione pelo menos um item à venda', mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    Abort;
   end
   else if
   lkpCliente.Text = '' then begin
    ShowMessage('Selecione um cliente');
    lkpCliente.SetFocus;
    abort;
  end
   else
    ShowMessage('Venda realizada!');
  end
  else Abort;

  if dtmVenda.cdsItensVenda.IsEmpty then
  begin
    MessageDlg('Adicione pelo menos um item à venda', mtInformation, [mbOK], 0);
    lkpProduto.SetFocus;
    Abort;
  end;

  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btn1Click(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, dtmConexao.ConexaoDB);
  dtmVenda.QryCliente.close;
  dtmVenda.QryCliente.Open;

end;

procedure TfrmProVenda.btn2Click(Sender: TObject);
begin
  inherited;
  Try
   frmConCliente:=TfrmConCliente.Create(Self);

   if lkpCliente.KeyValue<>Null then
     frmConCliente.aIniciarPesquisaId:=lkpCliente.KeyValue;

   frmConCliente.ShowModal;

   if frmConCliente.aRetornarIdSelecionado<>Unassigned then
     lkpCliente.KeyValue:=frmConCliente.aRetornarIdSelecionado;
  Finally
   frmConCliente.Release;
  end;
end;

procedure TfrmProVenda.btn3Click(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmConexao.ConexaoDB);
  dtmVenda.QryProdutos.close;
  dtmVenda.QryProdutos.Open;
end;

procedure TfrmProVenda.btn4Click(Sender: TObject);
begin
  inherited;
   Try
   frmConProduto:=TfrmConProduto.Create(Self);

   if lkpProduto.KeyValue<>Null then
     frmConProduto.aIniciarPesquisaId:=lkpProduto.KeyValue;

     frmConProduto.ShowModal;

   if frmConProduto.aRetornarIdSelecionado<>Unassigned then
     lkpProduto.KeyValue:=frmConProduto.aRetornarIdSelecionado;
  Finally
   frmConProduto.Release;
  end;
end;

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
var estoque: Integer; qntDigitada: Integer;
begin
     inherited;

  if lkpProduto.Text ='' then begin
    MessageDlg('Produto é um campo obrigatório',mtInformation,[mbOK],0);
    lkpProduto.SetFocus;
    Abort;
  end
  else begin
  estoque := dtmVenda.QryProdutos.FieldByName('quantidade').AsInteger;
  qntDigitada:= StrToInt(edtQuantidade.Text);

  if qntDigitada = estoque then
  begin
   MessageDlg('Após está venda o estoque será zerado!!',  mtWarning,[mbOK],0);
  end;

  if(qntDigitada > estoque) then begin
     MessageDlg('Quantidade Digitada Maior que o Estoque'  +
               ' (Estoque Atual: ' +IntToStr(estoque) + ' Unidades)',mtError,[mbOK],0);
     Abort;
  end
  else begin
    dtmVenda.QryProdutos.Close;
    dtmVenda.QryProdutos.Open;
  end;

  if edtValorUnitario.Value <= 0 then begin
     MessageDlg('Valor Unitário não pode ser zero',mtInformation, [mbOk],0);
     edtValorUnitario.SetFocus;
     Abort;
  end;

  if edtQuantidade.Value <= 0 then begin
     MessageDlg('Quantidade não pode ser zero',mtInformation, [mbOK],0);
     edtQuantidade.SetFocus;
     Abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId',lkpProduto.KeyValue, []) then begin
     MessageDlg('Este Produto já foi selecionado',mtInformation,[mbOK],0);
     lkpProduto.SetFocus;
     Abort;
  end;

  edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString:=lkpProduto.KeyValue;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString:=dtmVenda.QryProdutos.FieldByName('nome').AsString;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat:=edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat:=edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat:=edtTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;
  edtValorTotal.Value:=TotalizarVenda;
  LimparComponenteItem;
  lkpProduto.SetFocus;

  end;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.Keyvalue    :=Null;
  edtQuantidade.Value    :=0;
  edtValorUnitario.Value :=0;
  edtTotalProduto.Value  :=0;
end;

function TfrmProVenda.TotalizarProduto(ValorUnitario, Quantidade:Double):Double;
begin
  result :=valorUnitario * Quantidade;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
            dtmVenda.cdsItensVenda.Delete;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  dtmVenda.QryProdutos.Close;
  dtmVenda.QryProdutos.Open;
  edtDataVenda.Date:=Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.dbGridItensVendaDblClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('vendaId').AsInteger = 0 then begin
    Exit;
  end;

  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dbGridItensVendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
State: TGridDrawState);
var Linha: Integer;
begin
  if (gdFixed in State) then
  begin
    dbGridItensVenda.Canvas.Brush.Color := clGray;
    dbGridItensVenda.Canvas.FillRect(Rect);

    Exit;
  end;


  Linha := dbGridItensVenda.DataSource.DataSet.RecNo;

  if not (gdSelected in State) then
  begin
    if (Linha mod 2) = 0 then
      dbGridItensVenda.Canvas.Brush.Color := clWebLightgrey
    else
      dbGridItensVenda.Canvas.Brush.Color := clWhite;
  end
  else
  begin
    dbGridItensVenda.Canvas.Brush.Color := clHighlight;
    dbGridItensVenda.Canvas.Font.Color := clHighlightText;
  end;

  dbGridItensVenda.Canvas.FillRect(Rect);
  dbGridItensVenda.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.AsString);

  if Column.FieldName = 'valorUnitario' then
  begin
    dbGridItensVenda.Canvas.FillRect(Rect);

    dbGridItensVenda.Canvas.TextOut(
      Rect.Left + 2,
      Rect.Top + 2,
      FormatFloat('R$ #,##0.00', Column.Field.AsFloat)
    );
  end;

  if Column.FieldName = 'valorTotalProduto' then
  begin
    dbGridItensVenda.Canvas.FillRect(Rect);

    dbGridItensVenda.Canvas.TextOut(
      Rect.Left + 2,
      Rect.Top + 2,
      FormatFloat('R$ #,##0.00', Column.Field.AsFloat)
    );
  end;
end;

procedure TfrmProVenda.ExportarCSV(ADataset: TDataSet);
var Lista: TStringList; UltimaVenda: string;
begin
  Lista := TStringList.Create;
  try
    Lista.Add('CodVenda;NomeCliente;NomeProduto;CodProduto;Quantidade');
    UltimaVenda := '';

    ADataset.First;
    while not ADataset.Eof do
    begin

      if (UltimaVenda <> '') and
         (UltimaVenda <> ADataset.FieldByName('codVenda').AsString) then
      begin
        Lista.Add('');
      end;
      Lista.Add(
        ADataset.FieldByName('codVenda').AsString + ';' +
        ADataset.FieldByName('nomeCliente').AsString + ';' +
        ADataset.FieldByName('nomeProduto').AsString + ';' +
        ADataset.FieldByName('codProduto').AsString + ';' +
        ADataset.FieldByName('Quantidade').AsString );

      UltimaVenda := ADataset.FieldByName('codVenda').AsString;

      ADataset.Next;
    end;
    Lista.SaveToFile('C:\Users\devmv\Desktop\Planilha.csv');
  finally
    Lista.Free;
  end;
end;

procedure TfrmProVenda.dbGridItensVendaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
   BloqueiaCTRL_DEL_DBGrid(Key,Shift);
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotalProduto.Value:=TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
var ArquivoINI:TIniFile; I: Integer;
begin
  inherited;
  if Assigned(dtmVenda)
  then FreeAndNil(dtmVenda);

  if Assigned(oVenda)
  then FreeAndNil(oVenda);

  ExtractFilePath(Application.ExeName);
  ArquivoINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'PreferenciasGridVendas.ini');

  try
    for I := 0 to dbgridItensVenda.Columns.Count - 1 do
    begin
      ArquivoINI.WriteInteger(
      oUsuarioLogado.nome,
      'Coluna_' + IntToStr(I),
      dbgridItensVenda.Columns[I].Width);
    end;
  finally
    ArquivoINI.Free;
  end;

  fdqryListagem.Close;
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
var i: Integer;
begin
  inherited;
  QryExcel.Active := True;
  fdqryListagem.Active:= True;
    dbGridItensVenda.TitleFont.Color:=clWhite;

    for i := 0 to dbGridItensVenda.Columns.Count - 1 do
    dbGridItensVenda.Columns[i].Title.Alignment := taCenter;

    dtmVenda:=TdtmVenda.Create(Self);
    oVenda:=TVenda.Create(dtmConexao.ConexaoDB);
    IndiceAtual:= 'clienteId';
end;

procedure TfrmProVenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue     :=dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value     :=dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value  :=dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtTotalProduto.Value   :=dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

function TfrmProVenda.TotalizarVenda:Double;
begin
  Result:=0;
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do begin
    result := result + dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVenda.cdsItensVenda.Next;
  end;
end;

end.
