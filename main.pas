program fila_simples;
uses crt;

const 
    tamanho_fila_socios    = 500;
    tamanho_fila_visitante = 300;
    tamanho_fila_normal    = 2200;

type
    vet = array[1..5000] of integer;

var 
    fila_socios: vet;
    fila_visitante: vet;
    fila_normal: vet;
    opcao, ultima_pos_fila_socio, ultima_pos_fila_visitante, ultima_pos_fila_normal: integer;

var
    topo_pilha_arquibancada: integer;
    topo_pilha_geral: integer;
    topo_pilha_visitante: integer;

    pilha_arquibancada: vet;
    pilha_geral: vet;
    pilha_visitante: vet;


procedure inicializaFila(var pos: integer);
begin
    pos := 0;
end;

procedure ler_elemento(var el: integer);
begin
    writeln('Digite o elemento');
    readln(el);
end;

function cheia(posicao, tamanho: integer): boolean;
begin   
    cheia := posicao >= tamanho;
end;

function FilaVazia(posicao: integer): boolean;
begin   
    FilaVazia := posicao = 0;
end;

procedure insere_fila(var f: vet; var posicao: integer; elemento: integer; tamanho: integer);
begin
  if not cheia(posicao, tamanho) then
    begin
        posicao := posicao + 1;
        f[posicao] := elemento; 
    end
  else 
    begin
        writeln('Fila cheia');
        readkey;
    end;
end;

procedure remove_fila(var fila: vet; var posicao: integer);
var 
  i: integer;

begin
    if FilaVazia(posicao) then 
        begin
            writeln('Fila vazia');
            readkey;
        end
    else
        begin
            writeln('Removido da Fila');
            readkey;
            for i := 1 to posicao - 1 do
                fila[i] := fila[i + 1];
            posicao := posicao - 1;
        end;
end;

// Consulta o estado da fila.
procedure consulta_fila(fila: vet; posi:integer);
var
    i: integer;
begin
    if FilaVazia(posi) 
    then
        WriteLn('Fila vazia.')
    else
    begin
        Write('Fila: [');
        for i := 1 to posi do
        begin
            Write(fila[i]);
            if i < posi then
            Write(', ');
        end;
        WriteLn(']');
    end;
end;

procedure escreve_fila(fila: vet; posi: integer; texto: string);
var 
    i: integer;
begin
    writeln(texto);
    writeln;

    if not FilaVazia(posi) then
        for i := 1 to posi do
            write(fila[i], ' ')
    else 
        writeln('Fila vazia');
        readkey;
end;


function PilhaVazia(var topo:integer): Boolean;
begin
  PilhaVazia := (topo = 0);
end;

// Remove um elemento da pilha.
function remove_pilha(var topo: integer): boolean;
begin
    if PilhaVazia(topo) then
    begin
        WriteLn('Ingressos Esgotados.');
        remove_pilha := false;  // Retorna falso quando não pode remover
    end
    else
    begin
        topo := topo - 1;
        remove_pilha := true;  // Retorna true quando remove com sucesso
    end;
end;

procedure escolher_assento(var op_assento: integer; disponivel_arq, disponivel_geral, disponivel_visitante: boolean);
begin
    writeln;
    if disponivel_arq then writeln('1 - Arquibancada');
    if disponivel_geral then writeln('2 - Geral');
    if disponivel_visitante then writeln('3 - Visitante');

    readln(op_assento);
    
    // Enquanto a opção escolhida não for válida, continue pedindo entrada
    while not (
        ((op_assento = 1) and disponivel_arq) or 
        ((op_assento = 2) and disponivel_geral) or 
        ((op_assento = 3) and disponivel_visitante)
    ) do
    begin
        writeln('Opção inválida! Escolha um tipo de Assento:');
        readln(op_assento);
    end;
end;

procedure vender_fila(fila: vet; var posicao_fila: integer; disponivel_arq, disponivel_geral, disponivel_visitante: boolean);
var opcao_assento: integer;
begin
    if FilaVazia(posicao_fila) then
        writeln('Fila vazia')
    else
    begin
        escolher_assento(opcao_assento, disponivel_arq, disponivel_geral, disponivel_visitante);

        if (opcao_assento = 1) and disponivel_arq then
        begin
            if remove_pilha(topo_pilha_arquibancada) then
                remove_fila(fila, posicao_fila);
        end
        else if (opcao_assento = 2) and disponivel_geral then
        begin
            if remove_pilha(topo_pilha_geral) then
                remove_fila(fila, posicao_fila);
        end
        else if (opcao_assento = 3) and disponivel_visitante then
        begin
            if remove_pilha(topo_pilha_visitante) then
                remove_fila(fila, posicao_fila);
        end;
    end;
end;



procedure menu(var op_menu: integer);
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

    writeln ('10 - Sair');

    writeln;
    write('    ==> ');
    textcolor(red);
    readln (op_menu);
    textcolor(blue);
end;

{ Programa Principal }
begin
    clrscr;
    inicializaFila(ultima_pos_fila_socio);
    inicializaFila(ultima_pos_fila_visitante);
    inicializaFila(ultima_pos_fila_normal);

    topo_pilha_arquibancada := 2000;
    topo_pilha_geral        := 700;
    topo_pilha_visitante    := 300;

    opcao := 0;
    while opcao <> 10 do 
    begin
        menu(opcao);
        if opcao = 1 then 
            begin
                insere_fila(fila_socios, ultima_pos_fila_socio, 1, tamanho_fila_socios)
            end
        else if opcao = 2 then 
            begin
                insere_fila(fila_visitante, ultima_pos_fila_visitante, 1, tamanho_fila_visitante)
            end
        else if opcao = 3 then 
            begin
                insere_fila(fila_normal, ultima_pos_fila_normal, 1, tamanho_fila_normal);
            end
        else if opcao = 4 then 
            begin
                consulta_fila(fila_socios, ultima_pos_fila_socio);
            end
        else if opcao = 5 then 
            begin
                consulta_fila(fila_visitante, ultima_pos_fila_visitante);
            end
        else if opcao = 6 then 
            begin
                consulta_fila(fila_normal, ultima_pos_fila_normal);
            end
        else if opcao = 7 then 
            begin
                vender_fila(fila_socios, ultima_pos_fila_socio, true, false, false);
            end
        else if opcao = 8 then 
            begin
                vender_fila(fila_visitante, ultima_pos_fila_visitante, false, false, true);
            end
        else if opcao = 9 then 
            begin
                vender_fila(fila_normal, ultima_pos_fila_normal, true, true, false);
            end;
    end; 

end.
