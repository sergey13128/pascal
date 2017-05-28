type
	HDD=object;
		Amount:integer;
		constructor Init_HDD;
		procedure Access_method
	end;

	Computer=object(HDD)
		Mark:string;
		Price:integer;
		constructor Init_Computer;
		destructor;
	end;

	Comp_monitor=object(Computer);
		size:integer;
		constructor Init_Comp_monitor;
		procedure Print;
		destructor;
	end;

constructor HDD.Init_HDD;
begin
	writeln('введите объем HDD в Мбайт');
	readln(Amount);
end;

constructor Computer.Init_Computer;
begin
	writeln('введите марку компьютера');
	readln(Mark);
	writeln('введите цену компьютера');
	readln(Price);
end;


