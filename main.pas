program fila_simples;
uses crt;

const 
  tamanho_fila_socios    = 500;
  tamanho_fila_visitante = 300;
  tamanho_fila_normal    = 2200;

type
  vet = array[1..tamanho_fila_socios] of integer;

var 
  fila: vet;
  opcao, ultima_pos_fila_socio, ultima_pos_fila_visitante, ultima_pos_fila_normal: integer;

procedure inicializa(var pos: integer);
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

function vazia(posicao: integer): boolean;
begin   
  vazia := posicao = 0;
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
  if vazia(posicao) then 
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
  if not vazia(posi) then
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
  if not vazia(posi) then
    for i := 1 to posi do
      write(f[i], ' ')
  else 
    writeln('Fila vazia');
  readkey;
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
  inicializa(ultima_pos_fila_socio);
  inicializa(ultima_pos_fila_visitante);
  inicializa(ultima_pos_fila_normal);
  
  opcao := 0;
  while opcao <> 5 do 
  begin
    menu(opcao);
    
    if opcao = 1 then 
      insere_fila(fila, ultima_pos_fila_socio, 1, tamanho_fila_socios)
    else if opcao = 2 then 
      insere_fila(fila, ultima_pos_fila_visitante, 1, tamanho_fila_visitante)
    else if opcao = 3 then 
        else if opcao = 3 then 
    else if opcao = 3 then 
        else if opcao = 3 then 
    else if opcao = 3 then 
        else if opcao = 3 then 
    else if opcao = 3 then 
        else if opcao = 3 then 
    else if opcao = 3 then 
        else if opcao = 3 then 
    else if opcao = 3 then 
        else if opcao = 3 then 
    else if opcao = 3 then 
      insere_fila(fila, ultima_pos_fila_normal, 1, tamanho_fila_normal);
  end;
end.
