type
    HDD = object
        capacity : Real;
        constructor Init(r : Real);
        function get_capacity : Real;
    end;

    computer = object(HDD)
        brand : String;
        price : Real;
        constructor Init(r : Real; b : String; p : Real);
        destructor Destroy;
    end;

    computer_with_monitor = object(computer)
        diag_screen : Real;
        procedure print;
        constructor Init(r : Real; b : String; p, c : Real);
        destructor Destroy;
    end;


constructor HDD.Init(r : Real);
begin
    capacity := r;
end;

function HDD.get_capacity : Real;
begin
    get_capacity := capacity;
end;


constructor computer.Init(r : Real; b : String; p : Real);
begin
    HDD.Init(r);
    brand := b;
    price := p;
end;

destructor computer.Destroy;
begin
    capacity  := 0;
    brand   := '';
    price   := 0;
end;


procedure computer_with_monitor.print;
begin
    writeln('Объем HDD: ',capacity:0:2);
    writeln('Марка компьютера: ',brand);
    writeln('Цена компьютера: ',price:0:2);
    writeln('Диагональ монитора: ',diag_screen:0:2);
    writeln;
end;

constructor computer_with_monitor.Init(r : Real; b : String; p, c : Real);
begin
    computer.Init(r, b, p);
    diag_screen := c;
end;

destructor computer_with_monitor.Destroy;
begin
    computer.Destroy;
    diag_screen := 0;
end;


var 
    t : computer_with_monitor;
    capacity, price, diag_screen : Real;
    brand                   : String;
begin
    write('введите объем HDD: '); readln(capacity);
    write('введите марку компьютера с монитором: '); readln(brand);
    write('Введите цену компьютера с монитором: '); readln(price);
    write('Введите диагональ монитора: '); readln(diag_screen);
    writeln;

    t.Init(capacity, brand, price, diag_screen);
    t.print;
    t.Destroy;
    t.print;
end.