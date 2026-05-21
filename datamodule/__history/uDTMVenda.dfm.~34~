object dtmVenda: TdtmVenda
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 292
  Width = 563
  object QryCliente: TFDQuery
    Connection = dtmConexao.ConexaoDB
    SQL.Strings = (
      'SELECT clienteId, nome, IDSituacao, observacao'
      'FROM clientes')
    Left = 104
    Top = 40
    object f1QryClienteclienteId: TFDAutoIncField
      FieldName = 'clienteId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2QryClientenome: TStringField
      FieldName = 'nome'
      Size = 60
    end
    object intgrfldQryClienteIDSituacao: TIntegerField
      FieldName = 'IDSituacao'
    end
    object f2QryClienteobservacao: TStringField
      FieldName = 'observacao'
      Size = 200
    end
  end
  object QryProdutos: TFDQuery
    Connection = dtmConexao.ConexaoDB
    SQL.Strings = (
      'SELECT produtoId,'
      '       nome,'
      '       valor,'
      '       quantidade'
      'FROM produtos')
    Left = 248
    Top = 40
    object f1QryProdutosprodutoId: TFDAutoIncField
      FieldName = 'produtoId'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object f2QryProdutosnome: TStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutosquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
    object fmtbcdfldQryProdutosvalor: TFMTBCDField
      FieldName = 'valor'
      currency = True
      Precision = 18
      Size = 5
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 80
    Top = 144
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 232
    Top = 144
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 152
    Top = 144
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 104
    object cdsItensVendaprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
    end
    object f2ItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Total do Produto'
      FieldName = 'valorTotalProduto'
      DisplayFormat = 'R$ #,##0.00'
      currency = True
    end
    object cdsItensVendavalorUnitario: TFloatField
      FieldName = 'valorUnitario'
      currency = True
    end
  end
  object QryUpdate: TFDQuery
    Connection = dtmConexao.ConexaoDB
    SQL.Strings = (
      'UPDATE clientes'
      'SET IDSituacao = :IDSituacao'
      'WHERE clienteId = :id')
    Left = 424
    Top = 32
    ParamData = <
      item
        Name = 'IDSITUACAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
