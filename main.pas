program socioTorcedorSantaCatarina;
uses crt;

const 
    TAMANHO_MAXIMO_FILA_SOCIOS     = 500;
    TAMANHO_MAXIMO_FILA_VISITANTES = 300;
    TAMANHO_MAXIMO_FILA_NORMAL     = 2200;

    TAMANHO_MAXIMO_ARQUIBANCADA    = 2000;
    TAMANHO_MAXIMO_GERAL           = 1000;

    QUANTIDADE_INGRESSOS_ARQUIBANCADA_SOCIOS     = 500;
    QUANTIDADE_INGRESSOS_ARQUIBANCADA_TORCEDORES = 1500;
    QUANTIDADE_INGRESSOS_GERAL_TORCEDORES        = 700;
    QUANTIDADE_INGRESSOS_GERAL_VISITANTES        = 300;

    VALOR_INGRESSO_ARQUIBANCADA_TORCEDORES = 100;
    VALOR_INGRESSO_GERAL_TORCEDORES        = 40; 
    VALOR_INGRESSO_GERAL_VISITANTES        = 80;   
    VALOR_INGRESSO_ARQUIBANCADA_SOCIOS     = 50;

    SOCIO     = 1;
    TORCEDOR  = 2;
    VISITANTE = 3;

    ARQUIBANCADA = 1;
    GERAL        = 2;

type
    arrayInteiros = array[1..5000] of integer;
    arrayBoleanos = array[1..2000] of boolean;

var 
    aFilaSocios     : arrayInteiros;
    aFilaVisitantes : arrayInteiros;
    aFilaNormal     : arrayInteiros;

    iOpcao : integer;

    iUltimaPosicaoFilaSocio     : integer;
    iUltimaPosicaoFilaVisitante : integer;
    iUltimaPosicaoFilaNormal    : integer;

    aPilhaIngressosArquibancadasSocios     : arrayInteiros;
    aPilhaIngressosArquibancadasTorcedores : arrayInteiros;
    aPilhaIngressosGeralTorcedores         : arrayInteiros;
    aPilhaIngressosGeralVisitantes         : arrayInteiros;

    iTopoPilhaArquibancadaSocios     : integer;
    iTopoPilhaArquibancadaTorcedores : integer;
    iTopoPilhaGeralTorcedores        : integer;
    iTopoPilhaGeralVisitantes         : integer;

    aAssentosArquibancada : arrayBoleanos;
    aAssentosGeral        : arrayBoleanos;

    iTotalArrecadadoArquibancadaSocios     : integer = 0;
    iTotalArrecadadoArquibancadaTorcedores : integer = 0;
    iTotalArrecadadoGeralTorcedores        : integer = 0;
    iTotalArrecadadoGeralVisitantes        : integer = 0;

    iContadorPessoasFilaSocio      : integer = 0;
    iContadorPessoasFilaVisitante  : integer = 0;
    iContadorPessoasFilaTorcedores : integer = 0;

procedure renderizaAssentos(var aAssentos: arrayBoleanos; iMaximoAssentos: integer);
var i: integer;
begin
  for i := 1 to iMaximoAssentos do
    aAssentos[i] := False;
end;

function isFilaVazia(iPosicao: integer): boolean;
begin   
    isFilaVazia := iPosicao = 0;
end;

function isFilaCheia(iPosicao, iTamanhoFila: integer): boolean;
begin   
    isFilaCheia := iPosicao >= iTamanhoFila;
end;

function isPilhaIngressoVazia(var iPosicaoTopo:integer): Boolean;
begin
    isPilhaIngressoVazia := (iPosicaoTopo = 0);
end;

procedure insereRegistroFila(var aFila: arrayInteiros; var iPosicao: integer; iTamanhoFila: integer; var iContadorPessoasFila : integer);
begin
  if not isFilaCheia(iPosicao, iTamanhoFila) then
    begin
        iPosicao := iPosicao + 1;
        iContadorPessoasFila := iContadorPessoasFila + 1;
        aFila[iPosicao] := iContadorPessoasFila; 
    end
  else 
    begin
        writeln('Fila cheia');
    end;
end;

procedure removeRegistroFila(var aFila: arrayInteiros; var iUltimaPosicaoFila: integer);
var i: integer;
begin
    if isFilaVazia(iUltimaPosicaoFila) then 
        begin
            writeln('Fila vazia');
        end
    else
        begin
            writeln('Removido da Fila');

            for i:= 1 to iUltimaPosicaoFila - 1 do
                aFila[i] := aFila[i + 1];

            iUltimaPosicaoFila := iUltimaPosicaoFila - 1;
        end;
end;

procedure inicializaPilhaIngressos(var aPilhaIngressos: arrayInteiros; iMaximoIngressos: integer; var iTopoPilha: integer);
var i: integer;
begin
    for i := 1 to iMaximoIngressos do
        aPilhaIngressos[i] := i;
    
    iTopoPilha := iMaximoIngressos;
end;

procedure removeRegistroPilha(var aPilhaIngressos: arrayInteiros; var iTopoPilha: integer);
begin
  if aPilhaIngressos[iTopoPilha] > 0 then
  begin
    aPilhaIngressos[iTopoPilha] := 0;
    iTopoPilha := iTopoPilha - 1;
  end
  else
  begin
    textcolor(red);
    Writeln('Ingressos Esgotados.');
  end;
end;

procedure consultarFila(aFila: arrayInteiros; iPosicao:integer);
var
    i: integer;
begin
    if isFilaVazia(iPosicao) 
    then
        WriteLn('Fila vazia.')
    else
    begin
        Write('Fila: [');
        for i := 1 to iPosicao do
        begin
            Write(aFila[i]);
            if i < iPosicao then
            Write(', ');
        end;
        WriteLn(']');
    end;
end;


function selecionaTipoAssento(var iOpcaoAssento: integer; iTipoPessoa: integer) : boolean;
var bErro: boolean; 
begin
    writeln;
    
    bErro := false;

    if(iTipoPessoa = SOCIO) then
    begin
        writeln('1 - Arquibancada');
    end
    else if(iTipoPessoa = TORCEDOR) then
    begin
        writeln('1 - Arquibancada');
        writeln('2 - Geral');
    end
    else
        writeln('2 - Geral');

    readln(iOpcaoAssento);
    
    while not (
        ((iOpcaoAssento  = ARQUIBANCADA) and (iTipoPessoa  = SOCIO)) or 
        (((iOpcaoAssento = ARQUIBANCADA) or  (iOpcaoAssento = GERAL)) and (iTipoPessoa = TORCEDOR)) or
        ((iOpcaoAssento  = GERAL)        and (iTipoPessoa   = VISITANTE))
    ) do
    begin
        writeln('Opção inválida! Escolha um tipo de Assento:');
        selecionaTipoAssento := true;
        exit;
    end;

    selecionaTipoAssento := bErro;
end;

function escolherAssento(var aAssentosArquibancada: arrayBoleanos; iMaximoAssentos: integer): boolean;
var 
    iAssentoEscolhido, i: integer;
begin
    writeln('Assentos disponíveis: ');
    for i := 1 to iMaximoAssentos do
        if not aAssentosArquibancada[i] then
            write(i, ' ');

    writeln;

    readln(iAssentoEscolhido);
    
    if (iAssentoEscolhido < 1) or (iAssentoEscolhido > iMaximoAssentos) then
    begin
        writeln('Número inválido! Escolha entre 1 e ', iMaximoAssentos, '.');
        escolherAssento := false;
    end;

    if aAssentosArquibancada[iAssentoEscolhido] = false then
    begin
        aAssentosArquibancada[iAssentoEscolhido] := true;
        writeln('Assento ', iAssentoEscolhido, ' reservado com sucesso!');
        escolherAssento := true;
    end
    else
    begin
        writeln('Assento ', iAssentoEscolhido, ' já foi utilizado!');
        escolherAssento := false;
    end;
end;

function geraVendaIngresso(var aPilhaIngressos: arrayInteiros; var iTopoPilha: integer; var aAssentos: arrayBoleanos; iQuantidadeAssentos: integer; var aFila: arrayInteiros; var iUltimaPosicaoFila: integer) : boolean;
begin
    geraVendaIngresso := false;

    if not isPilhaIngressoVazia(iTopoPilha) then
    begin
        if not escolherAssento(aAssentos, iQuantidadeAssentos) then
        begin
            geraVendaIngresso := true;
            exit;
        end;

        removeRegistroFila(aFila, iUltimaPosicaoFila);
        removeRegistroPilha(aPilhaIngressos, iTopoPilha);
    end
    else if isPilhaIngressoVazia(iTopoPilha) then
    begin
        geraVendaIngresso := true;
        WriteLn('Ingressos Esgotados.')
    end;
end;

procedure vendeIngressoConformeAtributos(var aFila: arrayInteiros; var iUltimaPosicaoFila: integer; iTipoPessoa: integer);
var iOpcaoAssento: integer; bErro: boolean;
begin
    if isFilaVazia(iUltimaPosicaoFila) then
        writeln('Fila vazia')
    else
    begin
        bErro := selecionaTipoAssento(iOpcaoAssento, iTipoPessoa);

        if bErro then
            exit;

        if((iOpcaoAssento = ARQUIBANCADA) and (iTipoPessoa = SOCIO)) then
        begin
            bErro := geraVendaIngresso(aPilhaIngressosArquibancadasSocios, iTopoPilhaArquibancadaSocios, aAssentosArquibancada, TAMANHO_MAXIMO_ARQUIBANCADA, aFila, iUltimaPosicaoFila);

            if not bErro then 
                iTotalArrecadadoArquibancadaSocios := iTotalArrecadadoArquibancadaSocios + VALOR_INGRESSO_ARQUIBANCADA_SOCIOS;
        end
        else if ((iOpcaoAssento = ARQUIBANCADA) and (iTipoPessoa = TORCEDOR)) then
        begin
            bErro := geraVendaIngresso(aPilhaIngressosArquibancadasTorcedores, iTopoPilhaArquibancadaTorcedores, aAssentosArquibancada, TAMANHO_MAXIMO_ARQUIBANCADA, aFila, iUltimaPosicaoFila);

            if not bErro then
                iTotalArrecadadoArquibancadaTorcedores := iTotalArrecadadoArquibancadaTorcedores + VALOR_INGRESSO_ARQUIBANCADA_TORCEDORES;
        end
        else if ((iOpcaoAssento = GERAL) and (iTipoPessoa = TORCEDOR)) then
        begin
            bErro := geraVendaIngresso(aPilhaIngressosGeralTorcedores, iTopoPilhaGeralTorcedores, aAssentosGeral, TAMANHO_MAXIMO_GERAL, aFila, iUltimaPosicaoFila);

            if not bErro then
                iTotalArrecadadoGeralTorcedores := iTotalArrecadadoGeralTorcedores + VALOR_INGRESSO_GERAL_TORCEDORES;
        end
        else if ((iOpcaoAssento = GERAL) and (iTipoPessoa = VISITANTE)) then
        begin
            bErro := geraVendaIngresso(aPilhaIngressosGeralVisitantes, iTopoPilhaGeralVisitantes, aAssentosGeral, TAMANHO_MAXIMO_GERAL, aFila, iUltimaPosicaoFila);
            
            if not bErro then
                iTotalArrecadadoGeralVisitantes := iTotalArrecadadoGeralVisitantes + VALOR_INGRESSO_GERAL_VISITANTES;
        end
    end;
end;

procedure exibirTotalArrecadado();
var iTotalRenda: integer;
begin
    iTotalRenda := iTotalArrecadadoArquibancadaSocios + iTotalArrecadadoArquibancadaTorcedores + iTotalArrecadadoGeralTorcedores + iTotalArrecadadoGeralVisitantes;

    textcolor(green);
    writeln('Total Arrecadado por Tipo de Ingresso:');
    writeln('Arquibancada Sócios: R$ ', iTotalArrecadadoArquibancadaSocios);
    writeln('Arquibancada Torcedores: R$ ', iTotalArrecadadoArquibancadaTorcedores);
    writeln('Geral Torcedores: R$ ', iTotalArrecadadoGeralTorcedores);
    writeln('Geral Visitantes: R$ ', iTotalArrecadadoGeralVisitantes);
    writeln('Total da Renda: R$ ', iTotalRenda);
end;

procedure renderizaMenu(var iOpcao: integer);
begin
    textcolor(blue);
    writeln ('    MENU    ');
    writeln ('------------');
    writeln;
    writeln ('1 - Adicionar na fila de Sócios');
    writeln ('2 - Adicionar na fila de Visitantes');
    writeln ('3 - Adicionar na fila de Normal');

    writeln ('4 - Ver Fila Sócios');
    writeln ('5 - Ver Fila Visitantes');
    writeln ('6 - Ver Fila Normal');

    writeln ('7 - Vender Fila Sócios');
    writeln ('8 - Vender Fila Visitantes');
    writeln ('9 - Vender Fila Normal');

    writeln('10 - Exibir Total Arrecadado');

    writeln ('11 - Sair');

    writeln;
    write('    ==> ');
    textcolor(red);
    readln (iOpcao);
    textcolor(blue);
end;

//Programa Principal
begin
    clrscr;

    inicializaPilhaIngressos(aPilhaIngressosArquibancadasSocios,     QUANTIDADE_INGRESSOS_ARQUIBANCADA_SOCIOS,     iTopoPilhaArquibancadaSocios);
    inicializaPilhaIngressos(aPilhaIngressosArquibancadasTorcedores, QUANTIDADE_INGRESSOS_ARQUIBANCADA_TORCEDORES, iTopoPilhaArquibancadaTorcedores);
    inicializaPilhaIngressos(aPilhaIngressosGeralTorcedores,         QUANTIDADE_INGRESSOS_GERAL_TORCEDORES,        iTopoPilhaGeralTorcedores);
    inicializaPilhaIngressos(aPilhaIngressosGeralVisitantes,         QUANTIDADE_INGRESSOS_GERAL_VISITANTES,        iTopoPilhaGeralVisitantes);

    renderizaAssentos(aAssentosArquibancada, TAMANHO_MAXIMO_ARQUIBANCADA);
    renderizaAssentos(aAssentosGeral,        TAMANHO_MAXIMO_GERAL);

    while iOpcao <> 11 do 
    begin
        renderizaMenu(iOpcao);
        if iOpcao = 1 then 
            begin
                insereRegistroFila(aFilaSocios, iUltimaPosicaoFilaSocio, TAMANHO_MAXIMO_FILA_SOCIOS, iContadorPessoasFilaSocio);
            end
        else if iOpcao = 2 then 
            begin
                insereRegistroFila(aFilaVisitantes, iUltimaPosicaoFilaVisitante, TAMANHO_MAXIMO_FILA_VISITANTES, iContadorPessoasFilaVisitante);
            end
        else if iOpcao = 3 then 
            begin
                insereRegistroFila(aFilaNormal, iUltimaPosicaoFilaNormal, TAMANHO_MAXIMO_FILA_NORMAL, iContadorPessoasFilaTorcedores);
            end
        else if iOpcao = 4 then 
            begin
                consultarFila(aFilaSocios, iUltimaPosicaoFilaSocio);
            end
        else if iOpcao = 5 then 
            begin
                consultarFila(aFilaVisitantes, iUltimaPosicaoFilaVisitante);
            end
        else if iOpcao = 6 then 
            begin
                consultarFila(aFilaNormal, iUltimaPosicaoFilaNormal);
            end
        else if iOpcao = 7 then 
            begin
                vendeIngressoConformeAtributos(aFilaSocios, iUltimaPosicaoFilaSocio, SOCIO);
            end
        else if iOpcao = 8 then 
            begin
                vendeIngressoConformeAtributos(aFilaVisitantes, iUltimaPosicaoFilaVisitante, VISITANTE);
            end
        else if iOpcao = 9 then 
            begin
                vendeIngressoConformeAtributos(aFilaNormal, iUltimaPosicaoFilaNormal,TORCEDOR);
            end
        else if iOpcao = 10 then
            begin
                exibirTotalArrecadado();
            end;
    end;
end.