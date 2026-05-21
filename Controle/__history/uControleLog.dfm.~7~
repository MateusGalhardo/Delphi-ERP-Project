inherited frmControleLog: TfrmControleLog
  Caption = 'Auditoria'
  ClientWidth = 1016
  ExplicitWidth = 1022
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl1: TPanel
    Width = 1016
    ExplicitWidth = 1016
    inherited lblIndice: TLabel
      Left = 5
      Top = 10
      ExplicitLeft = 5
      ExplicitTop = 10
    end
  end
  inherited pnl2: TPanel
    Width = 1016
    ExplicitWidth = 1016
    inherited btnFechar: TBitBtn
      Left = 937
      ExplicitLeft = 937
    end
  end
  inherited pnl3: TPanel
    Width = 1016
    ExplicitWidth = 1016
    inherited grdPesquisa: TDBGrid
      Width = 1014
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USUARIO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_HORA'
          Visible = True
        end>
    end
  end
  inherited QryListagem: TFDQuery
    Active = True
    SQL.Strings = (
      'select * from auditoria')
    Left = 676
    Top = 0
    object f1QryListagemID: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2QryListagemUSUARIO: TStringField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USUARIO'
      Size = 50
    end
    object f2QryListagemACAO: TStringField
      DisplayLabel = 'A'#231#227'o'
      FieldName = 'ACAO'
      Size = 50
    end
    object f2QryListagemTELA: TStringField
      DisplayLabel = 'Tela'
      FieldName = 'TELA'
      Size = 50
    end
    object f2QryListagemDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 255
    end
    object QryListagemDATA_HORA: TSQLTimeStampField
      DisplayLabel = 'Data/Hora'
      FieldName = 'DATA_HORA'
    end
  end
  inherited dtsListagem: TDataSource
    Left = 739
    Top = 0
  end
end
