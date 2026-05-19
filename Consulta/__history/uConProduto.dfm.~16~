inherited frmConProduto: TfrmConProduto
  Caption = 'Pesquisa de Produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl3: TPanel
    inherited grdPesquisa: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'produtoId'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_final'
          Title.Caption = 'Valor'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Width = 64
          Visible = True
        end>
    end
  end
  inherited QryListagem: TFDQuery
    Active = True
    SQL.Strings = (
      'select * from ('
      
        '  select produtoId, nome, ceiling(valor / 0.45) as valor_final, ' +
        'quantidade'
      '  from produtos) t'
      '')
    Left = 720
    Top = 272
    object f1QryListagemprodutoId: TFDAutoIncField
      FieldName = 'produtoId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2QryListagemnome: TStringField
      FieldName = 'nome'
      Size = 60
    end
    object fmtbcdfldQryListagemvalor_final: TFMTBCDField
      FieldName = 'valor_final'
      ReadOnly = True
      currency = True
      Precision = 23
      Size = 0
    end
    object fmtbcdfldQryListagemquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
  end
  inherited dtsListagem: TDataSource
    Left = 723
    Top = 192
  end
end
