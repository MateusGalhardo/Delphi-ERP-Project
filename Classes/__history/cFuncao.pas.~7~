unit cFuncao;

interface

uses
   IdUserAccounts, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
  FireDAC.Comp.Client, Vcl.Dialogs, System.SysUtils, uEnum, cAcaoAcesso, cUsuarioLogado,
  Vcl.Buttons, Vcl.Forms,RLReport, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Graphics,
  Vcl.ExtDlgs;

  type
  TFuncao = class
    private

    public
      class procedure CriarForm(aNomeForm:TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao: TFDConnection); static;
      class procedure CriarRelatorio(aNomeForm: TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao: TFDConnection); static;
      class procedure CarregarImagem(aImage: TImage); static;
      class procedure LimparImagem(var aImage: TImage); static;
  end;

implementation

class procedure TFuncao.CriarForm(aNomeForm:TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao: TFDConnection);
var form: TForm;
begin
  try
    form:= aNomeForm.Create(Application);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, form.Name, aConexao) then
    begin
      form.ShowModal;
    end
    else
    begin
      MessageDlg('Usuário: '+oUsuarioLogado.nome +' Não tem Permissão de Acesso',mtWarning,[mbOK],0);
    end;
  finally
     if Assigned(form) then
        form.Release;
  end;
end;

class procedure TFuncao.CriarRelatorio(aNomeForm:TFormClass; oUsuarioLogado: TUsuarioLogado; aConexao: TFDConnection);
var form: TForm;
    aRelatorio:TRLReport;
    i:Integer;
begin
  try
    form := aNomeForm.Create(Application);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, form.Name, aConexao) then
    begin;
      for I := 0 to form.ComponentCount-1 do
      begin
        if form.Components[i] is TRLReport then
        begin
          TRLReport(form.Components[i]).PreviewModal;
          Break;
        end;
      end;
    end
    else begin
      MessageDlg('Usuário: '+oUsuarioLogado.nome +', não tem permissão de acesso',mtWarning,[mbOK],0);
    end;
  finally
    if Assigned(form) then
       form.Release;
  end;
end;

class procedure TFuncao.CarregarImagem(aImage: TImage);
var Bmp, BmpTrans: TBitmap;
jpg: TJPEGImage;
Pic: TPicture;
Png: TPngImage;
opdSelecionar:TOpenPictureDialog;
iWidth:Integer;
iHeight:Integer;
begin
  try
    iWidth:=160;
    iHeight:=130;
    opdSelecionar:=TOpenPictureDialog.Create(nil);
    opdSelecionar.Filter :=
      'All (*.bmp;*.jpg;*.jpeg;*.png)|*.bmp;*.jpg;*.jpeg;*.png|' +
      'Bitmaps (*.bmp)|*.bmp|' +
      'JPEG Image File (*.jpg;*.jpeg)|*.jpg;*.jpeg|' +
      'PNG (*.png)|*.png';
    opdSelecionar.Title:='Selecione a Imagem';
    opdSelecionar.Execute;

    if opdSelecionar.FileName<>EmptyStr then begin
      if(Pos('.JPG',UpperCase(opdSelecionar.FileName))>0) or (Pos('.JPEG',UpperCase(opdSelecionar.FileName))>0) then begin
       Bmp:=TBitmap.Create;
       jpg:= TJPEGImage.Create;
       Pic:=TPicture.Create;
       try
         Pic.LoadFromFile(opdSelecionar.FileName);
         jpg.Assign(Pic);
         jpg.CompressionQuality:=7;
         Bmp.Width:=iWidth;
         Bmp.Height:=iheight;
         Bmp.Canvas.StretchDraw(Rect(0, 0, Bmp.Width, Bmp.Height), Jpg);
         aImage.Picture.Bitmap:=Bmp;
       finally
         Pic.Free;
         jpg.Free;
         Bmp.Free;
       end
      end
      else if Pos('.PNG',UpperCase(opdSelecionar.FileName))>0 then begin
       Bmp:=TBitmap.Create;
       Png:=TPngImage.Create;
       Pic:=TPicture.Create;
       try
         Pic.LoadFromFile(opdSelecionar.FileName);
         png.Assign(Pic);
         Bmp.Width:=iWidth;
         Bmp.Height:=iheight;
         Bmp.Canvas.StretchDraw(Rect(0, 0, Bmp.Width, Bmp.Height), png);
         aImage.Picture.Bitmap:=Bmp;
       finally
         Pic.Free;
         png.Free;
         Bmp.Free;
       end
      end
      else begin
        try
          Bmp:=TBitmap.Create;
          BmpTrans:=TBitmap.Create;
          Pic:=TPicture.Create;

          Pic.LoadFromFile(opdSelecionar.FileName);
          BmpTrans.Assign(Pic.Bitmap);
          Bmp.Width:=iWidth;
          Bmp.Height:=iheight;
          Bmp.Canvas.StretchDraw(Rect(0, 0, Bmp.Width, Bmp.Height), png);
          aImage.Picture.Bitmap:=Bmp;
        finally
          Pic.Free;
          BmpTrans.Free;
          Bmp.Free;
        end;
      end;
    end;
  finally
    FreeAndNil(opdSelecionar);
  end;
end;

class procedure TFuncao.LimparImagem(var aImage: TImage);
begin
   aImage.Picture.Assign(nil);
end;

end.
