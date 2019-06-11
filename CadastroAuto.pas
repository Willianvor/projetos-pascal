Program CadastroAutomoveis;

uses crt;

label
menu, cadastrar, listar, procurar, fim;

const
F_NOME = 'banco.txt';

var
line, pModelo,
ler,corC,
mdlC  : string;
banco : text;
op 	  : char;
anoc,i,j: integer;

//adiciona novos cadastros
procedure addCarro(mdl, cor : String; ano : Integer);
var i, j : integer = 1;
begin

append(banco);

writeln(banco, 'MODELO: ', upcase(mdl));
writeln(banco, 'COR...: ', upcase(cor));
writeln(banco, 'ANO...: ', ano);
close(banco);

//cria um id por cadastro
reset(banco);
while not eof(banco) do
begin
	readln(banco, line);
	inc(j);
	if j = 5 then
	begin
		inc(i);
		j := 0;
	end;
end;
close(banco);
append(banco);
	writeln(banco, 'ID....: ', i);
	writeln(banco, '----------------------------');
close(banco);
end;

//barra de progresso
{ também funciona
procedure barraProgresso();
var i: integer;
s, d, e, t : string;
begin
s := '#';
e := '-------------------]';	 
for i:= 1 to 20 do
begin
	delay(25);	
	write(#13'[');
	d:=d+s;
	t:=copy(e, i, 20);
	write(d,t);
	write(' ', i*5, '%'); 
end;	 
writeln();  	
end;}

procedure barraProgresso; 
var i : Integer;
		j : real;
begin
  Write('[--------------------]');
  for i := 2 to 21 do
  begin 
    gotoXY(i, wherey);
    write('#');
    gotoxy(24, wherey);
    j := i/21*100;
    Write(j:0:2, '%');
    delay(50);
  end;
  writeln(); 
end;

//---------------------------------------------------
Begin

assign(banco, F_NOME);
append(banco);
write(''); 
close(banco);

repeat

menu:
clrscr;
writeln('----------- MENU -----------');
writeln('[1] CADASTRAR NOVO AUTOMOVEL');
writeln('[2] LISTAR TODOS OS CADASTROS');
writeln('[3] PROCURAR AUTOMOVEL');
writeln('[0] SAIR');				

op := readkey;

case (op) of 
  '1': goto cadastrar;
  '2': goto listar;
  '3': goto procurar;
  else goto fim;
end;

cadastrar:
clrscr;
writeln('NOVO CADASTRO');
write('MODELO: ');
readln(mdlC);
write('COR...: ');
readln(corC);
write('ANO...: ');
readln(anoC);    

addCarro(mdlC, corC, anoC);

clrscr;
barraProgresso();
writeln(); 
writeln('CADASTRO REALIZADO COM SUCESSO.');
writeln();
writeln('----------- MENU -----------');
writeln('[1] CADASTRAR NOVO AUTOMOVEL');
writeln('[2] LISTAR TODOS OS CADASTROS');
writeln('[3] PROCURAR POR MODELO');
writeln('[0] SAIR');

op := readkey;	

case (op) of 
  '1':  goto cadastrar;
  '2':  goto listar;
  '3':  goto procurar;
  else  goto fim;
end;

listar:
clrscr;

Reset(banco);
  
writeln('TODOS OS CADASTROS:');
writeln();

while not eof(banco) do
begin	
  readln(banco, ler);
  writeln(ler);
end;  
close(banco);
 
writeln('----------- MENU -----------');
writeln('[1] CADASTRAR NOVO AUTOMOVEL');
writeln('[2] LISTAR TODOS OS CADASTROS');
writeln('[3] PROCURAR POR MODELO');
writeln('[0] SAIR');

op := readkey;	

case (op) of 
  '1':  goto cadastrar;
  '2':  goto listar;
  '3':  goto procurar;
  else  goto fim;
end;

procurar:
clrscr;
j := 0;
i := 0;
write('PROCURAR POR MODELO: ');
readln(pModelo);
writeln();

reset(banco);
while not eof(banco) do begin
  readln(banco, line);
  
  if (pos('MODELO: ', line) > 0) then
  begin
    if (pos(upcase(pModelo), line) > 0) then
    begin
      writeln(line);
      
      for j:=1 to 4 do begin
      
      readln(banco, line);
      writeln(line);
      end;
      
      inc(i);
		end;
  end;
end;
  
writeln('CADASTROS ENCONTRADOS: ', i);
writeln('----------------------------');
close(banco);
  
writeln('----------- MENU -----------');
writeln('[1] CADASTRAR NOVO AUTOMOVEL');
writeln('[2] LISTAR TODOS OS CADASTROS');
writeln('[3] PROCURAR POR MODELO');
writeln('[0] SAIR');

op := readkey;	

case (op) of 
  '1':  goto cadastrar;
  '2':  goto listar;
  '3':  goto procurar;
  else  goto fim;
end;
  
fim:
close(banco);
until op = '0';
  
End.