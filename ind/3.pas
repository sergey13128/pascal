type
	list=^elem;
	elem=record
		info:string;
		next:list;
	end;

	line=object
		str:string;
		function quantity:integer; // количество максимально идущих подряд *
		procedure Deleting; // удаление второй трети строки
	end;

	UList=object(line)
		l:list;
		new_s:list;
		constructor Init; // инициализация списка
		procedure Insert(x:string; p:list); //добавление элемента в список
		procedure Delete(p:list); // удаление элемента из списка
		procedure Build_list; // построение списка
		procedure Print; // вывод списка на экран
		function Find(x:string):list; // поиск позиции элемента Х
		function Retreve(p:list):string; // поиск элемента Х в позиции Р
		function First:list; // вызывает первый элемент
		function EOL:list; // вызывает посдедний элемент
		procedure Transformation; // преобр список методом 2 объекта 1
		procedure new_list; // создает новый список "new_s" ,элем. которого, содержат "*">3
		procedure Substitution(s:string; p:list); //замена информ части
	end;

function Multiplicity(s:string; x:integer):boolean;
{проверка строки на кратность Х}
begin
	
	Multiplicity := length(s) mod x = 0;
end;

procedure Print_List(new_s:list);
var
	p:list;
begin
	p:=new_s;
	writeln('новый список, состоящий из элементов удовлетворяющих методу 1 объекта 1');
	while p<>nil do begin
		writeln(p^.info);
		p:=p^.next;
	end;
	writeln;
end;


function line.quantity:integer;
var
	temp,i:integer;
begin
	temp:=0;
	quantity:=0;
	for i:=1 to length(str) do 
		if (str[i]='*') and((str[i]=str[i-1]) or (str[i]=str[i+1])) then begin
			temp:=temp+1;
			if temp>quantity then 
				quantity:=temp;
		end
		else
			temp:=0;
end;


procedure line.Deleting;
begin
	if Multiplicity(str,3)=true then 
		Delete(str, length(str) div 3+1,length(str) div 3 );
end;


constructor UList.Init;
begin
	new(l);
	l^.info:='"список пуст"';
	l^.next:=nil;
end;

procedure UList.Insert(x:string; p:list);
var
	t:list;
begin;
	t:=p^.next;
	new(p^.next);
	p^.next^.info:=x;
	p^.next^.next:=t;
end;

procedure UList.Delete(p:list);
begin
	if p^.next<>nil then
		p^.next:=p^.next^.next;
end;

procedure UList.Substitution(s:string; p:list);
begin
	if p^.next<>nil then
		p^.info:=s;
end;

procedure UList.Build_list;
var
	x:string;
begin
	Init;
	writeln('введите список. Для закрытия списка введите "END"  ');
	readln(x);
	Insert(x,EOL);
	while x<>'END' do begin
		readln(x);
		if x<>'END' then
			Insert(x,EOL);;
	end;
	writeln;
end;

procedure UList.Print;
var
	t:list;
begin
	t:=first;
	while t <> nil do begin
    	writeln(t^.info, ' ');
        t := t^.next;
    end;
    writeln;
end;

function UList.Find(x:string):list;
var
	t:list;
begin
	find := nil;
    t := first;
    while t <> nil do begin
        if t^.info = x then 
            find := t;
        t := t^.next;
    end;
end;

function UList.Retreve(p:list):string;
begin
	if p^.next<> nil then 
		Retreve:=p^.info;
end;

function UList.First:list;
begin
	First:=l^.next;
end;

function UList.EOL:list;
var
	t:list;
begin
    t := l;
    while t^.next <> nil do
        t := t^.next;
    EOL := t;
end;

procedure UList.Transformation;
var
	t:list;
begin
	t := first;
	while t<> nil do begin
		str:=Retreve(t);
		Deleting;
		Substitution(str,t);
		t:=t^.next;
	end;
end;

procedure Ulist.new_list;
var
	p,q,t:list;
	b:boolean;
begin
	t:=first;
	b:=true;
	new_s^.info:='"список пуст"';
	while t<>nil do begin
		str:=Retreve(t);
		If (quantity > 3) and (b=false) then begin
			new(q);
			q^.info:=str;
			p^.next:=q;
			p:=q;
		end;

		if (b=true) and (quantity >3) then begin
			new_s^.info:=str;
			b:=false;
			p:=new_s;
		end;
		t:=t^.next;
	end;
	p^.next:=nil;
end;

var
	s:UList;
begin
	s.Build_list;
	writeln('список, который ввели:');
	s.Print;
	new(s.new_s);
	s.new_list;	
	Print_List(s.new_s);
	s.Transformation;
	writeln('преобразованный список');
	s.Print;
end.