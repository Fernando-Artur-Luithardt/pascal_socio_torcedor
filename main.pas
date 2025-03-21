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

procedure consulta_fila(f: vet; posi: integer; var el: integer; cor1, cor2: integer);
begin
  textcolor(cor1);
  if not FilaVazia(posi) then
  begin
    el := f[posi];
    writeln('Primeiro elemento ', el);
  end
  else 
    writeln('Fila vazia');
    readkey;
    textcolor(cor2);
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
var
    i: Integer;
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
    clrscr;
    textcolor(blue);
    writeln ('    MENU    ');
    writeln ('------------');
    writeln;
    writeln ('1 - Adicionar na fila de Sócios');
    writeln ('2 - Adicionar na fila de Visitantes');
    writeln ('3 - Adicionar na fila de Normal');


    writeln;
    write('    ==> ');
    textcolor(red);
    readln (op_menu);

    clrscr;
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
    while opcao <> 5 do 
    begin
        menu(opcao);
        if opcao = 1 then 
            insere_fila(fila_socios, ultima_pos_fila_socio, 1, tamanho_fila_socios)
        else if opcao = 2 then 
            insere_fila(fila_visitante, ultima_pos_fila_visitante, 1, tamanho_fila_visitante)
        else if opcao = 3 then 
            insere_fila(fila_normal, ultima_pos_fila_normal, 1, tamanho_fila_normal);
    end; 

end.
