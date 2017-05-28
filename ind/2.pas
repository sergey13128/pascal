type 
	tree=^elem;
	elem=record
		info:integer;
		left,right:tree;
	end;


procedure new_lawel(var q:tree; x:integer);
begin
	new(q);
	q^.info:=x;
	Q^.left:=nil;
	q^.right:=nil;
end;


procedure create(root:tree; x:integer);
var
	q:tree;
begin
		if x<root^.info then
			if root^.left=nil then begin
				new_lawel(q,x);
				root^.left:=q;
			end
			else
				create(root^.left,x)
		else
			if root^.right=nil then begin
				new_lawel(q,x);
				root^.right:=q;
			end
			else
				create(root^.right,x);
end;


procedure V_bypass(root:tree);
begin
	if root<>nil then begin
		V_bypass(root^.left);
		write(root^.info,' ');
		V_bypass(root^.right);
	end;
end;


function Multiplicity(root:tree; y:integer):boolean;
begin
	if root=nil then 
		Multiplicity:=true
	else 
		if root^.info mod y <> 0 then 
			Multiplicity:=false
		else 
			Multiplicity:=Multiplicity(root^.left,y) and Multiplicity(root^.right,y);
end;


function parity(x:integer):boolean;
var
	temp,sum:integer;
begin
	sum:=0;
	temp:=x;
	parity:=true;
	while temp>0 do begin
		sum:=sum+temp mod 10;
		temp:=temp div 10;
	end;
	if sum mod 2<> 0 then
		parity:=false;
end;


procedure Substitution(t:tree);
begin
	if t<> nil then begin
		if parity(t^.info)=true then
			t^.info:=t^.info*t^.info;
		Substitution(t^.left);
		Substitution(t^.right);
	end;
end;


var
	t:tree;
	x,y:integer;
begin
	new(t);
	writeln('введите X'); 
	readln(x);
	new_lawel(t,x);
	while x<>0 do begin
		readln(x);
		if x<>0 then
			create(t,x);
	end;
	V_bypass(t);
	write('Y=');
	readln(y);
	if Multiplicity(t,y)=false then begin
		Substitution(t);
		V_bypass(t);
	end
	else
		writeln('все элементы кратны',' ',y);
end.
