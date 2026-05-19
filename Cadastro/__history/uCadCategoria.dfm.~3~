inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel [0]
    Left = 120
    Top = 16
    Width = 16
    Height = 13
    Caption = 'lbl1'
  end
  object lbl2: TLabel [1]
    Left = 32
    Top = 16
    Width = 16
    Height = 13
    Caption = 'lbl2'
  end
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Color = clWhite
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        Columns = <
          item
            Expanded = False
            FieldName = 'categoriaId'
            Title.Caption = 'ID'#13#10
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            ReadOnly = True
            Width = 229
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object edtCategoriaId: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 40
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 96
        Width = 430
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 1
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
      'SELECT categoriaId,'
      '       descricao'
      'FROM categorias')
    Left = 572
    object f1ListagemcategoriaId: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2Listagemdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
end
