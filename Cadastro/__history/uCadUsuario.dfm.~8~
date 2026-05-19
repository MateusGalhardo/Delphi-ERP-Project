inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ExplicitTop = -150
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'usuarioID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object btnExibir: TSpeedButton
        Left = 231
        Top = 176
        Width = 23
        Height = 22
        Caption = #55357#56595
        OnClick = btnExibirClick
      end
      object btnAleatorio: TSpeedButton
        AlignWithMargins = True
        Left = 28
        Top = 203
        Width = 45
        Height = 32
        Caption = #8634
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Layout = blGlyphTop
        ParentFont = False
        Spacing = 2
        OnClick = btnAleatorioClick
      end
      object lbl1: TLabel
        Left = 79
        Top = 211
        Width = 141
        Height = 16
        Caption = 'Gerar senha aleat'#243'ria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 312
        Top = 109
        Width = 85
        Height = 13
        Caption = 'Selecionar fun'#231#227'o'
      end
      object edtUsuarioId: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 56
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 128
        Width = 214
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Usu'#225'rio'
        MaxLength = 50
        TabOrder = 1
      end
      object edtSenha: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 176
        Width = 214
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 3
      end
      object lkpFuncao: TDBLookupComboBox
        Left = 312
        Top = 128
        Width = 145
        Height = 21
        KeyField = 'perfilId'
        ListField = 'descricao'
        ListSource = dsFuncao
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited dbnvgrNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited fdqryListagem: TFDQuery
    SQL.Strings = (
      'select usuarioID,'
      'nome,'
      'senha,'
      'perfilId'
      'from usuarios')
    object f1ListagemusuarioID: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2Listagemnome: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object f2Listagemsenha: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 40
    end
    object intgrfldListagemperfilId: TIntegerField
      FieldName = 'perfilId'
      Origin = 'perfilId'
    end
  end
  inherited dsListagem: TDataSource
    Left = 828
    Top = 24
  end
  object QryFuncao: TFDQuery
    Connection = dtmConexao.ConexaoDB
    SQL.Strings = (
      'SELECT perfilId, descricao FROM perfil')
    Left = 748
    Top = 104
    object f1QryFuncaoperfilId: TFDAutoIncField
      FieldName = 'perfilId'
      Origin = 'perfilId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2QryFuncaodescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Size = 50
    end
  end
  object dsFuncao: TDataSource
    DataSet = QryFuncao
    Left = 828
    Top = 104
  end
end
