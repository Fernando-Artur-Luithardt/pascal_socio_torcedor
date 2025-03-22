program fila_simples;
uses crt;

const 
    tamanho_fila_socios    = 500;
    tamanho_fila_visitante = 300;
    tamanho_fila_normal    = 2200;

    tamanho_arquibancada    = 2000;
    tamanho_geral           = 1000;

type
    vet     = array[1..5000] of integer;
    vetBool = array[1..2000] of boolean;

var 
    fila_socios:        vet;
    fila_visitante:     vet;
    fila_normal:        vet;

    pilha_arquibancada: vet;
    pilha_geral:        vet;
    pilha_visitante:    vet;

    opcao:                      integer;
    ultima_pos_fila_socio:      integer;
    ultima_pos_fila_visitante:  integer;
    ultima_pos_fila_normal:     integer;

    topo_pilha_arquibancada:    integer;
    topo_pilha_geral:           integer;
    topo_pilha_visitante:       integer;

    assentos_arquibancada:  vetBool;
    assentos_geral:         vetBool;

procedure fila_inicializa(var pos: integer);
begin
    pos := 0;
end;

procedure assentos_inicializa(var vetor_assentos: vetBool; max: integer);
var i: integer;
begin
  for i := 1 to max do
    vetor_assentos[i] := False;
end;

function fila_cheia(posicao, tamanho: integer): boolean;
begin   
    fila_cheia := posicao >= tamanho;
end;

function fila_vazia(posicao: integer): boolean;
begin   
    fila_vazia := posicao = 0;
end;

procedure fila_insere(var f: vet; var posicao: integer; elemento: integer; tamanho: integer);
begin
  if not fila_cheia(posicao, tamanho) then
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

procedure fila_remove(var fila: vet; var posicao: integer);
var i: integer;
begin
    if fila_vazia(posicao) then 
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
procedure fila_consulta(fila: vet; posi:integer);
var
    i: integer;
begin
    if fila_vazia(posi) 
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


function pilha_vazia(var topo:integer): Boolean;
begin
  pilha_vazia := (topo = 0);
end;

// Remove um elemento da pilha.
function pilha_remove(var topo: integer): boolean;
begin
    if pilha_vazia(topo) then
    begin
        WriteLn('Ingressos Esgotados.');
        pilha_remove := false;  // Retorna falso quando não pode remover
    end
    else
    begin
        topo := topo - 1;
        pilha_remove := true;  // Retorna true quando remove com sucesso
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

procedure vender_ingresso_fila(fila: vet; var posicao_fila: integer; disponivel_arq, disponivel_geral, disponivel_visitante: boolean);
var opcao_assento: integer;
begin
    if fila_vazia(posicao_fila) then
        writeln('Fila vazia')
    else
    begin
        escolher_assento(opcao_assento, disponivel_arq, disponivel_geral, disponivel_visitante);

        if (opcao_assento = 1) and disponivel_arq then
        begin
            if pilha_remove(topo_pilha_arquibancada) then
                fila_remove(fila, posicao_fila);
        end
        else if (opcao_assento = 2) and disponivel_geral then
        begin
            if pilha_remove(topo_pilha_geral) then
                fila_remove(fila, posicao_fila);
        end
        else if (opcao_assento = 3) and disponivel_visitante then
        begin
            if pilha_remove(topo_pilha_visitante) then
                fila_remove(fila, posicao_fila);
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
    fila_inicializa(ultima_pos_fila_socio);
    fila_inicializa(ultima_pos_fila_visitante);
    fila_inicializa(ultima_pos_fila_normal);

    assentos_inicializa(assentos_arquibancada, tamanho_arquibancada);
    assentos_inicializa(assentos_geral, tamanho_geral);

    topo_pilha_arquibancada := 2000;
    topo_pilha_geral        := 700;
    topo_pilha_visitante    := 300;

    opcao := 0;
    while opcao <> 10 do 
    begin
        menu(opcao);
        if opcao = 1 then 
            begin
                fila_insere(fila_socios, ultima_pos_fila_socio, 1, tamanho_fila_socios)
            end
        else if opcao = 2 then 
            begin
                fila_insere(fila_visitante, ultima_pos_fila_visitante, 1, tamanho_fila_visitante)
            end
        else if opcao = 3 then 
            begin
                fila_insere(fila_normal, ultima_pos_fila_normal, 1, tamanho_fila_normal);
            end
        else if opcao = 4 then 
            begin
                fila_consulta(fila_socios, ultima_pos_fila_socio);
            end
        else if opcao = 5 then 
            begin
                fila_consulta(fila_visitante, ultima_pos_fila_visitante);
            end
        else if opcao = 6 then 
            begin
                fila_consulta(fila_normal, ultima_pos_fila_normal);
            end
        else if opcao = 7 then 
            begin
                vender_ingresso_fila(fila_socios, ultima_pos_fila_socio, true, false, false);
            end
        else if opcao = 8 then 
            begin
                vender_ingresso_fila(fila_visitante, ultima_pos_fila_visitante, false, false, true);
            end
        else if opcao = 9 then 
            begin
                vender_ingresso_fila(fila_normal, ultima_pos_fila_normal, true, true, false);
            end;
    end; 

end.
