program socioTorcedorSantaCatarina;
uses crt;

const 
    TAMANHO_MAXIMO_FILA_SOCIOS     = 500;
    TAMANHO_MAXIMO_FILA_VISITANTES = 300;
    TAMANHO_MAXIMO_FILA_NORMAL     = 2200;

    TAMANHO_MAXIMO_ARQUIBANCADA    = 2000;
    TAMANHO_MAXIMO_GERAL           = 1000;

    QUANTIDADE_INGRESSOS_ARQUIBANCADA = 2000;
    QUANTIDADE_INGRESSOS_GERAL        = 700;
    QUANTIDADE_INGRESSOS_VISITANTE    = 300;

    VALOR_INGRESSO_ARQUIBANCADA = 100;
    VALOR_INGRESSO_GERAL        = 40; 
    VALOR_INGRESSO_VISITANTES   = 80;   

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

    aPilhaIngressosArquibancada : arrayInteiros;
    aPilhaIngressosGeral        : arrayInteiros;
    aPilhaIngressosVisitante    : arrayInteiros;

    iTopoPilhaArquibancada : integer;
    iTopoPilhaGeral        : integer;
    iTopoPilhaVisitante    : integer;

    aAssentosArquibancada : arrayBoleanos;
    aAssentosGeral        : arrayBoleanos;

    iTotalArrecadadoArquibancada : integer;
    iTotalArrecadadoSocios       : integer;
    iTotalArrecadadoGeral        : integer;
    iTotalArrecadadoVisitantes   : integer;
    iTotalRenda                  : integer;

procedure inicializaPilhaIngressos(var aPilhaIngressos: arrayInteiros; iMaximoIngressos: integer; var iTopoPilha: integer);
var i: integer;
begin
    for i := 1 to iMaximoIngressos do
        aPilhaIngressos[i] := i;
    
    iTopoPilha := iMaximoIngressos;
end;

procedure renderizaAssentos(var aAssentos: arrayBoleanos; iMaximoAssentos: integer);
var i: integer;
begin
  for i := 1 to iMaximoAssentos do
    aAssentos[i] := False;
end;

function isFilaCheia(iPosicao, iTamanhoFila: integer): boolean;
begin   
    isFilaCheia := iPosicao >= iTamanhoFila;
end;

function isFilaVazia(iPosicao: integer): boolean;
begin   
    isFilaVazia := iPosicao = 0;
end; 

procedure insereRegistroFila(var aFila: arrayInteiros; var iPosicao: integer; iTamanhoFila: integer);
begin
  if not isFilaCheia(iPosicao, iTamanhoFila) then
    begin
        iPosicao := iPosicao + 1;
        aFila[iPosicao] := iPosicao; 
    end
  else 
    begin
        writeln('Fila cheia');
        readkey;
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

function isPilhaIngressoVazia(var iPosicaoTopo:integer): Boolean;
begin
    isPilhaIngressoVazia := (iPosicaoTopo = 0);
end;

function alteraSituacaoAssento(var iPosicaoTopo: integer): boolean;
begin
    if isPilhaIngressoVazia(iPosicaoTopo) then
    begin
        WriteLn('Ingressos Esgotados.');
        alteraSituacaoAssento := false;
    end
    else
    begin
        iPosicaoTopo := iPosicaoTopo - 1;
        alteraSituacaoAssento := true;
    end;
end;

procedure selecionaTipoAssento(var iOpcaoAssento: integer; bArquibancada, bGeral, bVisitante: boolean);
begin
    writeln;
    if bArquibancada   then writeln('1 - Arquibancada');
    if bGeral          then writeln('2 - Geral');
    if bVisitante      then writeln('3 - Visitante');

    readln(iOpcaoAssento);
    
    while not (
        ((iOpcaoAssento = 1) and bArquibancada) or 
        ((iOpcaoAssento = 2) and bGeral) or 
        ((iOpcaoAssento = 3) and bVisitante)
    ) do
    begin
        writeln('Opção inválida! Escolha um tipo de Assento:');
        readln(iOpcaoAssento);
    end;
end;

function escolherAssento(var aAssentosArquibancada: arrayBoleanos; iMaximoAssentos: integer): boolean;
var iAssentoEscolhido, i: integer;
begin
    escolherAssento := false; 

    writeln('Assentos disponíveis: ');
    for i := 1 to iMaximoAssentos do
        if not aAssentosArquibancada[i] then
            write(i, ' ');

    writeln;

    readln(iAssentoEscolhido);
    
    if (iAssentoEscolhido < 1) or (iAssentoEscolhido > iMaximoAssentos) then
    begin
        writeln('Número inválido! Escolha entre 1 e ', iMaximoAssentos, '.');
        exit;
    end;

    if aAssentosArquibancada[iAssentoEscolhido] = False then
    begin
        aAssentosArquibancada[iAssentoEscolhido] := True;
        writeln('Assento ', iAssentoEscolhido, ' reservado com sucesso!');
        escolherAssento := true;
    end
    else
        writeln('Assento ', iAssentoEscolhido, ' já foi utilizado!');
end;

procedure geraVendaIngresso(var iTopoPilha: integer; var aAssentos: arrayBoleanos; iQuantidadeAssentos: integer; var aFila: arrayInteiros; var iUltimaPosicaoFila: integer);
begin
    if not isPilhaIngressoVazia(iTopoPilha) then
    begin
        if escolherAssento(aAssentos, iQuantidadeAssentos) then
        begin
            alteraSituacaoAssento(iTopoPilha);
            removeRegistroFila(aFila, iUltimaPosicaoFila);
        end
    end
    else
        WriteLn('Ingressos Esgotados.')
end;

procedure vendeIngressoFilaConformeAtributos(var aFila: arrayInteiros; var iUltimaPosicaoFila: integer; bArquibancada, bGeral, bVisitante: boolean);
var iOpcaoAssento: integer;
begin
    if isFilaVazia(iUltimaPosicaoFila) then
        writeln('Fila vazia')
    else
    begin
        selecionaTipoAssento(iOpcaoAssento, bArquibancada, bGeral, bVisitante);

        if (iOpcaoAssento = 1) and bArquibancada then
        begin
            geraVendaIngresso(iTopoPilhaArquibancada, aAssentosArquibancada, TAMANHO_MAXIMO_ARQUIBANCADA, aFila, iUltimaPosicaoFila);
        end
        else if (iOpcaoAssento = 2) and bGeral or (iOpcaoAssento = 3) and bVisitante then
        begin
            geraVendaIngresso(iTopoPilhaGeral, aAssentosGeral, TAMANHO_MAXIMO_GERAL, aFila, iUltimaPosicaoFila);
        end
    end;
end;

procedure exibirTotalArrecadado(iTotalArrecadadoArquibancada, iTotalArrecadadoSocios, iTotalArrecadadoGeral, iTotalArrecadadoVisitantes : integer);
begin
    iTotalRenda := iTotalArrecadadoArquibancada + iTotalArrecadadoSocios + iTotalArrecadadoGeral + iTotalArrecadadoVisitantes;

    textcolor(blue);
    writeln('Total Arrecadado por Tipo de Ingresso:');
    writeln('Arquibancada: R$ ', iTotalArrecadadoArquibancada);
    writeln('Sócios: R$ ', iTotalArrecadadoSocios);
    writeln('Geral: R$ ', iTotalArrecadadoGeral);
    writeln('Visitantes: R$ ', iTotalArrecadadoVisitantes);
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

    inicializaPilhaIngressos(aPilhaIngressosArquibancada, QUANTIDADE_INGRESSOS_ARQUIBANCADA, iTopoPilhaArquibancada);
    inicializaPilhaIngressos(aPilhaIngressosGeral, QUANTIDADE_INGRESSOS_GERAL, iTopoPilhaGeral);
    inicializaPilhaIngressos(aPilhaIngressosVisitante, QUANTIDADE_INGRESSOS_VISITANTE, iTopoPilhaVisitante );

    renderizaAssentos(aAssentosArquibancada, TAMANHO_MAXIMO_ARQUIBANCADA);
    renderizaAssentos(aAssentosGeral, TAMANHO_MAXIMO_GERAL);

    iOpcao := 0;

    while iOpcao <> 11 do 
    begin
        renderizaMenu(iOpcao);
        if iOpcao = 1 then 
            begin
                insereRegistroFila(aFilaSocios, iUltimaPosicaoFilaSocio, TAMANHO_MAXIMO_FILA_SOCIOS);
            end
        else if iOpcao = 2 then 
            begin
                insereRegistroFila(aFilaVisitantes, iUltimaPosicaoFilaVisitante, TAMANHO_MAXIMO_FILA_VISITANTES)
            end
        else if iOpcao = 3 then 
            begin
                insereRegistroFila(aFilaNormal, iUltimaPosicaoFilaNormal, TAMANHO_MAXIMO_FILA_NORMAL);
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
                vendeIngressoFilaConformeAtributos(aFilaSocios, iUltimaPosicaoFilaSocio, true, false, false);
            end
        else if iOpcao = 8 then 
            begin
                vendeIngressoFilaConformeAtributos(aFilaVisitantes, iUltimaPosicaoFilaVisitante, false, false, true);
            end
        else if iOpcao = 9 then 
            begin
                vendeIngressoFilaConformeAtributos(aFilaNormal, iUltimaPosicaoFilaNormal, true, true, false);
            end
        else if iOpcao = 10 then
            begin
                exibirTotalArrecadado(iTotalArrecadadoArquibancada, iTotalArrecadadoGeral, iTotalArrecadadoVisitantes, iTotalRenda);
            end;
    end;
end.