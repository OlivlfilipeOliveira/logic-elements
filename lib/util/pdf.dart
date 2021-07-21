import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PDF{

  Future<File> geraPdfFormulas(List<dynamic> formulas, String atomosMin, String atomosMax, String quantidadeAtomos, String quantidadeFbfs, String operadores, String quantidadeListas, String selectOperator) async{


    Document pdf = _montarPDFFormulas(formulas, atomosMin, atomosMax, quantidadeAtomos, quantidadeFbfs, operadores, quantidadeListas, selectOperator);


    Directory dir = await getTemporaryDirectory();
  //Directory dir = await DownloadsPathProvider.downloadsDirectory;
    String data = DateTime.now().toString();
    String nomeData = "";
    for(int i = 0; i<data.length; ++i){
      if(data[i]==" " || data[i]==":" || data[i]=="." || data[i]=="-"){
        nomeData+= "";
      }else{
        nomeData += data[i];
      }
    }
    String nome = "questoes_formulas"+nomeData;

    File pdfFile = new File("${dir.path}/$nome.pdf");

    if (!await pdfFile.exists()) {
      await pdfFile.create(recursive: true);
      pdfFile.writeAsBytesSync(await pdf.save());
    }
    return pdfFile;

  }

  Document _montarPDFFormulas(List<dynamic> formulas, String atomosMin, String atomosMax, String quantAtomos, String quantidadeFbfs, String operadores, String quantidadeListas, String selectOperator) {
    final Document pdf = Document(deflate: zlib.encode);

    List<Paragraph> paragrafos = _gerarLinhasFormulas(formulas, atomosMin, atomosMax, quantAtomos,  quantidadeFbfs, operadores, quantidadeListas, selectOperator);
     
    pdf.addPage(MultiPage(
    pageFormat:
    PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
            decoration: BoxDecoration(
                border: Border.all(color: PdfColors.grey, width: 0.5, )
                    //bottom: true, width: 0.5, color: PdfColors.grey)
            ),
            child: Text('LogicElements',
                style: Theme
                    .of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.grey)));
      },
      footer: (Context context) {
        return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('<- Page ${context.pageNumber} ->',
                style: Theme
                    .of(context)
                    .defaultTextStyle
                    .copyWith(color: PdfColors.black), textAlign: TextAlign.center));
      },
        build: (Context context) => paragrafos
        ));
    return pdf;
  }

  List<Paragraph> _gerarLinhasFormulas(List<dynamic> formulas, String atomosMin, String atomosMax, String quantAtomos, String quantFbfs, String operadores, String quantListas, String selectOperator){
    int quantidadeFbfs = int.parse(quantFbfs);
    int quantListasConvert = int.parse(quantListas);

    List<Paragraph> paragrafos = List();

    int contadorListas = 0;
    int listas = 1;
    Paragraph p = Paragraph(
        text: "Listas de exercícios contendo fórmulas geradas com o LogicElements", style: TextStyle(font: Font.courierBold(), fontSize: 25.0), textAlign: TextAlign.center );
    paragrafos.add(p);


    //Relatório de configurações
    Paragraph relatorio = Paragraph(
        text: "Relatório de configurações: ", style: TextStyle(font: Font.courierBold(), fontSize: 20.0), textAlign: TextAlign.left );
    paragrafos.add(relatorio);
    if(quantAtomos=="0"){
      Paragraph relatorio1 = Paragraph(
          text: "Quantidade de átomos: $quantAtomos", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
      paragrafos.add(relatorio1);
    }else{
      Paragraph relatorio1 = Paragraph(
          text: "Quandidade mínima de átomos: $atomosMin", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
      Paragraph relatorio2 = Paragraph(
          text: "Quantidade máxima de átomos: $atomosMax", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
      paragrafos.add(relatorio1);
      paragrafos.add(relatorio2);
    }
    Paragraph relatorio1 = Paragraph(
        text: "Quantidade de FBFs: $quantidadeFbfs", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );

    Paragraph relatorio2;

    if(selectOperator=="1"){
      relatorio2 = Paragraph(
          text: "Operadores: exatamente -> $operadores", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
    }else if(selectOperator == "2"){
      relatorio2 = Paragraph(
          text: "Operadores: pelo menos -> $operadores", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
    }

    Paragraph relatorio3 = Paragraph(
        text: "Quantidade de listas de exercício: $quantListas", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
    paragrafos.add(relatorio1);
    paragrafos.add(relatorio2);
    paragrafos.add(relatorio3);

    Paragraph p1 = Paragraph(
        text: "\n\nLista 1 \n\n", textAlign: TextAlign.center, style: TextStyle(font: Font.courierBold(), fontSize: 20.0)
    );
    paragrafos.add(p1);

    for(int i = 0; i<formulas.length; ++i){
      Paragraph p = Paragraph(
          text: "${contadorListas+1} - ${formulas[i]['fbf']}\n", textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)
      );
      paragrafos.add(p);
      contadorListas += 1;

      if(contadorListas==quantidadeFbfs && listas!=quantListasConvert){
        listas += 1;
        Paragraph p = Paragraph(
            text: "Lista $listas \n\n", textAlign: TextAlign.center, style: TextStyle(font: Font.courierBold(), fontSize: 20.0)
        );
        paragrafos.add(p);
        contadorListas = 0;
      }
    }

    return paragrafos;
  }

  Future<File> geraPdfArgumentos(List<dynamic> arguments, String regras, String atomos, String listas, String quantArgumentos) async{

    Document pdf = _montarPDFArguments(arguments, regras, atomos, listas, quantArgumentos);

    Directory dir = await getTemporaryDirectory();
    String data = DateTime.now().toString();
    String nomeData = "";
    for(int i = 0; i<data.length; ++i){
      if(data[i]==" " || data[i]==":" || data[i]=="." || data[i]=="-"){
        nomeData+= "";
      }else{
        nomeData += data[i];
      }
    }
    String nome = "questoes_Argumentos"+nomeData;
    File pdfFile = new File("${dir.path}/$nome.pdf");

    if (!await pdfFile.exists()) {
      await pdfFile.create(recursive: true);
      pdfFile.writeAsBytesSync(await pdf.save());
    }
    return pdfFile;

  }

  Document _montarPDFArguments(List<dynamic> arguments, String regras, String atomos, String listas, String quantArgumentos){
    final Document pdf = Document(deflate: zlib.encode);

    List<Paragraph> paragrafos = _gerarLinhasArguments(arguments, regras, atomos, listas, quantArgumentos);

    pdf.addPage(MultiPage(
        pageFormat:
        PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        crossAxisAlignment: CrossAxisAlignment.start,
        header: (Context context) {
          if (context.pageNumber == 1) {
            return null;
          }
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: BoxDecoration(
                  border: Border.all(color: PdfColors.grey, width: 0.5, )
                //bottom: true, width: 0.5, color: PdfColors.grey)
              ),
              child: Text('LogicElements',
                  style: Theme
                      .of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        footer: (Context context) {
          return Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: Text('<- Page ${context.pageNumber} ->',
                  style: Theme
                      .of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.black), textAlign: TextAlign.center));
        },
        build: (Context context) => paragrafos
    ));
    return pdf;
  }

  List<Paragraph> _gerarLinhasArguments(List<dynamic> arguments, String regras, String atomos, String listasQuant, String quantArgumentos){
    int quantidadeArguments = int.parse(quantArgumentos);

    int quantListasConvert = int.parse(listasQuant);

    List<Paragraph> paragrafos = List();

    int contadorListas = 0;
    int listas = 1;
    Paragraph p = Paragraph(
        text: "Listas de exercícios contendo argumentos geradas com o LogicElements", style: TextStyle(font: Font.courierBold(), fontSize: 25.0), textAlign: TextAlign.center );
    paragrafos.add(p);


    //Relatório de configurações
    Paragraph relatorio = Paragraph(
        text: "Relatório de configurações: ", style: TextStyle(font: Font.courierBold(), fontSize: 20.0), textAlign: TextAlign.left );
    paragrafos.add(relatorio);

    Paragraph r = Paragraph(
        text: "Lista de regras de inferência escolhidas: $regras", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );

    Paragraph relatorio1 = Paragraph(
        text: "Quantidade de átomos diferentes: $atomos", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );

    Paragraph relatorio2 = Paragraph(
        text: "Quantidade de argumentos: $quantArgumentos", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );

    Paragraph relatorio3 = Paragraph(
        text: "Quantidade de listas de exercício: $listasQuant", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left );
    paragrafos.add(r);
    paragrafos.add(relatorio1);
    paragrafos.add(relatorio2);
    paragrafos.add(relatorio3);

    Paragraph p1 = Paragraph(
        text: "\n\nLista 1 \n\n", textAlign: TextAlign.center, style: TextStyle(font: Font.courierBold(), fontSize: 20.0)
    );
    paragrafos.add(p1);

    for(int i = 0; i<arguments.length; ++i){
      Paragraph p = Paragraph(
          text: "${contadorListas+1} - ${arguments[i]['argument']}\n", textAlign: TextAlign.left, style: TextStyle(fontSize: 15.0)
      );
      paragrafos.add(p);
      contadorListas += 1;

      if(contadorListas==quantidadeArguments && listas!=quantListasConvert){
        listas += 1;
        Paragraph p = Paragraph(
            text: "Lista $listas \n\n", textAlign: TextAlign.center, style: TextStyle(font: Font.courierBold(), fontSize: 20.0)
        );
        paragrafos.add(p);
        contadorListas = 0;
      }
    }

    return paragrafos;
  }


}