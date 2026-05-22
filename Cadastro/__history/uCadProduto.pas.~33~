unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls, uConCategoria, Vcl.ComCtrls, RxToolEdit, RxCurrEdit, cCadProduto, uEnum, uDTMConexao, cFuncao,
   uCadCategoria, uFornecedor, Vcl.Menus, uConFornecedor;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    lbl1: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    lkpCategoria: TDBLookupComboBox;
    QryCategoria: TFDQuery;
    dtsCategoria: TDataSource;
    f1QryCategoriacategoriaId: TFDAutoIncField;
    f2QryCategoriadescricao: TStringField;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    btnIncluirCategoria: TSpeedButton;
    btnPesquisarCategoria: TSpeedButton;
    pnlImagem: TPanel;
    imgImagem: TImage;
    ppmImagem: TPopupMenu;
    mniCarregarImagem1: TMenuItem;
    mniLimparImagem1: TMenuItem;
    pnlImage: TPanel;
    imgProduto: TImage;
    lkpFornecedor: TDBLookupComboBox;
    btnIncluirFornecedor: TSpeedButton;
    QryFornecedor: TFDQuery;
    f1QryFornecedorfornId: TFDAutoIncField;
    f2QryFornecedornome: TStringField;
    dsFornecedor: TDataSource;
    f1ListagemprodutoId: TFDAutoIncField;
    f2Listagemnome: TStringField;
    f2Listagemdescricao: TStringField;
    fmtbcdfldListagemvalor: TFMTBCDField;
    fmtbcdfldListagemquantidade: TFMTBCDField;
    intgrfldListagemcategoriaId: TIntegerField;
    fdqryListagemfoto: TBlobField;
    intgrfldListagemfornId: TIntegerField;
    f2ListagemDescricaoCategoria: TStringField;
    lbl7: TLabel;
    btnPesquisarFornecedor: TSpeedButton;
    cbbUnidade: TComboBox;
    lbl8: TLabel;
    f2ListagemunidadeMedida: TStringField;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirCategoriaClick(Sender: TObject);
    procedure btnPesquisarCategoriaClick(Sender: TObject);
    procedure mniCarregarImagem1Click(Sender: TObject);
    procedure mniLimparImagem1Click(Sender: TObject);
    procedure dsListagemDataChange(Sender: TObject; Field: TField);
    procedure btnIncluirFornecedorClick(Sender: TObject);
    procedure btnPesquisarFornecedorClick(Sender: TObject);
    procedure mskPesquisarChange(Sender: TObject);
    procedure imgImagemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
  private
    { Private declarations }
    oProduto:TProduto;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
    function GetDesc: string; override;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

uses uPrincipal, uDTMVenda, uProVenda;

{$R *.dfm}

{$region 'Override'}
function TfrmCadProduto.Apagar: Boolean;
begin
  if oProduto.Selecionar(fdqryListagem.FieldByName('produtoId').AsInteger) then begin
     Result:=oProduto.Apagar;
  end;
end;

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;

begin
  if edtProdutoId.Text<>EmptyStr then
     oProduto.codigo:=StrToInt(edtProdutoId.Text)
  else
     oProduto.codigo:=0;

  oProduto.nome           :=edtNome.Text;
  oProduto.descricao      :=edtDescricao.Text;
  oProduto.categoriaId    :=lkpCategoria.KeyValue;
  oProduto.valor          :=edtValor.Value;
  oProduto.quantidade     :=edtQuantidade.Value;
  oProduto.fornId         :=lkpFornecedor.KeyValue;
  oProduto.unidadeMedida  :=cbbUnidade.Items[cbbUnidade.ItemIndex];

    if imgImagem.picture.BitMap.Empty then
     oProduto.Foto.Assign(nil)
    else
     oProduto.Foto.Assign(imgImagem.Picture);

  if (EstadoDoCadastro=ecInserir) then
     Result:=oProduto.Inserir
  else if (EstadoDoCadastro=ecAlterar) then
     Result:=oProduto.Atualizar;
end;
procedure TfrmCadProduto.grdListagemDblClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('produtoId').AsInteger = 0 then begin
    Exit;
  end;
  inherited;
end;

procedure TfrmCadProduto.imgImagemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var P: TPoint;
begin
  if Button = mbLeft then
  begin
    P := imgImagem.ClientToScreen(Point(X, Y));
    ppmImagem.Popup(P.X, P.Y);
  end;
end;

procedure TfrmCadProduto.mniCarregarImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.CarregarImagem(imgImagem);
end;

procedure TfrmCadProduto.mniLimparImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.LimparImagem(imgImagem);
end;

procedure TfrmCadProduto.mskPesquisarChange(Sender: TObject);
begin
  inherited;
end;

{$endregion}

procedure TfrmCadProduto.btnIncluirCategoriaClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmConexao.ConexaoDB);
  QryCategoria.Refresh;
end;

function TfrmCadProduto.GetDesc: string;
begin
  result := oProduto.nome;
end;

procedure TfrmCadProduto.btnIncluirFornecedorClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmFornecedor, oUsuarioLogado, dtmConexao.ConexaoDB);
  QryFornecedor.Refresh;
end;


procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('produtoId').AsInteger = 0 then begin
    Exit;
  end;

  if oProduto.Selecionar(fdqryListagem.FieldByName('produtoId').AsInteger) then begin
     edtProdutoId.Text         :=IntToStr(oProduto.codigo);
     edtNome.Text              :=oProduto.nome;
     edtDescricao.Text         :=oProduto.descricao;
     lkpCategoria.KeyValue     :=oProduto.categoriaId;
     edtValor.Value            :=oProduto.valor;
     edtQuantidade.Value       :=oProduto.quantidade;
     cbbUnidade.ItemIndex      :=cbbUnidade.Items.IndexOf(oProduto.unidadeMedida);
     lkpFornecedor.KeyValue    :=oProduto.fornId;
     imgImagem.Picture.Assign(oProduto.foto);
  end
  else begin
     btnCancelar.Click;
     Abort;
  end;
  inherited;

end;

procedure TfrmCadProduto.btnApagarClick(Sender: TObject);
begin
  if fdqryListagem.FieldByName('produtoId').AsInteger = 0 then begin
    Exit;
  end;
  inherited;
end;

procedure TfrmCadProduto.btnGravarClick(Sender: TObject);
var Qry: TFDQuery; Unidade: string;
begin
   Unidade := cbbUnidade.Text;

  if ((Unidade = 'Unidade') or (Unidade = 'Caixa') or (Unidade = 'Saco') or (Unidade = 'Pacote')) and
     (Frac(edtQuantidade.Value) <> 0) then
  begin                                                 //pra não permitir que os itens acima sejam quebrados
    ShowMessage('Essa unidade não permite valor fracionado.');
    edtQuantidade.SetFocus;
    Exit;
  end;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := dtmConexao.ConexaoDB;

    Qry.SQL.Text :=
      'SELECT produtoId ' +
      'FROM produtos ' +
      'WHERE UPPER(nome) = :nome ' +
      'AND fornId = :fornId';

    //se estiver alterando, ignora o próprio registro
    if edtProdutoId.Text <> '' then
      Qry.SQL.Add('AND produtoId <> :produtoId');

    Qry.ParamByName('nome').AsString :=
      UpperCase(Trim(edtNome.Text));

    if VarIsNull(lkpFornecedor.KeyValue) then begin
      showMessage('Selecione o fornecedor');
      lkpFornecedor.SetFocus;
      Exit;
    end;

    if VarIsNull(lkpCategoria.KeyValue) then begin
      ShowMessage('Selecione a categoria');
      lkpCategoria.SetFocus;
      Exit;
    end;

    Qry.ParamByName('fornId').AsInteger :=
      lkpFornecedor.KeyValue;

    if edtProdutoId.Text <> '' then
      Qry.ParamByName('produtoId').AsInteger :=
        StrToInt(edtProdutoId.Text);

    Qry.Open;

    if not Qry.IsEmpty then
    begin
      ShowMessage('Já existe um produto com esse nome para este fornecedor!');
      edtNome.SetFocus;
      Exit;
    end;

  finally
    Qry.Free;
  end;

  inherited;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
  imgImagem.Picture := nil;
  cbbUnidade.ItemIndex := -1;
end;

procedure TfrmCadProduto.btnPesquisarCategoriaClick(Sender: TObject);
begin
  inherited;
  Try
   frmConCategoria:=TfrmConCategoria.Create(Self);

   if lkpCategoria.KeyValue<>Null then
     frmConCategoria.aIniciarPesquisaId:=lkpCategoria.KeyValue;

   frmConCategoria.ShowModal;

   if frmConCategoria.aRetornarIdSelecionado<>Unassigned then
     lkpCategoria.KeyValue:=frmConCategoria.aRetornarIdSelecionado;
  Finally
   frmConCategoria.Release;
  end;
end;

procedure TfrmCadProduto.btnPesquisarFornecedorClick(Sender: TObject);
begin
  inherited;
  Try
   frmConFornecedor:=TfrmConFornecedor.Create(Self);

   if lkpFornecedor.KeyValue<>Null then
     frmConFornecedor.aIniciarPesquisaId:=lkpFornecedor.KeyValue;

   frmConFornecedor.ShowModal;

   if frmConFornecedor.aRetornarIdSelecionado<>Unassigned then
     lkpFornecedor.KeyValue:=frmConFornecedor.aRetornarIdSelecionado;
  Finally
   frmConFornecedor.Release;
  end;
end;

procedure TfrmCadProduto.dsListagemDataChange(Sender: TObject; Field: TField);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
begin
  if not dsListagem.DataSet.Active then Exit;

  if (dsListagem.DataSet.FieldByName('foto') = nil) or
     dsListagem.DataSet.FieldByName('foto').IsNull then
  begin
    imgProduto.Picture := nil;

    pnlImage.Visible := False;

    grdListagem.Align := alClient;
  end
  else
  begin
    pnlImage.Visible := True;

    pnlImage.Align := alRight;
    pnlImage.Width := 200;

    grdListagem.Align := alClient;

    BlobField := dsListagem.DataSet.FieldByName('foto') as TBlobField;
    Stream := TMemoryStream.Create;
    try
      BlobField.SaveToStream(Stream);
      Stream.Position := 0;
      imgProduto.Picture.Bitmap.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
    QryCategoria.Close;
    if Assigned(oProduto) then
       FreeAndNil(oProduto);
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
    oProduto:=TProduto.Create(dtmConexao.ConexaoDB);
    IndiceAtual:='nome';
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
    QryCategoria.Open;
    QryFornecedor.Open;
end;

end.

