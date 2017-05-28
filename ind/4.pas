const
	N=100;
type
	adjacency_matrix = array[1..N, 1..N] of real;
	vert=set of 1..N;

function min(a,b:real):real;
begin
	if a>b then
		min:=b 
	else
		min:=a;
end;

function nearest_adjacent_unvisited_vertex(vertices,vertex : Integer; unvisited : vert; Matrix:adjacency_matrix) : Integer;
var
	minimal_distance:real;
	i : Integer;
begin
	minimal_distance:=maxint;
	for i:=1 to vertices do 
		if (i in unvisited) and (matrix[vertex,i] < minimal_distance) then
			minimal_distance:=matrix[vertex,i];

	for i:=1 to vertices do
		if (i in unvisited) and (matrix[vertex,i] = minimal_distance) then
			nearest_adjacent_unvisited_vertex:=i;
end;

function set_of_adjacent_vertex(vertices,vertex:integer; unvisited:vert; Matrix:adjacency_matrix): vert;
var
	i:integer;
begin
	for i:=1 to vertices do
		if (i in unvisited) and (matrix[vertex, i] < maxint) then 
			set_of_adjacent_vertex:=set_of_adjacent_vertex + [i];
end;

procedure build_graph(edges,vertices:integer; var Matrix:adjacency_matrix);
var
	i,start,finish:integer;
	length:real;
	t,loading:string;
begin
	writeln('граф ориентированный или нет?(y-да, n-нет)');
	readln(t);
	writeln('ребра графа нагружены или нет (y-да, n-нет)');
	readln(loading);
	for i:=1 to edges do begin
		length:=1;
		writeln('введите начало ребра');
		readln(start);
		writeln('введите конец ребра');
		readln(finish);
		if loading='y' then begin 
			writeln('введите длину ребра');
			readln(length);
		end;
		matrix[start,finish]:=length;
		if t='n' then
			matrix[finish,start]:=length;
	end;

	for i:=1 to vertices do
	matrix[i,i]:=0;
end;

procedure depth_bypass(vertices,vertex:integer; var unvisited:vert; Matrix:adjacency_matrix);
var
	w:integer;
begin
	unvisited:=unvisited-[vertex];
	write(vertex,' ');
	for w:=1 to vertices do 
		if( w in unvisited) and (matrix[vertex,w] <> 0) and (matrix[vertex,w] <> maxint) then
			depth_bypass(vertices ,w,unvisited,Matrix);
end;

procedure Dijkstra(vertices:integer; Matrix:adjacency_matrix);
var
	V,U:vert;
	D:array [1..N] of Real;
	i,w:integer;
begin
	V:=[2..vertices];
	for i:=2 to vertices do
		D[i]:=matrix[1,i];

	w:=1;
	while V<>[] do begin
		w:=nearest_adjacent_unvisited_vertex(vertices,w,V,matrix);
		V:=V-[w];
		U:=set_of_adjacent_vertex(vertices,w,V,matrix);
		for i:=2 to vertices do 
			if (i in U) and (D[w]+matrix[w,i] < D[i]) then
				D[i]:=D[w]+matrix[w,i];
	end;

	write('Кратчайшие пути из первой точки:');
	for i:=2 to vertices do
	write(D[i]:0:2,' ');
	writeln;
	writeln;
end;

procedure Floyd(vertices:integer; Matrix:adjacency_matrix);
var
	i,j,k:integer;
	shortests:array [1..N,1..N] of real;
begin
	for i:=1 to vertices do
		for j:=1 to vertices do
			shortests[i,j]:=matrix[i,j];

	for k:=1 to vertices do
		for i:=1 to vertices do
			for j:=1 to vertices do 
				shortests[i,j]:=min(shortests[i,j], shortests[i,k]+shortests[k,j]);

	Writeln ('Номера строк матрицы соответствуют начальным вершинам');
	Writeln ('Номера столбцов матрицы соответствуют конечным вершинам');
	Writeln ('Самые короткие пути между двумя вершинами:');
	for i:=1 to vertices do begin
		for j:=1 to vertices do begin
			if (shortests[i,j]=0) or (shortests[i,j]=maxint) then 
				write('none')
			else
				write(shortests[i,j]:0:2);
			write(^i^i);
		end;
		writeln;
	end;
	writeln;
end;

procedure Prim(vertices:integer; Matrix:adjacency_matrix);
var
	Results_matrix:array[1..2, 1..N] of real;
	set_vertex,Visited: vert;
	i,j,k,u1,v1:integer;
	minimal:real;
begin
	set_vertex:=[1..vertices];
	Visited:=[1];
	k:=0;

	while Visited<>set_vertex do begin
		minimal:=maxint;
		for i:=1 to vertices do
			for j:=1 to vertices do
				if (matrix[i,j]<minimal) and (i in Visited) and (j in (set_vertex - Visited)) then begin
					minimal:=matrix[i,j];
					u1:=i;
					v1:=j;
				end;

		Visited:=Visited + [v1];
		k:=k+1;
		Results_matrix[1,k]:=u1;
		Results_matrix[2,k]:=V1;
	end;

	writeln('результат работы Прима');
	for i:=1 to k do begin
		writeln(Results_matrix[1,i]:0:2,' ','->',' ',Results_matrix[2,i]:0:2,' ');
	end;
	writeln;
end;
	
procedure Kruskal(vertices:integer; matrix:adjacency_matrix);
var
	minimal:real;
	set_vertex,Visited: vert;
	i,j,k,p,z:integer;
	s: array [1..n] of real;
	Results_matrix: array[1..2, 1..N] of real;
begin
	z:=0;
	set_vertex:=[1..vertices];
	Visited:=[1];
	for i:=1 to vertices do
		s[i]:=i;
		
	while z < vertices - 1 do begin
		minimal:=maxint;
		for i:=1 to vertices do 
			for j:=1 to vertices do 
				if (matrix[i,j] < minimal) and (i in Visited) and (j in (set_vertex - Visited)) then begin
					minimal:=matrix[i,j];
					k:=i;
					p:=j;
				end;
				Visited:=Visited + [p];
		
			if s[k]<>s[p] then begin
				s[p]:=s[k];
				z:=z+1;
				Results_matrix[1,z]:=k;
				Results_matrix[2,z]:=p;
			end;
	end;

	writeln('результат работы Крускала');
	for i:=1 to z do begin
		writeln(Results_matrix[1,i]:0:2,' ','->',' ',Results_matrix[2,i]:0:2,' ');
	end;
	writeln;
end;

procedure f(vertices:integer; matrix:adjacency_matrix);
var
	Res,set_vertex,Visited:vert;
	i,j,k:integer;
	shortests:array [1..N,1..N] of real;
begin
	res:=[];
	Visited:=[1];
	set_vertex:=[1..vertices];
	for i:=1 to vertices do 
		for j:=1 to vertices do
			if (matrix[i,j] <> 0) and (matrix[i,j] <> maxint) then
				if (j in (set_vertex - Visited)) then 
					Visited:=Visited+[i]
				else
					res:=res+[i];
				
	for i:=1 to vertices do
		if (i in res) then
			writeln(i);
end;


var
	Matrix:adjacency_matrix;
	V:vert;
	vertices,edges:integer;
	i,j:integer;
begin
	writeln('введите число вершин графа');
	readln(vertices);
	writeln('введите число ребер графа');
	readln(edges);

	for i:=1 to vertices do
		for j:=1 to vertices do
			matrix[i,j]:=maxint;

	build_graph(edges,vertices,Matrix);
	Dijkstra(vertices,Matrix);
	Floyd(vertices,Matrix);
	Prim(vertices,Matrix);
	Kruskal(vertices,matrix);
	V:=[1..vertices];
	depth_bypass(vertices, 1,v,Matrix);

	writeln;
	writeln('индивидуалка');
	f(vertices,matrix);
end.

																															{вершин 6, ребер 9
																															1,2,7
																															1,3,9
																															1,6,14,
																															2,3,10,
																															2,4,15,
																															3,4,11,
																															3,6,2
																															4,5,6
																															6,5,9
																															}




