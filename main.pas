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

procedure remove_fila(var f: vet; var posicao, el: integer);
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
            el := f[1];
            writeln('Elemento Removido ', el);
            readkey;
            for i := 1 to posicao - 1 do
                f[i] := f[i + 1];
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

procedure escreve_fila(f: vet; posi: integer; texto: string);
var 
    i: integer;
begin
    writeln(texto);
    writeln;

    if not FilaVazia(posi) then
        for i := 1 to posi do
            write(f[i], ' ')
    else 
        writeln('Fila vazia');
        readkey;
end;


function PilhaVazia(var topo:integer): Boolean;
begin
  PilhaVazia := (topo = 0);
end;

// Remove um elemento da pilha.
procedure remove_pilha(var topo:integer);
begin
    if PilhaVazia(topo) then
        WriteLn('Ingressos Esgotados.')
    else
    begin
        topo := topo - 1;
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
            end;
    end; 

end.
