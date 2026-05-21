inherited frmFornecedor: TfrmFornecedor
  Caption = 'Cadastro de Fornecedor'
  ClientHeight = 581
  ClientWidth = 1131
  ExplicitTop = -51
  ExplicitWidth = 1137
  ExplicitHeight = 610
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 1131
    Height = 537
    ExplicitWidth = 1131
    ExplicitHeight = 537
    inherited tabListagem: TTabSheet
      ExplicitWidth = 1123
      ExplicitHeight = 509
      inherited pnlListagemTopo: TPanel
        Width = 1123
        ExplicitWidth = 1123
      end
      inherited grdListagem: TDBGrid
        Width = 1123
        Height = 453
        Columns = <
          item
            Expanded = False
            FieldName = 'fornId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cnpj'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'observacao'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'estado'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 1123
      ExplicitHeight = 509
      object lblTelefone: TLabel
        Left = 579
        Top = 242
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object lblCnpj: TLabel
        Left = 580
        Top = 139
        Width = 25
        Height = 26
        Caption = 'CNPJ'#13#10
      end
      object lblObservacao: TLabel
        Left = 56
        Top = 301
        Width = 58
        Height = 13
        Caption = 'Observa'#231#227'o'
      end
      object lblCEP: TLabel
        Left = 579
        Top = 87
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lblCEP1: TLabel
        Left = 214
        Top = 189
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object lblCEP2: TLabel
        Left = 56
        Top = 189
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object lblCEP3: TLabel
        Left = 371
        Top = 189
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object lbl10: TLabel
        Left = 493
        Top = 141
        Width = 12
        Height = 13
        Caption = 'N'#186
      end
      object lbl12: TLabel
        Left = 95
        Top = 187
        Width = 84
        Height = 13
        Caption = '(Preencha o CEP)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl13: TLabel
        Left = 248
        Top = 189
        Width = 84
        Height = 13
        Caption = '(Preencha o CEP)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl14: TLabel
        Left = 409
        Top = 189
        Width = 84
        Height = 13
        Caption = '(Preencha o CEP)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl15: TLabel
        Left = 106
        Top = 140
        Width = 84
        Height = 13
        Caption = '(Preencha o CEP)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 56
        Top = 104
        Width = 430
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtEndereco: TLabeledEdit
        Left = 56
        Top = 156
        Width = 430
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        ReadOnly = True
        TabOrder = 3
      end
      object edtTelefone: TEdit
        Left = 579
        Top = 256
        Width = 125
        Height = 21
        TabOrder = 10
        OnChange = edtTelefoneChange
      end
      object edtEmail: TLabeledEdit
        Tag = 2
        Left = 56
        Top = 256
        Width = 430
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        MaxLength = 100
        TabOrder = 9
      end
      object edtFornId: TLabeledEdit
        Tag = 1
        Left = 56
        Top = 48
        Width = 58
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtCNPJ: TEdit
        Left = 579
        Top = 156
        Width = 126
        Height = 21
        MaxLength = 18
        TabOrder = 5
        OnChange = edtCNPJChange
      end
      object edtObservacao: TEdit
        Left = 56
        Top = 320
        Width = 615
        Height = 97
        AutoSize = False
        TabOrder = 11
      end
      object edtBairro: TEdit
        Left = 220
        Top = 208
        Width = 145
        Height = 21
        ReadOnly = True
        TabOrder = 7
        OnChange = edtTelefoneChange
      end
      object edtCidade: TEdit
        Left = 56
        Top = 206
        Width = 145
        Height = 21
        ReadOnly = True
        TabOrder = 6
        OnChange = edtTelefoneChange
      end
      object edtEstado: TEdit
        Left = 371
        Top = 206
        Width = 115
        Height = 21
        ReadOnly = True
        TabOrder = 8
        OnChange = edtTelefoneChange
      end
      object edtNumero: TEdit
        Left = 492
        Top = 156
        Width = 53
        Height = 21
        MaxLength = 6
        TabOrder = 4
        OnChange = edtTelefoneChange
      end
      object mskCEP: TMaskEdit
        Left = 579
        Top = 104
        Width = 126
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
        OnChange = mskCEPChange
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 537
    Width = 1131
    ExplicitTop = 537
    ExplicitWidth = 1131
    inherited dbnvgrNavigator: TDBNavigator
      Hints.Strings = ()
    end
    inherited btnFechar: TBitBtn
      Left = 1041
      ExplicitLeft = 1041
    end
  end
  inherited fdqryListagem: TFDQuery
    SQL.Strings = (
      'select * from fornecedor')
    object f1ListagemfornId: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'fornId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2Listagemnome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 50
    end
    object f2Listagemcnpj: TStringField
      DisplayLabel = 'CNPJ'
      FieldName = 'cnpj'
      Size = 18
    end
    object f2Listagemendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Size = 50
    end
    object f2Listagemtelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 15
    end
    object f2Listagememail: TStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 50
    end
    object f2Listagemobservacao: TStringField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'observacao'
      Size = 100
    end
    object f2Listagemnumero: TStringField
      FieldName = 'numero'
      Origin = 'numero'
      Size = 10
    end
    object f2Listagembairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 50
    end
    object f2Listagemcidade: TStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 50
    end
    object f2Listagemestado: TStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Origin = 'estado'
      Size = 3
    end
    object f2Listagemcep: TStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
  end
end
